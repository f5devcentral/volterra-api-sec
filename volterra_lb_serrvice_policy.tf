//==========================================================================
//Definition of the Origin, 1-origin.tf
//Start of the TF file
resource "volterra_origin_pool" "op-ip-internal" {
  name                   = "op-ip-internal"
  //Name of the namespace where the origin pool must be deployed
  namespace              = var.namespace
 
   origin_servers {

    public_name {
      dns_name = "petstore.swagger.io"
    }
    labels = {
    }
  }

  no_tls = true
  port = "80"
  endpoint_selection     = "LOCALPREFERED"
  loadbalancer_algorithm = "LB_OVERRIDE"
}
//==========================================================================
//Definition of the Load-Balancer
//Start of the TF file
resource "volterra_http_loadbalancer" "lb-https-tf" {
  depends_on = [volterra_origin_pool.op-ip-internal]
  //Mandatory "Metadata"
  name      = var.lbname
  //Name of the namespace where the origin pool must be deployed
  namespace = var.namespace
  //End of mandatory "Metadata" 
  //Mandatory "Basic configuration" with Auto-Cert 
  domains = [var.lbdomain]
  https_auto_cert {
    add_hsts = true
    http_redirect = true
    no_mtls = true
    enable_path_normalize = true
    tls_config {
        default_security = true
      }
  }
  default_route_pools {
      pool {
        name = "op-ip-internal"
        namespace = var.namespace
      }
      weight = 1
    }
  active_service_policies {
    policies {
      name = "auto-deny-policy"
      namespace = var.namespace
    }
  }
  //Mandatory "VIP configuration"
  advertise_on_public_default_vip = true
  //End of mandatory "VIP configuration"
  //Mandatory "Security configuration"
  no_service_policies = false
  no_challenge = true
  disable_rate_limit = true
  //WAAP Policy reference, created earlier in this plan - refer to the same name
  app_firewall {
    name = "waap-demo-tf"
    namespace = var.namespace
  }
  multi_lb_app = true
  user_id_client_ip = true
  //End of mandatory "Security configuration"
  //Mandatory "Load Balancing Control"
  source_ip_stickiness = true
  //End of mandatory "Load Balancing Control"  
}
//Definition of Service policy
resource "volterra_service_policy" "testsp" {
  name        = "auto-deny-policy"
	namespace   = var.namespace
	algo        = "FIRST_MATCH"
  any_server  = true
  rule_list {
    rules {
      metadata {
        name = "allow-all"
        disable = false           
      }
      spec {
        action = "ALLOW"
        any_ip           = true
        any_asn          = true
        challenge_action = "DEFAULT_CHALLENGE"
        waf_action {
        none = true
        }
      }
    }
    rules {
      metadata {
        name = "deny-pet"
        disable = false           
      }
      spec {
        action = "DENY"
        path {
          exact_values =  ["/v2/pet/-18482912"]
        }
        http_method {
          methods = ["ANY"]
        }
        any_ip           = true
        any_asn          = true
        challenge_action = "DEFAULT_CHALLENGE"
        waf_action {
        none = true
        }
      }
    }
  }
}
//End of the file
//==========================================================================
