# setup folder


## Create your pull secret manifests

```
oc --dry-run=client -o yaml create secret docker-registry pull-secret-sno-blueprint --from-file=.dockerconfigjson=$HOME/.pull-secret.json > 03-pull-secret.yaml
```


## Change cluster parameters

```
CLUSTER_NAME=<yourclustername>
sed -i "s/sno-blueprint/${CLUSTER_NAME}/g" *.yaml
```


## Create your cluster

```
oc apply -k .
```


Then look at your infraenv resources to see installation progress:

```
oc describe infraenv
```

or

```
curl -k $(oc get infraenv ${CLUSTER_NAME} -o jsonpath='{.status.debugInfo.eventsURL}') | jq .
```
