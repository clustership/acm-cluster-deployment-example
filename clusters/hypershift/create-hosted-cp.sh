#!/bin/bash

export CLUSTERS_NAMESPACE="clusters"
export HOSTED_CLUSTER_NAME="${1:-bm-compact-01}"
export HOSTED_CONTROL_PLANE_NAMESPACE="${CLUSTERS_NAMESPACE}-${HOSTED_CLUSTER_NAME}"
export BASEDOMAIN="${2:-clustership.com}"
export PULL_SECRET_FILE=${HOME}/.pull-secret.json
export MACHINE_CIDR=172.16.1.0/24

# Typically the namespace is created by the hypershift-operator
# but agent cluster creation generates a capi-provider role that
# needs the namespace to already exist
oc create ns ${HOSTED_CONTROL_PLANE_NAMESPACE}

echo hypershift create cluster agent \
    --name=${HOSTED_CLUSTER_NAME} \
    --pull-secret=${PULL_SECRET_FILE} \
    --agent-namespace=${HOSTED_CONTROL_PLANE_NAMESPACE} \
    --base-domain=${BASEDOMAIN} \
    --api-server-address=api.${HOSTED_CLUSTER_NAME}.${BASEDOMAIN} \
    --release-image=quay.io/openshift-release-dev/ocp-release:4.12.15-x86_64 \
    --ssh-key=${HOME}/.ssh/id_rsa.pub \
    --render
