 # 1. Actualizar repositorios, instalar Nginx, instalar git para traer el repositorio
    apt update
    apt install -y nginx git vsftpd

    # Verificar que Nginx esté funcionando
    sudo systemctl status nginx

    # 2. Crear la carpeta del sitio web
    sudo mkdir -p /var/www/miweb/html

    # Clonar el repositorio de ejemplo en la carpeta del sitio web
    git clone https://github.com/cloudacademy/static-website-example /var/www/miweb/html

    # Asignar permisos adecuados
    sudo chown -R www-data:www-data /var/www/miweb/html
    sudo chmod -R 755 /var/www/miweb

    # 3. Configurar Nginx para servir el sitio web
    # Crear archivo de configuración del sitio en sites-available
    sudo cp /vagrant/miweb /etc/nginx/sites-available/

    # Crear enlace simbólico en sites-enabled
    sudo ln -s /etc/nginx/sites-available/miweb /etc/nginx/sites-enabled/

    # Crear usuario carlos
    sudo adduser carlos
    echo "carlos:carlos" | sudo chpasswd

    # Crea la carpeta
    sudo mkdir /home/carlos/ftp

    # Permisos para la carpeta
    sudo chown vagrant:vagrant /home/carlos/ftp
    sudo chmod 755 /home/carlos/ftp

    # Crear los certificados de seguridad
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

    # Agregar el usuario carlos al grupo www-data
    sudo usermod -aG www-data carlos

    # Crear la nueva carpeta de la página web
    sudo mkdir -p /var/www/extrem/html

    # Asignar permisos
    sudo chown -R www-data:carlos /var/www/
    sudo chmod -R 775 /var/www/

    # Copiar la configuración para el sitio extrem
    sudo cp -r /vagrant/extrem /etc/nginx/sites-available/

    # Crear enlace simbólico en sites-enabled
    sudo ln -s /etc/nginx/sites-available/extrem /etc/nginx/sites-enabled/

    # Reiniciar Nginx para aplicar los cambios
    sudo systemctl restart nginx