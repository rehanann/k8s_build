resource "google_compute_instance" "master" {
  name = "master-1"
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

resource "google_compute_disk" "master" {
    name = "mdocker"
    type = "pd-ssd"
    zone = "${"${var.region}"}-a"
    size = "10"
}

resource "google_compute_attached_disk" "master" {
    disk = "${google_compute_disk.master.self_link}"
    instance = "${google_compute_instance.master.self_link}"
}

resource "google_compute_instance" "infra" {
  name = "infra-1"
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

resource "google_compute_disk" "infra" {
    name = "idocker"
    type = "pd-ssd"
    zone = "${"${var.region}"}-a"
    size = "10"
}

resource "google_compute_attached_disk" "infra" {
    disk = "${google_compute_disk.infra.self_link}"
    instance = "${google_compute_instance.infra.self_link}"
}

resource "google_compute_instance" "worker" {
  name = "worker-1"
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

resource "google_compute_disk" "worker" {
    name = "wdocker"
    type = "pd-ssd"
    zone = "${"${var.region}"}-a"
    size = "10"
}

resource "google_compute_attached_disk" "worker" {
    disk = "${google_compute_disk.worker.self_link}"
    instance = "${google_compute_instance.worker.self_link}"
}