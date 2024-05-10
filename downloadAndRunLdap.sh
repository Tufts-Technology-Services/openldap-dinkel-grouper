#!/bin/bash

mkdir ldap-seed-data
cd ldap-seed-data
wget https://raw.githubusercontent.com/Tufts-Technology-Services/openldap-dinkel-grouper/main/ldap-seed-data/01-users.ldif
#wget https://raw.githubusercontent.com/Tufts-Technology-Services/openldap-dinkel-grouper/main/ldap-seed-data/03-more-users.ldif
wget https://raw.githubusercontent.com/Tufts-Technology-Services/openldap-dinkel-grouper/main/ldap-seed-data/03-redirect.ldif
cd ..
mkdir schemas
cd schemas
wget https://raw.githubusercontent.com/Tufts-Technology-Services/openldap-dinkel-grouper/main/schemas/eduperson.ldif
cd ..
wget https://raw.githubusercontent.com/Tufts-Technology-Services/openldap-dinkel-grouper/main/Dockerfile
wget https://raw.githubusercontent.com/Tufts-Technology-Services/openldap-dinkel-grouper/main/subject.properties
wget https://raw.githubusercontent.com/Tufts-Technology-Services/openldap-dinkel-grouper/main/grouper-loader.properties
docker build -t openldap-dinkel-grouper .
docker run -d -p 389:389 --name openldap-dinkel-grouper --mount type=bind,source="$PWD/ldap-seed-data",target=/etc/ldap/prepopulate \
   -e SLAPD_PASSWORD=secret -e SLAPD_CONFIG_PASSWORD=secret -e SLAPD_DOMAIN=tufts.edu openldap-dinkel-grouper

# wget https://raw.githubusercontent.com/Tufts-Technology-Services/openldap-dinkel-grouper/main/downloadAndRunLdap.sh
# chmod +x downloadAndRunLdap.sh
# ./downloadAndRunLdap.sh
# cleanup: 
#   docker rm -f openldap-dinkel-grouper
#   docker rmi openldap-dinkel-grouper:latest


#DO NOT USE
#https://raw.githubusercontent.com/Internet2/grouper/GROUPER_2_5_BRANCH/grouper-misc/openldap-dinkel-grouper/.. . Use below instead
# https://raw.githubusercontent.com/Tufts-Technology-Services/openldap-dinkel-grouper/main/..
