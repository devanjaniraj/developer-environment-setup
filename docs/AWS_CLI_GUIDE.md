# AWS CLI Configuration Guide

## Installation

### Windows
```powershell
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi
```

### macOS
```bash
brew install awscli
```

### Linux
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

## Configuration

```bash
# Configure AWS credentials
aws configure

# Set specific profile
aws configure --profile production

# List profiles
aws configure list-profiles

# View configuration
aws configure list
```

## Common AWS CLI Commands

### S3 Operations

```bash
# List buckets
aws s3 ls

# Create bucket
aws s3 mb s3://my-bucket-name

# Upload file
aws s3 cp file.txt s3://my-bucket/

# Upload directory
aws s3 cp mydir/ s3://my-bucket/mydir/ --recursive

# Download file
aws s3 cp s3://my-bucket/file.txt ./

# Sync directories
aws s3 sync ./local-dir s3://my-bucket/remote-dir

# Delete file
aws s3 rm s3://my-bucket/file.txt

# Delete bucket
aws s3 rb s3://my-bucket --force
```

### EC2 Operations

```bash
# List instances
aws ec2 describe-instances

# Start instance
aws ec2 start-instances --instance-ids i-1234567890abcdef0

# Stop instance
aws ec2 stop-instances --instance-ids i-1234567890abcdef0

# Create instance
aws ec2 run-instances \
  --image-id ami-0c55b159cbfafe1f0 \
  --instance-type t2.micro \
  --key-name MyKeyPair \
  --security-group-ids sg-903004f8 \
  --subnet-id subnet-6e7f829e

# Terminate instance
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0
```

### Lambda Operations

```bash
# List functions
aws lambda list-functions

# Invoke function
aws lambda invoke \
  --function-name my-function \
  --payload '{"key": "value"}' \
  response.json

# Create function
aws lambda create-function \
  --function-name my-function \
  --runtime nodejs20.x \
  --role arn:aws:iam::123456789012:role/lambda-role \
  --handler index.handler \
  --zip-file fileb://function.zip

# Update function code
aws lambda update-function-code \
  --function-name my-function \
  --zip-file fileb://function.zip
```

### RDS Operations

```bash
# List DB instances
aws rds describe-db-instances

# Create DB instance
aws rds create-db-instance \
  --db-instance-identifier mydb \
  --db-instance-class db.t3.micro \
  --engine postgres \
  --master-username admin \
  --master-user-password password123 \
  --allocated-storage 20

# Delete DB instance
aws rds delete-db-instance \
  --db-instance-identifier mydb \
  --skip-final-snapshot
```

### CloudFormation

```bash
# Create stack
aws cloudformation create-stack \
  --stack-name my-stack \
  --template-body file://template.yaml

# Update stack
aws cloudformation update-stack \
  --stack-name my-stack \
  --template-body file://template.yaml

# Delete stack
aws cloudformation delete-stack --stack-name my-stack

# Describe stack
aws cloudformation describe-stacks --stack-name my-stack
```

### IAM Operations

```bash
# List users
aws iam list-users

# Create user
aws iam create-user --user-name new-user

# Create access key
aws iam create-access-key --user-name new-user

# List policies
aws iam list-policies

# Attach policy
aws iam attach-user-policy \
  --user-name new-user \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
```

## AWS CLI Tips

### Use Output Formats

```bash
# JSON (default)
aws ec2 describe-instances --output json

# Table
aws ec2 describe-instances --output table

# Text
aws ec2 describe-instances --output text

# YAML
aws ec2 describe-instances --output yaml
```

### Query Results with JMESPath

```bash
# Get specific fields
aws ec2 describe-instances \
  --query 'Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress]' \
  --output table

# Filter results
aws ec2 describe-instances \
  --query 'Reservations[*].Instances[?State.Name==`running`]'
```

### Use Profiles

```bash
# Set default profile
export AWS_PROFILE=production

# Use profile in command
aws s3 ls --profile production
```

### Dry Run

```bash
# Test command without executing
aws ec2 stop-instances --instance-ids i-1234567890abcdef0 --dry-run
```

## Environment Variables

```bash
# AWS credentials
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-east-1

# AWS profile
export AWS_PROFILE=production
```

## AWS CLI Configuration File

`~/.aws/config`:

```ini
[default]
region = us-east-1
output = json

[profile production]
region = us-west-2
output = json

[profile development]
region = us-east-1
output = table
```

`~/.aws/credentials`:

```ini
[default]
aws_access_key_id = AKIAIOSFODNN7EXAMPLE
aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

[production]
aws_access_key_id = AKIAIOSFODNN7EXAMPLE
aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

## Best Practices

1. **Use IAM roles** when possible instead of access keys
2. **Never commit credentials** to version control
3. **Use MFA** for sensitive operations
4. **Set up budget alerts** to monitor costs
5. **Use least privilege principle** for permissions
6. **Enable CloudTrail** for audit logging
7. **Rotate credentials** regularly
8. **Use AWS Secrets Manager** for sensitive data

## Useful Resources

- [AWS CLI Documentation](https://docs.aws.amazon.com/cli/)
- [AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/)
- [JMESPath Tutorial](https://jmespath.org/tutorial.html)
