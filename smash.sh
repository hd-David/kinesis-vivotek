

aws iot create-thing-type --thing-type-name kvs_5182_test > iot-thing-type.json
aws iot create-thing --thing-name kvs_5182_stream --thing-type-name kvs_5182_test > iot-thing.json
aws iam create-role --role-name kvs_pm5182_iamrole --assume-role-policy-document
'file://iam-policy-document.json' > iam-role.json
aws iam put-role-policy --role-name kvs_pm5182_iamrole --policy-name kvs_pm5182_iamrole_policy
--policy-document 'file://iam-permission-document.json'
aws iot create-role-alias --role-alias kvs_pm5182_iamrole_alias --role-arn $(jq --raw-output '.Role.Arn'
iam-role.json) --credential-duration-seconds 3600 > iot-role-alias.json
cat > iot-policy-document.json <<EOF
{
	"Version": "2012-10-17",
	"Statement": [{
			"Effect": "Allow",
			"Action": [
				"iot:Connect"
			],
			"Resource": "$(jq --raw-output '.roleAliasArn' iot-role-alias.json)"
		},
		{
			"Effect": "Allow",
			"Action": [
				"iot:AssumeRoleWithCertificate"
			],
			"Resource": "$(jq --raw-output '.roleAliasArn' iot-role-alias.json)"
		}
	]
}
EOF
aws iot create-policy --policy-name kvs_pm5182_iotpolicy --policy-document 'file://iot-policy-document.json'
aws iot create-keys-and-certificate --set-as-active --certificate-pem-outfile certificate.pem --public-key-outfile
public.pem.key --private-key-outfile private.pem.key > certificate
aws iot attach-policy --policy-name kvs_pm5182_iotpolicy --target $(jq --raw-output '.certificateArn' certificate)
aws iot attach-thing-principal --thing-name kvs_5182_stream --principal $(jq --raw-output '.certificateArn'
certificate)
aws iot describe-endpoint --endpoint-type iot:CredentialProvider --output text > iot-credential-provider.txt