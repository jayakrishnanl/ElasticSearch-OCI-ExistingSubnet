output "ComputePrivateIPs" {
  value = ["${oci_core_instance.compute.*.private_ip}"]
}

output "ComputePublicIPs" {
  value = ["${oci_core_instance.compute.*.public_ip}"]
}
output "ComputeOcids" {
  value = ["${oci_core_instance.compute.*.id}"]
}
