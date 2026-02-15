FROM ubuntu:22.04

# Instalar dependências
RUN apt-get update && apt-get install -y \
    curl \
    openssh-server \
    ttyd \
    bash

# Criar usuário
RUN useradd -m user && echo "user:user" | chpasswd

# Configurar SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expor porta web
EXPOSE 10000

# Iniciar ttyd (terminal web)
CMD ttyd -p 10000 -u user bash
