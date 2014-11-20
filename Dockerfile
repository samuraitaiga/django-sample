FROM     centos
MAINTAINER TAIGA "samuraitaiga@gmail.com"

# make sure the package repository is up to date

# prepare ansible
RUN yum install -y python python-setuptools wget git
RUN cd /root && wget "https://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm"
RUN cd /root && rpm -ivh epel-release-7-2.noarch.rpm
RUN yum install -y ansible

# checkout repository which has ansible playbook
RUN git clone https://github.com/samuraitaiga/django-sample.git /opt/django-sample.git
RUN cd /opt/django-sample && ansible-playbook playbook.yml --connection=local

EXPOSE 8000
CMD    ["python", "/opt/django-sample/djangosample/manage.py", "runserver", "0.0.0.0:8000"]
