aws ec2 run-instances --image-id ami-9abea4fb --count 1 --instance-type t2.nano --key-name aws-node --security-group-ids sg-46b22121 --subnet-id subnet-62e42306

"PublicDnsName": "ec2-52-37-169-158.us-west-2.compute.amazonaws.com", 
                    "PublicIpAddress": "52.37.169.158", 
                    "PrivateIpAddress": "172.31.16.236", 
                    "InstanceId": "i-03547feb4de27c586", 
                    "ImageId": "ami-9abea4fb", 

aws ec2 terminate-instances --instance-ids i-02dd8194a32157c9b

{
    "TerminatingInstances": [
        {
            "InstanceId": "i-02dd8194a32157c9b", 
            "CurrentState": {
                "Code": 32, 
                "Name": "shutting-down"
            }, 