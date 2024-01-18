import json
import os
import hvac


def lambda_handler(event, context):
    # Obtém as variáveis de ambiente do Vault
    vault_addr = os.environ.get("VAULT_ADDR")
    vault_token = os.environ.get("VAULT_TOKEN")
    secret_path = os.environ.get("SECRET_PATH")

    # Conecta ao Vault
    client = hvac.Client(url=vault_addr, token=vault_token)

    # Lê o segredo do Vault
    secret_data = client.read(secret_path)

    # Retorna o segredo como resposta
    return {
        'statusCode': 200,
        'body': json.dumps(secret_data)
    }
