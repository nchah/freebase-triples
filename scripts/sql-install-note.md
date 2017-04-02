1. installed MySQL

2. created a my.cnf configuration from the template

$ sudo cp /usr/local/mysql/support-files/my-default.cnf /etc/my.cnf

3. also updated --dirdata=/Volumes/Seagate/data/data in:

$ sudo vim /Library/LaunchDaemons/com.oracle.oss.mysql.mysqld.plist

4. After updates, shutdown mysql and restart:

$ mysqladmin -u root -p shutdown

$ sudo chown -RL root:mysql /usr/local/mysql
$ sudo chown -RL mysql:mysql /usr/local/mysql/data
$ sudo /usr/local/mysql/support-files/mysql.server star
