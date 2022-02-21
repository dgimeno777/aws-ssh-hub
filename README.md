# aws-ssh-hub
This repo is for exploring AWS-hosted options for a SSH hub to forward users to private instances

# Network Load Balancer
A Network-type Elastic Load Balancer can be used to forward traffic to target groups for simple SSH access.
NLBs do not support path-based routing so it cannot be used to connect specific users to specific machines over the same port.
However, an NLB listener can forward traffic from a designated port to another port on a target group meaning that SSH traffic from different ports can be forwarded to the SSH port of different target groups.
If the target group only has a single member then all traffic will be routed to the same instance.
If multiple listeners are attached then a single NLB can be used as a "hub" for multiple private instances accessible via SSH.

## NLB Diagram
![NLB SSH Hub Diagram](./res/nlb/NLBSSHHub.png?raw=true)

## NLB Upsides
1. NLB is fully managed by AWS
2. NLB does port forwarding so traffic is directly sent to the instance at the listener port
3. Users can be given a static command like `ssh user@1.2.3.4 -p 5000` for SSH'ing into an instance

## NLB Downsides
1. Pay for traffic processed by NLB which makes SSH-based file transfer expensive (mitigate with S3 VPC endpoints)
2. Only 50 listeners per NLB (# instances * # ports open per instance <= 50)

# Bastion
A bastion host or jumpbox is used to create a DMZ for accessing private instances and resources. While a bastion can
be used as an SSH jumpbox it's difficult to manage the commands and configuration required to make the setup seamless
for a user who only cares about being able to SSH into the instance.

## Bastion Upsides
1. Allow any number of ports to be listening

## Bastion Downsides
1. A bastion host must be maintained and managed requiring regular updates and hardening
2. Path-based SSH forwarding cannot be natively done like with an NLB
3. Setting up seamless SSH into a private instance would require adding specific entries to their SSH config file
