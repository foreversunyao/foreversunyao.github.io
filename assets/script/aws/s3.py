import boto3
session = boto3.Session(profile_name='')
s3_client = session.client('s3')
print(s3_client.list_buckets())
