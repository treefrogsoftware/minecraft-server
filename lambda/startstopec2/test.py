import boto3

ec2 = boto3.client('ec2')
response = ec2.describe_instances()

for instance in response['Reservations']: 
#   print(instance['State'])
#   print(instance['Tags'][0]['Value'])
    print(instance['Instances'][0]['Tags'][0]['Value'],  instance['Instances'][0]['State']['Name'])

