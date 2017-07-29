#!/bin/sh

exitCode=0

docker-compose -f $(dirname $0)/docker-compose.yml up -d

# wait for containers to be ready
sleep 5

# set language
curl -s 'http://localhost:8080/core/install.php' -H 'Content-Type: application/x-www-form-urlencoded' --data 'langcode=en&form_build_id=form-fPpu5-9pOnRAMrtYQ2ehyiwZjWliharOC4FeSiBbR_c&form_id=install_select_language_form&op=Save+and+continue'

# set profile
curl -s 'http://localhost:8080/core/install.php?rewrite=ok&langcode=en' -H 'Content-Type: application/x-www-form-urlencoded' --data 'profile=minimal&form_build_id=form-bC2woRZCxgBer7EhRd9tQjA_66ScgtZCHg_qZpOEKBU&form_id=install_select_profile_form&op=Save+and+continue'

# set database
curl -s 'http://localhost:8080/core/install.php?rewrite=ok&langcode=en&profile=minimal' -H 'Content-Type: application/x-www-form-urlencoded' --data 'driver=pgsql&mysql%5Bdatabase%5D=&mysql%5Busername%5D=&mysql%5Bpassword%5D=&mysql%5Bhost%5D=localhost&mysql%5Bport%5D=3306&mysql%5Bprefix%5D=&sqlite%5Bdatabase%5D=sites%2Fdefault%2Ffiles%2F.ht.sqlite&sqlite%5Bprefix%5D=&pgsql%5Bdatabase%5D=postgres&pgsql%5Busername%5D=postgres&pgsql%5Bpassword%5D=secret_password&pgsql%5Bhost%5D=postgres&pgsql%5Bport%5D=5432&pgsql%5Bprefix%5D=&form_build_id=form-cOvqvc8xjNP-KL2wiTOf11hcdpAZcXC9TwqW1bYTImI&form_id=install_settings_form&op=Save+and+continue' -b cookies.txt -c cookies.txt

# check for setup percentage
checkCURL="curl -s 'http://localhost:8080/core/install.php?rewrite=ok&langcode=en&profile=minimal&id=1&op=do_nojs&op=do&_format=json' -X POST -b cookies.txt -c cookies.txt | sed -e 's/^.*\"percentage\":\"\([^\"]*\)\".*$/\1/'"
until [ $(eval $checkCURL) -eq 100 ]
do
	sleep 1
done

# set setup as finished
curl -s 'http://localhost:8080/core/install.php?rewrite=ok&langcode=en&profile=minimal&id=1&op=do_nojs&op=finished' -b cookies.txt -c cookies.txt

# set site configuration
curl -s 'http://localhost:8080/core/install.php?rewrite=ok&langcode=en&profile=minimal' -H 'Content-Type: application/x-www-form-urlencoded' --data 'site_name=Docker+Compose+Test&site_mail=test1234%40docker.tst&account%5Bname%5D=admin&account%5Bpass%5D%5Bpass1%5D=adminpassword&account%5Bpass%5D%5Bpass2%5D=adminpassword&account%5Bmail%5D=test1234%40docker.tst&site_default_country=GB&date_default_timezone=UTC&enable_update_status_emails=1&form_build_id=form-nu6CmlOPAkRpB2syjRccO5yPpcRWrQKlUr1y8cY_MuY&form_id=install_configure_form&op=Save+and+continue' -b cookies.txt -c cookies.txt

# fetch authenticated page
curl -s http://localhost:8080/user/1 -c cookies.txt | grep 'Congratulations, you installed Drupal!'
[ $? -eq 0 ] && echo "Worked!" || { echo "Something went wrong.."; exitCode=1; }

docker-compose -f $(dirname $0)/docker-compose.yml down -v

# report exit code from last curl command
exit $exitCode