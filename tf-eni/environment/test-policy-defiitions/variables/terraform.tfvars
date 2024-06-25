LOCATION          = "italynorth"
ENVIRONMENT       = "policydef"
WORKLOAD          = "tf"
SUBSCRIPTION_TYPE = "eni"
AZURE_REGION      = "ita"

AKS = {
  default_node_pool = {
    name                        = "nodepool"
    node_count                  = 1
    vm_size                     = "Standard_B2s" #Standard_B2s
    temporary_name_for_rotation = "rotation"
  }
  identity = {
    type = "SystemAssigned"
  }
}

policy_definitions = {
  "policy-allowed-images" = {
    display_name      = "Kubernetes cluster containers should only use allowed images"
    enabled           = true
    policy_name       = "allowed-images"
    parameters_policy = <<PARAMETERS
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
            "platform-cicd",
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
  "policy-privileged-container" = {
    display_name      = "Kubernetes cluster should not allow privileged containers"
    enabled           = true
    policy_name       = "privileged-container"
    parameters_policy = <<PARAMETERS
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
            "platform-cicd",
            "azure-extensions-usage-system"
        ]
    },
    "effect": {
        "value": "Deny"
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


  "policy-disruption-budgets" = {
    display_name      = "[Preview]: Kubernetes cluster should implement accurate Pod Disruption Budgets"
    enabled           = true
    policy_name       = "disruption-budgets"
    parameters_policy = <<PARAMETERS
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
            "platform-cicd",
            "azure-extensions-usage-system"
        ]
    },
    "effect": {
        "value": "Deny"
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
  policy-internal-loadbalancers = {
    display_name      = "Kubernetes clusters should use internal load balancers"
    enabled           = true
    policy_name       = "internal-loadbalancers"
    parameters_policy = <<PARAMETERS
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
      "platform-cicd",
      "azure-extensions-usage-system"
    ]
  },
  "effect": {
    "value": "Deny"
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

target_resource_name = "ecs02axx"