#!/bin/bash


# JQ=/usr/bin/jq
# curl https://stedolan.github.io/jq/download/linux64/jq > $JQ && chmod +x $JQ

# Stop the admin wizard from running
echo "nexus.onboarding.enabled=false" >> /opt/sonatype/nexus/bin/nexus.vmoptions

new_password="admin"

if [[ -n $(curl -v -X HEAD -u admin:`cat /nexus-data/admin.password` http://localhost:8081/service/rest/v1/script 2>&1 | grep 200) ]]
then
  pass=`cat /nexus-data/admin.password`
else
  pass=$new_password
fi

echo "${pass}"

# Removing (potential) previously declared Groovy script update_admin_password
curl --header "Content-Type: application/json" \
--request DELETE \
-u admin:${pass} \
http://localhost:8081/service/rest/v1/script/update_admin_password


readarray -t SCRIPT_FORMATTED < /scripts/update_admin_password.groovy

# rm /scripts/update_admin_password.groovy.f
# touch /scripts/update_admin_password.groovy.f
# for ((i=0; i < ${#SCRIPT_FORMATTED[*]}; i++))
# do
#     echo "\"${SCRIPT_FORMATTED[$i]}\"," >> /scripts/update_admin_password.groovy.f
# done

# cat /scripts/update_admin_password.groovy.f



data=$(cat /scripts/update_admin_password.groovy.f)

# echo $script

json_data() {
  cat <<EOF
{"name": "update_admin_password","type": "groovy","content": [${data}]}
EOF
}

echo $(json_data)


# Declaring Groovy script update_admin_password
curl -u admin:${pass} \
-H "Content-Type: application/json" \
-X POST --data "$(json_data)" \
"http://localhost:8081/service/rest/v1/script"


curl --header "Content-Type: application/json" \
--request POST \
-u admin:${pass} \
--data '{"new_password":"admin"}' \
http://localhost:8081/service/rest/v1/script/update_admin_password/run

if [[ -n $(curl -v -X HEAD -u admin:`cat /nexus-data/admin.password` http://localhost:8081/service/rest/v1/script 2>&1 | grep 200) ]]
then
  pass=`cat /nexus-data/admin.password`
else
  pass=$new_password
fi

echo "${pass}"











# - name: Register defined admin password for next operations
#   set_fact:
#     current_nexus_admin_password: "{{ nexus_admin_password }}"
#   when: nexus_api_head_with_defined_password.status == 200
#   no_log: true

# - name: Check if admin.password file exists
#   stat:
#     path: "{{ nexus_data_dir }}/admin.password"
#   register: admin_password_file

# - name: Get generated admin password from file (nexus >= 3.17)
#   when:
#     - admin_password_file.stat.exists
#     - nexus_api_head_with_defined_password.status == 401
#     - nexus_version is version_compare('3.17.0', '>=')
#   block:
#     - name: Slurp content of remote generated password file
#       slurp:
#         src: "{{ nexus_data_dir }}/admin.password"
#       register: _slurpedpass

#     - name: Set default password from slurped content
#       set_fact:
#         nexus_default_admin_password: "{{ _slurpedpass.content | b64decode }}"

# - name: Access scripts API endpoint with default admin password
#   uri:
#     url: "{{ nexus_api_scheme }}://{{ nexus_api_hostname }}:{{ nexus_api_port }}\
#       {{ nexus_api_context_path }}{{ nexus_rest_api_endpoint }}"
#     method: 'HEAD'
#     user: 'admin'
#     password: "{{ nexus_default_admin_password }}"
#     force_basic_auth: yes
#     status_code: 200, 401
#     validate_certs: "{{ nexus_api_validate_certs }}"
#   register: nexus_api_head_with_default_password
#   when: nexus_api_head_with_defined_password.status == 401

# - name: Register default admin password for next operations
#   set_fact:
#     current_nexus_admin_password: "{{ nexus_default_admin_password }}"
#   when: (nexus_api_head_with_default_password.status | default(false)) == 200

# - name: Ensure current Nexus password is known
#   fail:
#     msg: >-
#       Failed to determine current Nexus password
#       (it is neither the default/generated nor the defined password).
#       If you are trying to change nexus_admin_password after first
#       install, please set `-e nexus_default_admin_password=oldPassword`
#       on the ansible-playbook command line.
#       See https://github.com/ansible-ThoTeam/nexus3-oss/blob/master/README.md#change-admin-password-after-first-install
#   when: current_nexus_admin_password is not defined




# зарегистрировать скрипт




# - name: Change admin password if we are still using default
#   block:
#     - include_tasks: call_script.yml
#       vars:
#         script_name: update_admin_password
#         args:
#           new_password: "{{ nexus_admin_password }}"

#     - name: Admin password changed
#       set_fact:
#         current_nexus_admin_password: "{{ nexus_admin_password }}"
#       no_log: true

#     - name: Clear generated password file from install (nexus > 3.17)
#       file:
#         path: "{{ nexus_data_dir }}/admin.password"
#         state: absent
#       when: nexus_version is version_compare('3.17.0', '>=')

#   when: (nexus_api_head_with_default_password.status | default(false)) == 200