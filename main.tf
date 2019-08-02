# Create ElasticSearch Node
module "create_es" {
  source = "./modules/compute"

  compartment_ocid               = "${var.compartment_ocid}"
  AD                             = "${var.AD}"
  availability_domain            = ["${data.template_file.deployment_ad.*.rendered}"]
  fault_domain                   = ["${sort(data.template_file.deployment_fd.*.rendered)}"]
  compute_subnet                 = ["${var.es_subnet}"]
  compute_instance_count         = "${var.es_instance_count}"
  compute_hostname_prefix        = "${var.es_hostname_prefix}${substr(var.region, 3, 3)}"
  compute_boot_volume_size_in_gb = "${var.compute_boot_volume_size_in_gb}"
  compute_assign_public_ip       = "true"
  compute_image                  = "${var.instance_image_ocid[var.region]}"
  compute_instance_shape         = "${var.es_instance_shape}"
  compute_ssh_public_key         = "${var.ssh_public_key}"
  compute_ssh_private_key        = "${var.ssh_private_key}"
  compute_instance_user          = "opc"
  timezone                       = "${var.timezone}"
  user_data                      = "${data.template_file.bootstrap_es.rendered}"
}
