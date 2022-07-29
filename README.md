## 說明
這是安裝好mariaDB + OmekaS + phpMyadmin的 Docker in LXC 容器

***也可以當作一般Docker使用***

已設定完自動開起docker  

OmekaS尚未設定完成

OmekaS版本為3.2.2

啟動方式為
```
docker-compose up
```
OmekaS的系統文檔放置在LXC的環境中
若需要更新或放置檔案，開啟ssh使用SFTP傳輸即可


## 自動重開
已經設定完畢
可以參考文檔
docker-startup.sh

### 修改cron，進行排程ls 
機器重啟後自動啟動docker
在/etc/crontab 加上這行

```
@reboot root /root/docker-startup.sh
```

## 應用
1.複製回復>啟動
2.若OmekaS版本有更新可以考慮更新(參考說明)
3.放置模組與主題(依照需求)
4.啟動doecker
5.設定OmekaS
6.phpMyadmin視狀況選擇開啟關閉
7.複製>大量建置

## 打開ssh
修改sshd_config文件

```shell
nano /etc/ssh/sshd_config
```

將permitrootlogin prohibit-password
改成permitrootlogin yes

最後重開
```shell
/etc/init.d/ssh restart
```
