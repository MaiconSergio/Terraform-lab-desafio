# AWS Terraform Infrastructure Project

## 📌 Sobre o Projeto

Projeto desenvolvido com foco em aprendizado prático de Infrastructure as Code (IaC) utilizando Terraform na AWS.

O laboratório foi dividido em dois projetos principais:

* `aws-vpc` → responsável pela infraestrutura de rede
* `aws-vm-provisioners` → responsável pelo provisionamento da EC2 e automações

O objetivo foi praticar:

* Terraform
* AWS Networking
* Remote State
* EC2
* SSH
* Provisioners
* Outputs
* Integração entre estados remotos
* Automação de provisionamento

---

# 🏗️ Arquitetura do Projeto


                           ┌────────────────────┐
                           │      Internet      │
                           └─────────┬──────────┘
                                     │
                           ┌─────────▼──────────┐
                           │ Internet Gateway   │
                           └─────────┬──────────┘
                                     │
                        ┌────────────▼────────────┐
                        │      Route Table        │
                        │     0.0.0.0/0 → IGW    │
                        └────────────┬────────────┘
                                     │
                           ┌─────────▼──────────┐
                           │   Public Subnet    │
                           │    10.0.1.0/24     │
                           └─────────┬──────────┘
                                     │
                         ┌───────────▼───────────┐
                         │      EC2 Instance     │
                         │      Amazon Linux     │
                         └───────────┬───────────┘
                                     │
                           ┌─────────▼──────────┐
                           │ Security Group SSH │
                           │      TCP/22        │
                           └────────────────────┘
```

---

# ☁️ Serviços AWS Utilizados

| Serviço          | Finalidade                  |
| ---------------- | --------------------------- |
| VPC              | Rede privada virtual        |
| Subnet           | Segmentação da rede         |
| Internet Gateway | Acesso à internet           |
| Route Table      | Controle de rotas           |
| Security Group   | Firewall da instância       |
| EC2              | Máquina virtual             |
| S3               | Backend remoto do Terraform |

---

# 📂 Estrutura Recomendada do Repositório

```bash
terraform-aws-project/
│
├── aws-vpc/
│   ├── backend.tf
│   ├── main.tf
│   ├── network.tf
│   ├── outputs.tf
│   ├── variables.tf
│   └── terraform.tfvars
│
├── aws-vm-provisioners/
│   ├── main.tf
│   ├── vm.tf
│   ├── outputs.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── test.txt
│   └── scripts/
│       └── setup.sh
│
│
├── .gitignore
├── README.md
└── LICENSE
```

---

# 🔐 .gitignore Recomendado

```gitignore
# Terraform
.terraform/
*.tfstate
*.tfstate.*
crash.log

# Sensitive files
aws-key
aws-key.pub
*.pem

# Variables
*.tfvars

# IDE
.vscode/
.idea/
```

---

# 🌐 Projeto 1 — AWS VPC

Responsável por criar toda infraestrutura de rede.

## Recursos Provisionados

* VPC
* Public Subnet
* Internet Gateway
* Route Table
* Route Table Association
* Security Group

## Conceitos Trabalhados

* CIDR
* Subnets
* Public Networking
* Routing
* Security Groups
* Terraform Outputs

---

# 🖥️ Projeto 2 — AWS VM Provisioners

Responsável por criar a EC2 utilizando informações do projeto de networking através de `terraform_remote_state`.

## Recursos Provisionados

* EC2 Instance
* AWS Key Pair
* Provisioners
* Remote State

## Provisioners Utilizados

### local-exec

Executa comandos localmente.

### remote-exec

Executa comandos via SSH na EC2.

### file

Transfere arquivos da máquina local para a instância.

---

# 🔄 Remote State

A comunicação entre os dois projetos ocorre através do:

```hcl
data "terraform_remote_state" "network" {
  backend = "s3"
}
```

O projeto da EC2 reutiliza:

* subnet_id
* security_group_id
* outputs da VPC

---

# 📤 Outputs

Exemplo de outputs utilizados:

```hcl
output "vm_public_ip" {
  value = aws_instance.instance.public_ip
}
```

---

# 🔑 SSH Key Pair

As chaves SSH NÃO foram incluídas no repositório.

Para gerar:

```bash
ssh-keygen -t ed25519 -f aws-key
```

Conexão SSH:

```bash
ssh -i aws-key ec2-user@IP_PUBLICO
```

---

# 🚀 Fluxo do Projeto

```text
Terraform Apply
        ↓
Criação da VPC
        ↓
Criação da Subnet
        ↓
Criação do Internet Gateway
        ↓
Criação da Route Table
        ↓
Criação do Security Group
        ↓
Outputs exportados
        ↓
terraform_remote_state
        ↓
Provisionamento da EC2
        ↓
SSH Connection
        ↓
Provisioners executados
```

---

# 🧠 Principais Aprendizados

Durante este projeto foram praticados:

* Infrastructure as Code
* Terraform State
* Remote State
* AWS Networking
* EC2 Provisioning
* SSH Authentication
* Security Groups
* Public vs Private Networking
* Resource Dependencies
* Terraform Outputs
* Provisioners

---

# 📚 Como Executar

## 1. Inicializar Terraform

```bash
terraform init
```

## 2. Validar configuração

```bash
terraform validate
```

## 3. Gerar plano

```bash
terraform plan
```

## 4. Provisionar infraestrutura

```bash
terraform apply
```

---

# 📌 Observações

Projeto desenvolvido para estudos e prática de Terraform + AWS.

Toda infraestrutura foi provisionada utilizando Infrastructure as Code (IaC).

---

