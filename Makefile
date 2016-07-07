# github.com/umcloud/clases-devops/c06/p02/Makefile
help:
	@echo "Use:"
	@echo "make deploy     "
	@echo "make console-log"
	@echo "make destroy"
	@echo

# Validacion y seteo de ENV movido al final para permitir
# bash auto-completion

deploy:       deploy-db       deploy-web       deploy-fe
destroy:      destroy-db      destroy-web      destroy-fe
console-log:  console-log-db  console-log-web  console-log-fe


deploy-db:
	make do-deploy-db 

deploy-web:
	make do-deploy-web

deploy-fe:
	make do-deploy-fe 

do-deploy-%:
	 @nova list|grep -q -w -- '$(*)-$(USER)-wp' && exit 0; \
            set -x;sleep 2;./$(*).sh
destroy-%:
	@nova list|awk '/\<$(*)-$(USER)-wp\>/ { print $$2 }' | xargs -rtl1 nova delete

console-log-%:
	@echo "*** $(USER): $(@) ***:"
	@nova list|awk '/\<$(*)-$(USER)-wp\>/  { print $$2 }' | xargs -rtl1 nova console-log --length 40; sleep 2

