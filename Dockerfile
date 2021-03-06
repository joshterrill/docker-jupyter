FROM ubuntu:16.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install net-tools nginx python-pip && \
    pip install --upgrade pip && \
    pip install jupyter && \
    useradd -ms /bin/bash josh && \
    rm -f /etc/nginx/fastcgi.conf /etc/nginx/fastcgi_params && \
    rm -f /etc/nginx/snippets/fastcgi-php.conf /etc/nginx/snippets/snakeoil.conf
EXPOSE 80
EXPOSE 443
COPY nginx/ssl /etc/nginx/ssl
COPY nginx/snippets /etc/nginx/snippets
COPY nginx/sites-available /etc/nginx/sites-available
COPY .jupyter/jupyter_notebook_config.py /home/josh/.jupyter/jupyter_notebook_config.py
COPY etc/startup.sh /etc/startup.sh
RUN chown -R josh:josh /home/josh/.jupyter
ENTRYPOINT ["/etc/startup.sh"]
