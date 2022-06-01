# HELM



locals {
  istio_charts_url = "https://istio-release.storage.googleapis.com/charts"
  istio-namespace     = "istio-system"
}


# Istio

resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
    labels = {
      namespace = "istio-system"
    }
      
  }
}

resource "helm_release" "istio-base" {
  repository       = local.istio_charts_url
  chart            = "base"
  name             = "istio-base"
  namespace        = local.istio-namespace
  version          = "1.12.1"
  create_namespace = true
}


resource "helm_release" "istiod" {
  repository       = local.istio_charts_url
  chart            = "istiod"
  name             = "istiod"
  namespace        = local.istio-namespace
  create_namespace = true
  version          = "1.12.1"
  depends_on       = [helm_release.istio-base]

    set {
        name = "global.configValidation"
        value = "false"
    }


    set {
        name = "sidecarInjectorWebhook.enabled"
        value = "false"
    }

    set {
        name = "sidecarInjectorWebhook.enableNamespacesByDefault"
        value = "false"
    }


}

resource "kubernetes_namespace" "istio-ingress" {
  metadata {
  labels = {
      istio-injection = "enabled"
    }

    name = "istio-ingress"
  }
}

resource "kubernetes_namespace" "apps" {
  metadata {
  labels = {
      istio-injection = "enabled"
    }

    name = "apps"
  }
}


resource "helm_release" "istio-ingress" {
  repository = local.istio_charts_url
  chart      = "gateway"
  name       = "istio-ingressgateway"
  namespace  = kubernetes_namespace.istio_system.id 
  version    = "1.12.1"
  depends_on = [helm_release.istiod]
}