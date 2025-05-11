INVENTORY = inventory.yml

apply-wireguard:
	ansible-playbook -i "inventories/${INVENTORY}" "wireguard.yml"

apply-vxlan:
	ansible-playbook -i "inventories/${INVENTORY}" "vxlan_systemd.yml"

apply-vxlan-non-static:
	ansible-playbook -i "inventories/${INVENTORY}" "vxlan.yml"

test-wireguard:
	ansible-playbook -i "inventories/${INVENTORY}" "ping.yml"

test-vxlan:
	ansible-playbook -i "inventories/${INVENTORY}" "ping_vxlan.yml"
