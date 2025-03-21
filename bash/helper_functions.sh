aws_check_if_instype_in_az () { 
    aws ec2 describe-instance-type-offerings --location-type availability-zone --filters Name=instance-type,Values=$*
}

get_ip_info () {
    curl "https://api.ipapi.is?q=$1" 2> /dev/zero
}
