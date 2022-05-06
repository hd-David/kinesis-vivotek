set -euxo pipefail
export AWS_PROFILE=darwinist
export AWS_DEFAULT_REGION=eu-central-1
export GIT_SHA=$(git rev-parse --short HEAD)
export SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

export THING_TYPE_NAME=thing_type_$GIT_SHA
export THING_NAME=thing_stream_$GIT_SHA
export IAM_ROLE_NAME=kvs_iamrole_$GIT_SHA
export IAM_POLICY_NAME=kvs_policy_$GIT_SHA
export IAM_ROLE_ALIAS=kvs_iamrole_alias_$GIT_SHA
export IOT_POLICY_NAME=kvs_iotpolicy_$GIT_SHA
export GIT_SHA_PATH=$SCRIPTPATH/$GIT_SHA

mkdir $GIT_SHA

aws iot create-thing-type --thing-type-name $THING_TYPE_NAME \
        > $SCRIPTPATH/$GIT_SHA/iot-thing-type.json

aws iot create-thing \
    --thing-name $THING_NAME \
    --thing-type-name $THING_TYPE_NAME \
        > $GIT_SHA_PATH/iot-thing.json

aws iam create-role \
    --role-name $IAM_ROLE_NAME \
    --assume-role-policy-document "file://$SCRIPTPATH/iam-policy-document.json" \
        > $GIT_SHA_PATH/iam-role.json

aws iam put-role-policy \
    --role-name $IAM_ROLE_NAME \
    --policy-name $IAM_POLICY_NAME \
    --policy-document 'file://$SCRIPTPATH/iam-permission-document.json'

aws iot create-role-alias \
    --role-alias $IAM_ROLE_ALIAS \
    --role-arn $(jq --raw-output '.Role.Arn' $GIT_SHA_PATH/iam-role.json) \
    --credential-duration-seconds 3600 > $GIT_SHA_PATH/iot-role-alias.json

cat > $GIT_SHA_PATH/iot-policy-document.json <<EOF
{
	"Version": "2012-10-17",
	"Statement": [{
			"Effect": "Allow",
			"Action": [
				"iot:Connect"
			],
			"Resource": "$(jq --raw-output '.roleAliasArn' $GIT_SHA_PATH/iot-role-alias.json)"
		},
		{
			"Effect": "Allow",
			"Action": [
				"iot:AssumeRoleWithCertificate"
			],
			"Resource": "$(jq --raw-output '.roleAliasArn' $GIT_SHA_PATH/iot-role-alias.json)"
		}
	]
}
EOF
aws iot create-policy --policy-name $IOT_POLICY_NAME \
    --policy-document 'file://$GIT_SHA_PATH/iot-policy-document.json'

aws iot create-keys-and-certificate --set-as-active \
    --certificate-pem-outfile $GIT_SHA_PATH/certificate.pem \
    --public-key-outfile $GIT_SHA_PATH/public.pem.key \
    --private-key-outfile $GIT_SHA_PATH/private.pem.key \
        > $GIT_SHA_PATH/certificate

aws iot attach-policy \
    --policy-name $IOT_POLICY_NAME \
    --target $(jq --raw-output '.certificateArn' $GIT_SHA_PATH/certificate)

aws iot attach-thing-principal \
    --thing-name $THING_NAME \
    --principal $(jq --raw-output '.certificateArn' $GIT_SHA_PATH/certificate)

aws iot describe-endpoint \
    --endpoint-type iot:CredentialProvider \
    --output text \
        > $GIT_SHA_PATH/iot-credential-provider.txt

curl --silent 'https://www.amazontrust.com/repository/SFSRootCAG2.pem' \
    --output $GIT_SHA_PATH/cacert.pem

aws kinesisvideo create-stream \
    --data-retention-in-hours 24 \
    --stream-name $THING_NAME
    
export IOT_GET_CREDENTIAL_ENDPOINT=$(cat $GIT_SHA_PATH/iot-credential-provider.txt)

curl --silent -H "x-amzn-iot-thingname: $THING_NAME" \
    https://$IOT_GET_CREDENTIAL_ENDPOINT/role-aliases/$IAM_ROLE_ALIAS/credentials \
    --cert $GIT_SHA_PATH/certificate.pem \
    --key $GIT_SHA_PATH/private.pem.key \
    --cacert $GIT_SHA_PATH/cacert.pem \
        > $GIT_SHA_PATH/token.json

export AWS_ACCESS_KEY_ID=$(jq --raw-output '.credentials.accessKeyId' $GIT_SHA_PATH/token.json)
export AWS_SECRET_ACCESS_KEY=$(jq --raw-output '.credentials.secretAccessKey' $GIT_SHA_PATH/token.json)
export AWS_SESSION_TOKEN=$(jq --raw-output '.credentials.sessionToken' $GIT_SHA_PATH/token.json)

aws kinesisvideo describe-stream --stream-name $THING_NAME

echo THING_TYPE_NAME = $THING_TYPE_NAME >> $GIT_SHA_PATH/output
echo THING_NAME      = $THING_NAME >> $GIT_SHA_PATH/output
echo IAM_ROLE_NAME   = $IAM_ROLE_NAME >> $GIT_SHA_PATH/output
echo IAM_POLICY_NAME = $IAM_POLICY_NAME >> $GIT_SHA_PATH/output
echo IAM_ROLE_ALIAS  = $IAM_ROLE_ALIAS >> $GIT_SHA_PATH/output
echo IOT_POLICY_NAME = $IOT_POLICY_NAME >> $GIT_SHA_PATH/output
echo GIT_SHA_PATH    = $GIT_SHA_PATH >> $GIT_SHA_PATH/output

cat > $GIT_SHA_PATH/renew-token.sh <<EOF
curl --silent -H "x-amzn-iot-thingname: $THING_NAME" \
    https://$IOT_GET_CREDENTIAL_ENDPOINT/role-aliases/$IAM_ROLE_ALIAS/credentials \
    --cert $GIT_SHA_PATH/certificate.pem \
    --key $GIT_SHA_PATH/private.pem.key \
    --cacert $GIT_SHA_PATH/cacert.pem \
        > $GIT_SHA_PATH/token.json
echo EXPIRY=$(jq --raw-output '.credentials.accessKeyId' $GIT_SHA_PATH/token.json)
echo AWS_ACCESS_KEY_ID=$(jq --raw-output '.credentials.accessKeyId' $GIT_SHA_PATH/token.json)
echo AWS_SECRET_ACCESS_KEY=$(jq --raw-output '.credentials.secretAccessKey' $GIT_SHA_PATH/token.json)
echo AWS_SESSION_TOKEN=$(jq --raw-output '.credentials.sessionToken' $GIT_SHA_PATH/token.json)
echo EXPIRATION=$(jq --raw-output '.credentials.expiration' $GIT_SHA_PATH/token.json)
EOF