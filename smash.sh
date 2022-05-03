set -euxo pipefail
export AWS_PROFILE=darwinist
export AWS_DEFAULT_REGION=eu-central-1
export GIT_SHA=$(git rev-parse --short HEAD)
export SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

mkdir $GIT_SHA

aws iot create-thing-type --thing-type-name thing_type_$GIT_SHA \
        > $SCRIPTPATH/$GIT_SHA/iot-thing-type.json

aws iot create-thing \
    --thing-name thing_$GIT_SHA \
    --thing-type-name kvs_stream_$GIT_SHA \
        > $SCRIPTPATH/$GIT_SHA/iot-thing.json

aws iam create-role \
    --role-name kvs_iamrole_$GIT_SHA \
    --assume-role-policy-document "file://$SCRIPTPATH/iam-policy-document.json" \
        > $SCRIPTPATH/$GIT_SHA/iam-role.json

aws iam put-role-policy \
    --role-name kvs_iamrole_$GIT_SHA \
    --policy-name kvs_policy_$GIT_SHA \
    --policy-document 'file://$SCRIPTPATH/iam-permission-document.json'

aws iot create-role-alias \
    --role-alias kvs_iamrole_alias_$GIT_SHA \
    --role-arn $(jq --raw-output '.Role.Arn' $SCRIPTPATH/$GIT_SHA/iam-role.json) \
    --credential-duration-seconds 3600 > $SCRIPTPATH/$GIT_SHA/iot-role-alias.json

cat > $SCRIPTPATH/$GIT_SHA/iot-policy-document.json <<EOF
{
	"Version": "2012-10-17",
	"Statement": [{
			"Effect": "Allow",
			"Action": [
				"iot:Connect"
			],
			"Resource": "$(jq --raw-output '.roleAliasArn' $SCRIPTPATH/$GIT_SHA/iot-role-alias.json)"
		},
		{
			"Effect": "Allow",
			"Action": [
				"iot:AssumeRoleWithCertificate"
			],
			"Resource": "$(jq --raw-output '.roleAliasArn' $SCRIPTPATH/$GIT_SHA/iot-role-alias.json)"
		}
	]
}
EOF
aws iot create-policy --policy-name kvs_iotpolicy_$GIT_SHA \
    --policy-document 'file://$SCRIPTPATH/$GIT_SHA/iot-policy-document.json'

aws iot create-keys-and-certificate --set-as-active \
    --certificate-pem-outfile $SCRIPTPATH/$GIT_SHA/certificate.pem \
    --public-key-outfile $SCRIPTPATH/$GIT_SHA/public.pem.key \
    --private-key-outfile $SCRIPTPATH/$GIT_SHA/private.pem.key \
        > $SCRIPTPATH/$GIT_SHA/certificate

aws iot attach-policy \
    --policy-name kvs_iotpolicy_$GIT_SHA \
    --target $(jq --raw-output '.certificateArn' $SCRIPTPATH/$GIT_SHA/certificate)

aws iot attach-thing-principal \
    --thing-name kvs_stream_$GIT_SHA \
    --principal $(jq --raw-output '.certificateArn' $SCRIPTPATH/$GIT_SHA/certificate)

aws iot describe-endpoint \
    --endpoint-type iot:CredentialProvider \
    --output text \
        > $SCRIPTPATH/$GIT_SHA/iot-credential-provider.txt

curl --silent 'https://www.amazontrust.com/repository/SFSRootCAG2.pem' \
    --output $SCRIPTPATH/$GIT_SHA/cacert.pem

aws kinesisvideo create-stream \
    --data-retention-in-hours 24 \
    --stream-name kvs_stream_$GIT_SHA 
    
export IOT_GET_CREDENTIAL_ENDPOINT=$(cat  $SCRIPTPATH/$GIT_SHA/iot-credential-provider.txt)

curl --silent -H "x-amzn-iot-thingname: kvs_stream_$GIT_SHA" \
    https://$IOT_GET_CREDENTIAL_ENDPOINT/role-aliases/kvs_iamrole_alias_$GIT_SHA/credentials \
    --cert $SCRIPTPATH/$GIT_SHA/certificate.pem \
    --key $SCRIPTPATH/$GIT_SHA/private.pem.key \
    --cacert $SCRIPTPATH/$GIT_SHA/cacert.pem \
        > $SCRIPTPATH/$GIT_SHA/token.json

export AWS_ACCESS_KEY_ID=$(jq --raw-output '.credentials.accessKeyId' $SCRIPTPATH/$GIT_SHA/token.json)
export AWS_SECRET_ACCESS_KEY=$(jq --raw-output '.credentials.secretAccessKey' $SCRIPTPATH/$GIT_SHA/token.json)
export AWS_SESSION_TOKEN=$(jq --raw-output '.credentials.sessionToken' $SCRIPTPATH/$GIT_SHA/token.json)

aws kinesisvideo describe-stream --stream-name kvs_stream_$GIT_SHA