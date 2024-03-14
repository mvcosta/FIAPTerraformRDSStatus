# Criação do banco de dados (RDS) na AWS via Terraform com CI/CD no GitHub Actions

Este repositório contém os scripts Terraform para provisionar e gerenciar um banco de dados por meio do Relational Database Service (RDS) na AWS para o serviço de [Status](https://github.com/negospo/TCF5-StatusService). Além disso, utiliza-se o GitHub Actions para automação do CI/CD, garantindo a consistência e confiabilidade do código de infraestrutura.

## Como iniciar o banco de dados 

Antes de se inicializer o banco de dados é necessário a configuração de uma nova secret no AWS Secrets Manager, com o nome "fiap-db". Essa secret deverá possuir os seguintes valores: username, password.

Além disso, o cluster [EKS](https://github.com/mvcosta/FIAPTerraformEKS) deve estar de pé, pois o banco RDS será criado dentro da mesma VPC criada durante a criação do cluster.

A inicialização do banco pode ser realizada de duas formas:

### 1. Realizar o fork do repositório

1. Faça o fork deste repositório.
2. Configure a autenticação do Github Actions utilizando OpenID Connec, seguindo o seguinte [tutorial](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services).
3. Execute a action "Terraform".

### 2. Realizando o clone para sua máquina
1. Faça o clone do repositório na sua máquina.
2. Instale o terraform.
3. Instale a AWS CLI.
4. Realize a autenticação na AWS CLI.
5. Execute o comando `terrafom apply` na raiz desse projeto
