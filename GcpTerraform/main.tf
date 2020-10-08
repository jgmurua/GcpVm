// Configure the Google Cloud provider
provider "google" {
 credentials = file("/keys/cuentaGcpCuidado.json")
 project     = "XXXXXXXXXXXXXXXXX"
 region      = "us-west1"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
 name         = "river-vm-${random_id.instance_id.hex}"
 machine_type =  "f1-micro" #"g1-small"
 zone         = "us-west1-a"
 
 // De esta manera setea mis llaves en la nueva instacia
 metadata = {
   ssh-keys = "juan:${file("/keys/juan_pub")}"
 }

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 
 }


 metadata_startup_script = "echo 'ok'"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}
