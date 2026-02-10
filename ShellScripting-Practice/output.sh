{
    "Groups": [],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-0220d79f3f480ecf5",
            "InstanceId": "i-0e8b7ece8a6670435",
            "InstanceType": "t2.micro",
            "LaunchTime": "2026-02-10T04:13:49+00:00",
            "Monitoring": {
                "State": "disabled"
            },
            "Placement": {
                "AvailabilityZone": "us-east-1d",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-172-31-30-125.ec2.internal",
            "PrivateIpAddress": "172.31.30.125",
            "ProductCodes": [],
            "PublicDnsName": "",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "StateTransitionReason": "",
            "SubnetId": "subnet-0728da6428227b693",
            "VpcId": "vpc-09512b44c056b532d",
            "Architecture": "x86_64",
            "BlockDeviceMappings": [],
            "ClientToken": "468d7595-6b14-4935-96d6-5f700040d500",
            "EbsOptimized": false,
            "EnaSupport": true,
            "Hypervisor": "xen",
            "NetworkInterfaces": [
                {
                    "Attachment": {
                        "AttachTime": "2026-02-10T04:13:49+00:00",
                        "AttachmentId": "eni-attach-0a52713b81a6c3302",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attaching",
                        "NetworkCardIndex": 0
                    },
                    "Description": "",
                    "Groups": [
                        {
                            "GroupName": "allow-all-ssh-from-internet",
                            "GroupId": "sg-05070ca66b56218cd"
                        }
                    ],
                    "Ipv6Addresses": [],
                    "MacAddress": "0a:ff:c1:e9:67:a7",
                    "NetworkInterfaceId": "eni-0655662ea14990e9b",
                    "OwnerId": "193849563622",
                    "PrivateDnsName": "ip-172-31-30-125.ec2.internal",
                    "PrivateIpAddress": "172.31.30.125",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateDnsName": "ip-172-31-30-125.ec2.internal",
                            "PrivateIpAddress": "172.31.30.125"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-0728da6428227b693",
                    "VpcId": "vpc-09512b44c056b532d",
                    "InterfaceType": "interface"
                }
            ],
            "RootDeviceName": "/dev/sda1",
            "RootDeviceType": "ebs",
            "SecurityGroups": [
                {
                    "GroupName": "allow-all-ssh-from-internet",
                    "GroupId": "sg-05070ca66b56218cd"
                }
            ],
            "SourceDestCheck": true,
            "StateReason": {
                "Code": "pending",
                "Message": "pending"
            },
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "MyTestInstance"
                }
            ],
            "VirtualizationType": "hvm",
            "CpuOptions": {
                "CoreCount": 1,
                "ThreadsPerCore": 1
            },
            "CapacityReservationSpecification": {
                "CapacityReservationPreference": "open"
            },
            "MetadataOptions": {
                "State": "pending",
                "HttpTokens": "optional",
                "HttpPutResponseHopLimit": 1,
                "HttpEndpoint": "enabled",
                "HttpProtocolIpv6": "disabled",
                "InstanceMetadataTags": "disabled"
            },
            "EnclaveOptions": {
                "Enabled": false
            },
            "BootMode": "uefi-preferred",
            "PrivateDnsNameOptions": {
                "HostnameType": "ip-name",
                "EnableResourceNameDnsARecord": false,
                "EnableResourceNameDnsAAAARecord": false
            },
            "MaintenanceOptions": {
                "AutoRecovery": "default"
            },
            "CurrentInstanceBootMode": "legacy-bios"
        }
    ],
    "OwnerId": "193849563622",
    "ReservationId": "r-0676c159852e8f52b"
}
