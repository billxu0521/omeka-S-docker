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

預設帳號為
admin@test.io / password

### docker-compose.yml
- 預設將phpMyadmin的關閉
- 記得若修改密碼，須同步修改omeka-s/config/database.ini
- 記得修改hostname

## 建置方式
1. 複製回復>啟動
2. LXC容器要注意有開啟nesting 在option>feature
3. 若OmekaS版本有更新可以考慮更新(參考說明)
4. 放置模組與主題(依照需求)
5. 啟動doecker
6. 設定OmekaS
7. phpMyadmin視狀況選擇開啟關閉
8. 複製>大量建置

### 放置資料
若需要放置模組、主題等檔案
請放置到目錄對應docker-compose.yml中omekas的volume
預設為lxc容器中的root/omeka-s
可以考慮打開ssh，參考下方

#### 打開ssh
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

#### 備註
- Omekas安裝時需注意files的權限，在這個備份範本中已經處理完畢
- 另外也要注意config/database.ini也已經設定完畢，指向到DB

## 設定筆記
以下內容皆已經在本備份範本預先處理完
若有需要重新設定可以參考本段內容

### 安裝OmekaS
將omeka-s-3.2.2.zip解壓縮
放置到目錄對應docker-compose.yml中omekas的volume

### 自動重開
已經設定完畢
可以參考文檔
docker-startup.sh

### 修改cron，進行排程ls 
機器重啟後自動啟動docker
在/etc/crontab 加上這行

```
@reboot root /root/docker-startup.sh
```

### 新增偵測啟動
(參考)[https://github.com/vishnubob/wait-for-it]
預設已經註解掉
參照Dockerfile#detect DB 
由於自動開機後要確保DB已經先運作再啟動OmekaS
所以多加了wait-for-it的偵測動作
此bash會先偵測DB是否先啟動，若不啟動則重試直到有偵測到

在LXC容器中新增 wait-for-it.sh
剩下Dockefile會處理
