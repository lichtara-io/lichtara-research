import os
from dotenv import load_dotenv
import subprocess

# Carrega variáveis do .env
load_dotenv()
GITHUB_TOKEN = os.getenv('GITHUB_TOKEN')

# Configuração do repositório
REPO_URL = 'https://github.com/debora-m-lutz/lichtara-os.git'
BRANCH = 'main'

# Função para adicionar, commitar e fazer push dos arquivos

def push_files(files, commit_message):
    # Adiciona arquivos
    subprocess.run(['git', 'add'] + files)
    # Commit
    subprocess.run(['git', 'commit', '-m', commit_message])
    # Push
    subprocess.run(['git', 'push', REPO_URL, BRANCH])

if __name__ == '__main__':
    # Exemplo: arquivos a serem enviados
    files = ['README.md', 'index.html']  # Edite conforme necessário
    commit_message = 'Atualização automática via Syntaris'
    push_files(files, commit_message)
    print('Push realizado com sucesso!')
