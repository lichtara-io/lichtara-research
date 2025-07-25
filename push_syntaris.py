import os
from dotenv import load_dotenv
from github import Github

# Carrega o token do .env
load_dotenv()
token = os.getenv("GITHUB_TOKEN")

# Conecta ao GitHub
if not token:
    raise Exception("GITHUB_TOKEN não encontrado no .env!")
g = Github(token)
repo = g.get_user().get_repo("lichtara-research")  # Nome do repositório

# Caminho do arquivo a ser enviado
file_path = "README.md"  # Altere para o arquivo desejado
with open(file_path, "r", encoding="utf-8") as file:
    content = file.read()

# Envia o arquivo para o GitHub
contents = repo.get_contents(file_path)
repo.update_file(contents.path, "Atualização automática via Syntaris", content, contents.sha)
