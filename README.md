

- 91.99.66.138
- 157.90.237.40
- 195.201.19.114
- 10.129.16.1
- 10.129.16.2
- 10.129.16.3
- 10.129.16.4

#Host1
ip link add provider0 type vxlan id 16 local 91.99.66.138 dstport 0
bridge fdb append to 00:00:00:00:00:00 dst 157.90.237.40 dev provider0
bridge fdb append to 00:00:00:00:00:00 dst 195.201.19.114 dev provider0
ip addr add 10.129.16.1/23 dev provider0
ip link set up dev provider0

#Host2
ip link add provider0 type vxlan id 16 local 157.90.237.40 dstport 0
bridge fdb append to 00:00:00:00:00:00 dst 91.99.66.138 dev provider0
bridge fdb append to 00:00:00:00:00:00 dst 195.201.19.114 dev provider0
ip addr add 10.129.16.2/23 dev provider0
ip link set up dev provider0

#Host3
ip link add provider0 type vxlan id 16 local 195.201.19.114 dstport 0
bridge fdb append to 00:00:00:00:00:00 dst 91.99.66.138 dev provider0
bridge fdb append to 00:00:00:00:00:00 dst 157.90.237.40 dev provider0
ip addr add 10.129.16.3/23 dev provider0
ip link set up dev provider0


lighthou  10.99.10.254
oracleBV  10.99.10.12
oracleKM  10.99.10.11
contabo   10.99.10.13

ip addr add 10.129.16.1/24 dev vx0



#Host1 oracle bv
ip link delete vx0
ip link add vx0 type vxlan id 16 local 10.99.10.12 dstport 0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.254 dev vx0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.11 dev vx0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.13 dev vx0
ip addr add 10.129.16.1/24 dev vx0
ip link set up dev vx0

#Host2 oracle km
ip link delete vx0
ip link add vx0 type vxlan id 16 local 10.99.10.11 dstport 0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.254 dev vx0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.12 dev vx0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.13 dev vx0
ip addr add 10.129.16.2/24 dev vx0
ip link set up dev vx0

#Host3 contabo
ip link delete vx0
ip link add vx0 type vxlan id 16 local 10.99.10.13 dstport 0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.254 dev vx0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.12 dev vx0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.11 dev vx0
ip addr add 10.129.16.3/24 dev vx0
ip link set up dev vx0

#Host4 light
ip link delete vx0
ip link add vx0 type vxlan id 16 local 10.99.10.254 dstport 0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.13 dev vx0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.12 dev vx0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.11 dev vx0
ip addr add 10.129.16.4/24 dev vx0
ip link set up dev vx0



#################################################

#Host5 test-rke
ip link delete vx0
ip link add vx0 type vxlan id 16 local 10.99.10.14 dstport 0   
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.254 dev vx0
bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.12 dev vx0
ip addr add 10.129.16.3/24 dev vx0
ip link set up dev vx0

#Host4 light
ip link delete vx0
ip link add vx0 type vxlan id 16 local 10.99.10.254 dstport 0
./bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.14 dev vx0
./bridge fdb append to 00:00:00:00:00:00 dst 10.99.10.12 dev vx0
ip addr add 10.129.16.4/24 dev vx0
ip link set up dev vx0


##id 5  # confirmed working with cilium and metallb
#Host5 test-rke
ip link delete vx0
ip link add vx0 type vxlan id 16 local 10.99.10.14 remote 10.99.10.254 dev wg0 dstport 4789
ip addr add 10.129.16.3/24 dev vx0
ip link set up dev vx0

#Host4 light
ip link delete vx0
ip link add vx0 type vxlan id 16 local 10.99.10.254 remote 10.99.10.14 dev wg0 dstport 4789
ip addr add 10.129.16.4/24 dev vx0
ip link set up dev vx0
##id 5############################################












<!-- 
# Host5 (10.99.10.14) Configuration
ip link add vx0 type vxlan id 16 local 10.99.10.14 dev wg0 dstport 4789
ip addr add 10.129.16.5/24 dev vx0
bridge fdb append 00:00:00:00:00:00 dev vx0 dst 10.99.10.10
bridge fdb append 00:00:00:00:00:00 dev vx0 dst 10.99.10.11
bridge fdb append 00:00:00:00:00:00 dev vx0 dst 10.99.10.12
bridge fdb append 00:00:00:00:00:00 dev vx0 dst 10.99.10.13 -->



## seems to also work
#Host5 test-rke
ip link delete vx0
ip link add vx0 type vxlan id 16 local 10.99.10.14 dev wg0 dstport 4789
bridge fdb append 00:00:00:00:00:00 dev vx0 dst 10.99.10.254
bridge fdb append 00:00:00:00:00:00 dev vx0 dst 10.99.10.12
ip addr add 10.129.16.3/24 dev vx0
ip link set up dev vx0

#Host4 light
ip link delete vx0
ip link add vx0 type vxlan id 16 local 10.99.10.254 dev wg0 dstport 4789
./bridge fdb append 00:00:00:00:00:00 dev vx0 dst 10.99.10.14
./bridge fdb append 00:00:00:00:00:00 dev vx0 dst 10.99.10.12
ip addr add 10.129.16.4/24 dev vx0
ip link set up dev vx0
## given ./bridge is path to nixstore iproute2
## seems to also work

