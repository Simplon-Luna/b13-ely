variable "prefix" {
  default ="b13-ely"
}

module "azure_infra" {
  source = "git::https://github.com/Simplon-Luna/b12-ely-3"

  prefix                  = "b13-ely"
  resource_group_name     = "${var.prefix}-rg"
  location                = "francecentral"
  vnet_name               = "${var.prefix}-VNet"
  address_space           = ["10.0.0.0/16"]
  subnet_name             = "${var.prefix}-Subnet"
  subnet_address_prefixes = ["10.0.1.0/24"]
  ## aks_name                = "${var.prefix}-AKSCluster"
  ## node_pool_name          = "default"
  ## node_count              = 2
  vm_size                 = "Standard_DS2_v2"
  use_nat_gateway         = true
  nat_gateway_name        = "${var.prefix}-NATGateway"
  nginx_ingress_ip_name   = "${var.prefix}-IngressIp"
  nginx_ingress_ip_sku    = "Standard"
  route_table_name        = "customRouteTableName"
  vm_name                 = "ely13-vm"
}
