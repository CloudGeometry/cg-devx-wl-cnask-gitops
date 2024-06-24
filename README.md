# CG DevX <WL_NAME> GitOps Repository

Welcome to your new `<WL_NAME>-gitops` repository.
This repository in an example of multi-service monorepo workload. This example also uses mixed in-cluster and cloud
native database for different environment variants.

The `<WL_NAME>-gitops` repository has two main sections

- `/gitops`: GitOps environments definitions
- `/terraform`: Infrastructure as Code (IaC) for your cloud resources, and secrets used by workload

> **Note**: For proper bootstrap of the repository IaC initialization PR (PR #1) should be applied in 2 phases, first
> for `infrastructure` module, and after for `secrets` module.
>
> This could be done by writing following comments to PR one by one:
>
> 1. `atlantis plan -d terraform/infrastructure`
> 2. `atlantis apply -d terraform/infrastructure`
> 3. `atlantis plan -d terraform/secrets`
> 4. `atlantis apply -d terraform/secrets`
