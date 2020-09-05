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

# Dev servers

resource "google_compute_instance" "dev-1" {
  name = "dev-1"
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

resource "google_compute_disk" "dev-1" {
    name = "dev-1-ndocker"
    type = "pd-ssd"
    zone = "${"${var.region}"}-a"
    size = "10"
}

resource "google_compute_attached_disk" "dev-1" {
    disk = "${google_compute_disk.dev-1.self_link}"
    instance = "${google_compute_instance.dev-1.self_link}"
}

# dev-2

resource "google_compute_instance" "dev-2" {
  name = "dev-2"
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

resource "google_compute_disk" "dev-2" {
    name = "dev-2-ndocker"
    type = "pd-ssd"
    zone = "${"${var.region}"}-a"
    size = "10"
}

resource "google_compute_attached_disk" "dev-2" {
    disk = "${google_compute_disk.dev-2.self_link}"
    instance = "${google_compute_instance.dev-2.self_link}"
}


# prod-1

resource "google_compute_instance" "prod-1" {
  name = "prod-1"
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

resource "google_compute_disk" "prod-1" {
    name = "prod-1-ndocker"
    type = "pd-ssd"
    zone = "${"${var.region}"}-a"
    size = "10"
}

resource "google_compute_attached_disk" "prod-1" {
    disk = "${google_compute_disk.prod-1.self_link}"
    instance = "${google_compute_instance.prod-1.self_link}"
}

# prod-2

resource "google_compute_instance" "prod-2" {
  name = "prod-2"
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

resource "google_compute_disk" "prod-2" {
    name = "prod-2-ndocker"
    type = "pd-ssd"
    zone = "${"${var.region}"}-a"
    size = "10"
}

resource "google_compute_attached_disk" "prod-2" {
    disk = "${google_compute_disk.prod-2.self_link}"
    instance = "${google_compute_instance.prod-2.self_link}"
}


# OUTPUT

output "machine_type" {
    value = "${google_compute_instance.controller.*.machine_type}"
}