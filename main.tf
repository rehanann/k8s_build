resource "google_compute_instance" "controller" {
  name = "controller-1"
  machine_type = "${var.machine_type}"
  zone = "${"${var.region}"}-a"


  boot_disk {
      initialize_params {
          image = "${var.image}"
          size = "20"
      }
  }

  network_interface {
      network = "default"

      access_config { 
          // Ephemeral IP
      }
  }

  service_account {
      scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  metadata = {
    ssh-keys = "${var.username}:${file("${var.path}/jenkins_key")}"
  }

  provisioner "file" {
    source = "${file("${var.path}/sshd_config")}"
    destination = "/etc/ssh/sshd_config"
  }

  connection {
    user = "root"
    type = "ssh"
    private_key = "${file("${var.path}/rsa_root_key")}"
  }

}

resource "google_compute_disk" "controller-1" {
    name = "cdocker"
    type = "pd-ssd"
    zone = "${"${var.region}"}-a"
    size = "10"
}

resource "google_compute_attached_disk" "controller-1" {
    disk = "${google_compute_disk.controller-1.self_link}"
    instance = "${google_compute_instance.controller-1.self_link}"
}

resource "google_compute_instance" "minion" {
  name = "minion-1"
  machine_type = "${var.machine_type}"
  zone = "${"${var.region}"}-a"


  boot_disk {
      initialize_params {
          image = "${var.image}"
          size = "20"
      }
  }

  network_interface {
      network = "default"

      access_config { 
          // Ephemeral IP
      }
  }

  service_account {
      scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  metadata = {
    ssh-keys = "${var.username}:${file("${var.path}/jenkins_key")}"
  }

  provisioner "file" {
    source = "${file("${var.path}/sshd_config")}"
    destination = "/etc/ssh/sshd_config"
  }

  connection {
    user = "root"
    type = "ssh"
    private_key = "${file("${var.path}/rsa_root_key")}"
  }

}

resource "google_compute_disk" "minion" {
    name = "mindocker"
    type = "pd-ssd"
    zone = "${"${var.region}"}-a"
    size = "10"
}

resource "google_compute_attached_disk" "minion" {
    disk = "${google_compute_disk.minion.self_link}"
    instance = "${google_compute_instance.minion.self_link}"
}

# resource "google_compute_instance" "worker" {
#   name = "worker-1"
#   machine_type = "${var.machine_type}"
#   zone = "${"${var.region}"}-a"


#   boot_disk {
#       initialize_params {
#           image = "${var.image}"
#           size = "20"
#       }
#   }

#   network_interface {
#       network = "default"

#       access_config { 
#           // Ephemeral IP
#       }
#   }

#   service_account {
#       scopes = ["userinfo-email", "compute-ro", "storage-ro"]
#   }

#   metadata = {
#     ssh-keys = "${var.username}:${file("${var.path}/jenkins_key")}"
#   }

#   provisioner "file" {
#     source = "${file("${var.path}/sshd_config")}"
#     destination = "/etc/ssh/sshd_config"
#   }

#   connection {
#     user = "root"
#     type = "ssh"
#     private_key = "${file("${var.path}/rsa_root_key")}"
#   }
  
# }

# resource "google_compute_disk" "worker" {
#     name = "wdocker"
#     type = "pd-ssd"
#     zone = "${"${var.region}"}-a"
#     size = "10"
# }

# resource "google_compute_attached_disk" "worker" {
#     disk = "${google_compute_disk.worker.self_link}"
#     instance = "${google_compute_instance.worker.self_link}"
# }