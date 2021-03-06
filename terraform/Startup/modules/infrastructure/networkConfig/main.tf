resource "azurerm_subnet" "testEnvSubnet"{
  name = "${var.Name}subnet"
  resource_group_name = var.ResourceGroupName
  virtual_network_name = var.VNName
  address_prefixes = [var.subnetPrefix]
}

resource "azurerm_public_ip" "testEnvPubIP" {
  name                = "${var.Name}PubIP"
  resource_group_name = var.ResourceGroupName
  location            = var.location
  allocation_method   = "Dynamic"
  depends_on              = [var.resourceGroupReference]
}

resource "azurerm_network_interface" "testEnvNetInt"{
  name = "${var.Name}NetInt"
  location = var.location
  resource_group_name = var.ResourceGroupName

  ip_configuration {
    name = "${var.Name}IPConfig"
    subnet_id = azurerm_subnet.testEnvSubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.testEnvPubIP.id
  }
}