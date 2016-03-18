old_ip=`aws ec2 describe-instances --output json --region us-west-2 | grep -iw PublicIpAddress | cut -d: -f2 | tr -d '"' | tr -d ','`

echo $old_ip

new_ip=`aws ec2 allocate-address --domain vpc | grep -iw PublicIp | cut -d: -f2 | tr -d '"' | tr -d ','`

echo $new_ip


associate_ip="aws ec2 associate-address --instance-id i-03547feb4de27c586 --public-ip $new_ip"

eval $associate_ip
#echo $associate_ip

cur_ip=`aws ec2 describe-instances --output json --region us-west-2 | grep -iw PublicIpAddress | cut -d: -f2 | tr -d '"' | tr -d ','`

echo $cur_ip

alloc_id=`aws ec2 describe-addresses --public-ip $old_ip | grep -iw AllocationId | cut -d: -f2 | tr -d '"' | tr -d ','`

echo $alloc_id

#alloc_id1 = eval $alloc_id

#echo $alloc_id1

release_ip="aws ec2 release-address --allocation-id $alloc_id"

eval $release_ip