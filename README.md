# Wireguard VXLAN mesh ansible
### This ansible script extends https://github.com/jawher/automation-wireguard wireguard by:
- making in nix "compatile"
- adding vxlan mesh compatibility
- adding vxlan test

## To Run it 

The make file will reference inventory/<filename>.yml file, make sure to set the inventory name in the makefile

### Wireguard
To run wireguard mesh run:  
`make apply-wireguard`

Then to test if all nodes can communicate run:  
`make test-wireguard`

### 
To run a vxlan mesh that does not persist across reboots run:  
`make apply-vxlan-non-static`  
This will create a `/vxlan_config` in the root of all of your hosts, next you just need to pipe the lines from that file to the terminal as priviledged user

To run a persistant configuration run:  
`make apply-vxlan`  
This will add vxlan interface and create bridges that will forward all traffic across all hosts

To test the vxlan you can run this command  
`make test-vxlan`