variable "api_cert" {
            type = string
            default = "certificate-latest.cert"
        }
        
        variable "api_key" {
          type = string
          default = "private_key-latest.key"
        }
        
        variable "api_url" {
            type = string
            default = "https://treino.console.ves.volterra.io/api"
        }
        variable "namespace" {
            type = string
            default = "api-sec"
        }
        variable "lbdomain" {
            type = string
            default = "user4.f5-hyd-demo.com"
        }
        variable "lbname" {
            type = string
            default = "lb-https-tf"
        }
