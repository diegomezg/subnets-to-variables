SUBNETS=$($() awk '/address_prefix/{print;getline;print;}' variables.tf  | grep name | cut -f2 -d'=' | sed -e 's/"//' -e 's/"^C' -e 's/^\s*//')
if SUBNETS
  for i in $SUBNETS
  do terraform import 'azurerm_subnet.default["$i"]' /subscriptions/{SUBSCRIPTION}/resourceGroups/{RG}/providers/Microsoft.Network/virtualNetworks/{VN}/subnets/$i
  done
  sed -e '9,16d;' variables.tf
