
# Disaster recovery and backup in Kubernetes

## Backup using Ark

Ark gives you tools to back up and restore your Kubernetes cluster resources and persistent volumes.

run Ark with a cloud provider or on-premises.

[Setting ark on AWS cloud](https://heptio.github.io/ark/v0.9.0/aws-config.html)

[00-prereqs.yaml](https://github.com/heptio/ark/tree/master/examples/common)


### install client ark
[releases](https://github.com/heptio/ark/releases)

sudo mv ark /usr/local/bin

### install ark in kubernetes

```
sh setting-aws.sh
```

### Backup

```
ark backup create nginx-backup-20181105 --include-namespaces demo
```

### Restore
```
ark restore create nginx-backup-20181105
```
