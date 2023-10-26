variable "prefix" {
  default ="b13-ely"
}

module "azure_infra" {
  source = "git::https://github.com/Simplon-Luna/b13-ely-2"

  prefix                              = "b13-ely"
  resource_group_name                 = "${var.prefix}-rg"
  location                            = "francecentral"
  vnet_name                           = "${var.prefix}-VNet"
  address_space                       = ["10.0.0.0/16"]
  priv_subnet_name                    = "${var.prefix}-Priv_Subnet"
  subnet_address_prefixes             = ["10.0.1.0/24"]
  aks_name                            = "${var.prefix}-AKSCluster"
  node_pool_name                      = "default"
  node_count                          = 2
  vm_size                             = "Standard_DS2_v2"
  use_nat_gateway                     = true
  nat_gateway_name                    = "${var.prefix}-NATGateway"
  nginx_ingress_ip_name               = "${var.prefix}-IngressIp"
  nginx_ingress_ip_sku                = "Standard"
  route_table_name                    = "customRouteTableName"
  pub_ip_name                         = "ely13-pub-ip"
  vm_name                             = "ely13-vm"
  nsg_name                            = "${var.prefix}-nsg"
  nsg-rule_name                       = "${var.prefix}-nsgRule_allow-ssh"
  nsgRule_priority                    = 1001
  nsgRule_direction                   = "Inbound"
  nsgRule_access                      = "Allow"
  nsgRule_protocol                    = "Tcp"
  nsgRule_source_port_range           = "*"
  nsgRule_destination_port_range      = "22"
  nsgRule_source_address_prefix       = "*"
  nsgRule_destination_address_prefix  = "*"
  nsg-rule_name2                      = "${var.prefix}-nsgRule_allow-outbound"
  nsgRule_priority2                   = 2001
  nsgRule_direction2                  = "Outbound"
  nsgRule_access2                     = "Allow"
  nsgRule_protocol2                   = "Tcp"
  nsgRule_source_port_range2          = "*"
  nsgRule_destination_port_range2     = "*"
  nsgRule_source_address_prefix2      = "*"
  nsgRule_destination_address_prefix2 = "*"
}
