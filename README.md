# On-Demand Web Servers

Making use of a previous example project (https://github.com/TerenceJefferies/laravel-webserver) - This project 
demonstrates how temporary, on-demand, environments could be utilized to provide disposable setups for scenarios such as
testing, demos and training.

## Project Setup

This project is seperated into two sections, the application and the infrastructure. The infrastructure is designed 
to take a JSON file outlining which environments need to be generated and at which point across the projects life-cycle
(for instance, a feature environment may need to checkout a branch, whereas a production environment may take a tag)

The second section is the application code itself, which for the sake of this project, is a basic Laravel application
that outputs the alias for the deployment, giving us an easy way to test this setup.


## Example server definition file

```json
{
  "production": {
    "alias": "production",
    "reference": "main"
  },
  "qa": {
    "alias": "qa",
    "reference": "qa"
  },
  "feature-321": {
    "alias": "feature-321",
    "reference": "feature-321"
  }
}
```

alias = name of server
reference = branch/tag/commit to checkout

## Example Usage

### Creating without any feature environments
```bash
cd iac
node create-servers-definition.js
terraform apply
```

### Creating with feature environments
```bash
cd iac
node create-servers-definition.js feature-123,feature-321
terraform apply
```

## Other Considerations

This project takes a basic Laravel server setup and demonstrates how it can be expanded to create on-demand environments
for all sorts of use cases. Using this framework, a service provider could spin up environments for individual pull 
requests, to accommodate testing or demos to potential clients.

In a more realistic example, there would be other considerations, such as databases, queues, background workers, etc 
that also need to be created with each environment. By maintaining awareness of this possibility from the outset of a 
project, developers and infrastructure engineers can ensure their environments are easy to provision and destroy without
needing the stress of defining individual configurations for each environment.
