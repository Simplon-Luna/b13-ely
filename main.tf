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
  vm_size                             = "Standard_DS2_v2"
  # use_nat_gateway                     = true
  # nat_gateway_name                    = "${var.prefix}-NATGateway"
  # nginx_ingress_ip_name               = "${var.prefix}-IngressIp"
  # nginx_ingress_ip_sku                = "Standard"
  # route_table_name                    = "customRouteTableName"
  pub_ip_name                         = "ely13-pub-ip"
  vm_name                             = "ely13-vm"
  nsg_name                            = "${var.prefix}-nsg"
  nsg_rule_name                       = "${var.prefix}-nsgRule_allow-ssh"
  nsgRule_priority                    = 1001
  nsgRule_direction                   = "Inbound"
  nsgRule_access                      = "Allow"
  nsgRule_protocol                    = "Tcp"
  nsgRule_source_port_range           = "*"
  nsgRule_destination_port_range      = "22"
  nsgRule_source_address_prefix       = "*"
  nsgRule_destination_address_prefix  = "*"
  nsg_rule_name2                      = "${var.prefix}-nsgRule_allow-outbound"
  nsgRule_priority2                   = 2001
  nsgRule_direction2                  = "Outbound"
  nsgRule_destination_port_range2     = "*"
}

variable "vm_name"{
  description = "The VM's name"
  default = "ely13-vm"
  type        = string
}

variable "vm_size" {
  description = "The VM size for the nodes in AKS cluster"
  default = "Standard_DS2_v2"
  type        = string
}

variable "location" {
  description = "The Azure Region in which resources will be created"
  default = "francecentral"
  type        = string
}

# Creation VM
resource "azurerm_linux_virtual_machine" "red-vm" {
  name                = "${var.vm_name}"
  location            = "${var.location}"
  resource_group_name = module.azure_infra.rg_name.name
  network_interface_ids = [module.azure_infra.nic_id.id]

  size                = "${var.vm_size}"
  admin_username      = "adminuser"
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/git/b13-ely/.ssh/ssh.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "88-gen2"
    version   = "latest"
  }

  computer_name  = "${var.vm_name}"
 }
