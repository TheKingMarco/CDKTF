LOCATION          = "italynorth"
ENVIRONMENT       = "policydef"
WORKLOAD          = "tf"
SUBSCRIPTION_TYPE = "eni"
AZURE_REGION      = "ita"

AKS = {
  default_node_pool = {
    name       = "nodepool"
    node_count = 1
    vm_size    = "Standard_B2s" #Standard_B2s
    temporary_name_for_rotation = "rotation"
  }
  identity = {
    type = "SystemAssigned"
  }
}

policy_definitions = {
    "policy-01" = {
        display_name = "Kubernetes cluster containers should only use allowed images"
        enabled = true
        policy_name = "allow-image"
        parameters-policy =  <<PARAMETERS
           {
               "excludedNamespaces": {
                  "value": [
                      "calico-system",
                      "default",
                      "infra",
                      "kube-node-lease",
                      "kube-public",
                      "kube-system",
                      "messaging",
                      "platform-apigw-sas-gateway",
                      "platform-cert-mgmt",
                      "platform-molo-cli",
                      "platform-sast", 
                      "tigera-operator",
                      "twistlock",
                      "gatekeeper-system",
                      "azure-arc",
                      "azure-extensions-usage-system"
                  ]
              },
              "effect": {
                  "value": "Audit"
              },
              "warn": {
                  "value": false
              },
              "allowedContainerImagesRegex": {
                  "value": "enidgt.azurecr.io/.*"
              }
          }
          PARAMETERS
    }
}