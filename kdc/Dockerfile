FROM alpine

RUN apk add --no-cache heimdal

RUN mkdir /etc/docker-kdc

COPY krb5.conf /etc/krb5.conf
COPY krb5.conf /etc/docker-kdc/krb5.conf

RUN mkdir -p /var/heimdal/ && kstash --random-key
RUN /usr/sbin/kdc --config-file=/kdc.conf --ports=88 --detach && echo -e "init EXAMPLE.COM\n\n" | kadmin -l && kadmin -l add --use-defaults --password=admin admin/admin && kadmin -l ext_keytab -k /etc/docker-kdc/admin.keytab admin/admin && chmod 644 /etc/docker-kdc/admin.keytab

COPY entrypoint.sh /entrypoint.sh

EXPOSE 88
ENTRYPOINT ["/entrypoint.sh"]

