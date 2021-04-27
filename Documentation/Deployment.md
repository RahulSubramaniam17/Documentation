The built image can be deployed to the Bosun kubernetes cluster using kubernetes and helm. More about the architecture of [Bosun](https://bazaarvoice.slack.com/archives/D01LJ7D73QB/p1619170585004300) cluster can be learned here. 

We can initialise our repository with bosun-repo-init command. 

```  bosun-repo-init --repo-dir . --github-token ${GITHUB_TOKEN} --namespace <team_namespace> --team-email <team_email>@bazaarvoice.com ```

Replace your namespace and email ID. A Github token can be created following [this](https://github.com/settings/tokens)

note: bosun-repo-init is limited to works for bazaarvoice repository. Once you give proper access to bv-bosun, bosun init will create a ecr repo, a webhook which listen to tags in master branch and a tekton pipeline for CI. Few steps mentioned in this document may be not required (say Push Docker Image to ECR).

Once you execute bosun-repo-init it will create a deploy folder with few default values. Developer is expected to review and update the values.yaml

* values.yaml
* values-qa.yaml
* values-prod.yaml


The Settings for deployment of an image to your cluster can be changed using these files.
The values.yaml file contains an URI for the image to be deployed. The necessary ECR image should be passed here.

After Making the necessary changes in the yaml files. We can deploy using

``` make deploy-qa ```

This command uses helm to deploy like this

``` helm upgrade --install -n agrippa demo ./deploy/helm/demo/ -f ./deploy/helm/demo/values.yaml -f ./deploy/helm/demo/values-qa.yaml ```

To check the health, status of a deployment we can use

 kubectl get pods  or alternatively check the kubernetes [dashboard](https://dashboard.eu-west-1a.bosun.qa.bazaarvoice.com/#/pod/agrippa/demo-59df4b6449-4gssn?namespace=agrippa). To login into the dashboard we need to create a token which can be done by using the following command

 ``` aws-iam-authenticator token -i eu-west-1a.bosun.qa.bazaarvoice.com ```

 The endpoint for the deployed pod can be accessed by using

 ``` kubectl -n <namespace> get ing ```