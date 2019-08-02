
# Region
# region = "eu-frankfurt-1"

# AD (Availability Domain to use for creating infrastructure) 
AD = ["1","2"]

# Timezone of compute instance
timezone = "GMT"

# Size of boot volume (in gb) of the instances
compute_boot_volume_size_in_gb = "50"

# Hostname prefix to define hostname for ElasticSearch nodes
es_hostname_prefix = "es"

# Number of ElasticSearch nodes to be created
es_instance_count = "1"

# ElastiSearch instance shape
es_instance_shape = "VM.Standard2.4"

# ElasticSearch Public Subnet - make sure SL has opened ingress: 9200/TCP, 5601/TCP; EGress ALL/TCP and has RT with IG configured.
# es_subnet = "ocid1.subnet.oc1.eu-frankfurt-1.aaaaaaaatXXXXXXXXXqkl57s6ssz7wxufvqwdlidqfqxjq"




