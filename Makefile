INVENTORY = inventory

apply-wg:
	ansible-playbook -i "inventories/${INVENTORY}.yml" "wireguard.yml"
apply-vxlan_systemd:
	ansible-playbook -i "inventories/${INVENTORY}.yml" "wireguard.yml"

test:
	ansible-playbook -i "inventories/${INVENTORY}.yml" "ping.yml"
test-vxlan:
	ansible-playbook -i "inventories/${INVENTORY}.yml" "ping_vxlan.yml"
