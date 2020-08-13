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


}

resource "google_compute_disk" "controller" {
    name = "cdocker"
    type = "pd-ssd"
    zone = "${"${var.region}"}-a"
    size = "10"
}

resource "google_compute_attached_disk" "controller" {
    disk = "${google_compute_disk.controller.self_link}"
    instance = "${google_compute_instance.controller.self_link}"
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
