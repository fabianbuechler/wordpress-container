---
Management:
  Host: https://my.easyname.at/
  User: support@easyname.at
  Pass: easynametest123
SSH:
  Host: e15756-ssh.services.easyname.eu
  User: e15756
  Pass: .lvvo6ez9fig
Wordpress:
  Website: http://dinky.easynametest.com
  Admin: http://dinky.easynametest.com/wp-admin
  Dir: /html/apps/wordpress-97153/
  Admin:
    User: ttattoo
    Pass: jrj7d4c2em
  DB:
    Name: u8342db205
    User: u8342db205
    Pass: Mtr37bGN
---
# Wordpress Container from easyname Hosting Backup

## Creating a Backup

- DB backup:

  ```shell
  mysqldump
  ```
