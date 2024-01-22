data "aws_secretsmanager_secret_version" "credentials" {
    secret_id = "fiap-db"
}

locals {
    db_credentials = jsondecode(
        data.aws_secretsmanager_secret_version.credentials.secret_string
    )
}

resource "aws_db_instance" "fiapdb" {
  allocated_storage      = 20 # Tamanho em GB
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "12.16"
  instance_class         = "db.t2.micro"     # Tipo de instância
  identifier             = local.db_credentials.dbInstanceIdentifier       # Identificador da instância RDS
  name                   = "fiap"            # Nome da base de dados dentro da instância
  username               = local.db_credentials.username        # Usuário do banco de dados
  password               = local.db_credentials.password # Senha do banco de dados
  parameter_group_name   = "default.postgres12"
  vpc_security_group_ids = ["${data.terraform_remote_state.app.outputs.cluster_security_group}"]
  skip_final_snapshot    = true # Pula snapshot final ao destruir o banco de dados. Em produção, talvez queira definir como false.
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.id
}

data "terraform_remote_state" "app" {
  backend = "s3"
  config = {
    bucket = "terraform-backend-mv"
    key    = "app"
    region = "us-east-1"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
  name = "dbsubnet"
  subnet_ids = [
    "${data.terraform_remote_state.app.outputs.private_subnet_a}",
    "${data.terraform_remote_state.app.outputs.private_subnet_b}",
  ]
}