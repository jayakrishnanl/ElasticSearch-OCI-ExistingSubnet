# Get list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

# Get name of Availability Domains
data "template_file" "deployment_ad" {
  count    = "${length(var.AD)}"
  template = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD[count.index] - 1], "name")}"
}

# Get list of Fault Domains
data "oci_identity_fault_domains" "fds" {
  count               = "${length(var.AD)}"
  availability_domain = "${element(data.template_file.deployment_ad.*.rendered, count.index)}"
  compartment_id      = "${var.compartment_ocid}"
}

locals {
  fds                 = "${flatten(concat(data.oci_identity_fault_domains.fds.*.fault_domains))}"
  faultdomains_per_ad = 3
}

# Get name of Fault Domains
data "template_file" "deployment_fd" {
  template = "$${name}"
  count    = "${length(var.AD) * (local.faultdomains_per_ad) }"

  vars = {
    name = "${lookup(local.fds[count.index], "name")}"
  }
}

data "template_file" "bootstrap_es" {
  template = "${file("${path.module}/userdata/bootstrap_es.tpl")}"

  vars {
    timezone = "${var.timezone}"
  }
}
