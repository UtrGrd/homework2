Выполнял всё по методичке, дополнительное задание тоже выполнено.
Различия с методичкой:
1. При сохранении mdadm.conf выбрал путь /etc/mdadm.conf, а не /etc/mdadm/mdadm.conf, потому что непонятно, зачем создавать лишнюю папку.
2. При попытке настроить автоматическое поднятие рейда пришлось следующие строки VagrantFile:
```
 	  box.vm.provision "shell", inline: <<-SHELL
	      mkdir -p ~root/.ssh
              cp ~vagrant/.ssh/auth* ~root/.ssh
	      yum install -y mdadm smartmontools hdparm gdisk
  	  SHELL
 ```
 Удалить и добавить вышеуказанные команды в скрипт kgndsn_hw2.sh, так как ```box.vm.provision``` выполнялся позже скрипта, и скрипт корректно не отрабатывал из-за неустановленного mdadm. Команду ```config.vm.provision "shell", path: "kgndsn_hw2.sh"``` добавлял после блока ```box.vm.provision```, в разные места, но он всё равно отрабатывал раньше.
