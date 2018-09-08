# Docker Jackett

### Ports
- **TCP 9117** - Web Interface

### Volumes
- **/volumes/config** - Jackett configuration data
- **/volumes/media** - Jackett blackhole folder

Docker runs as uid 65534 (nobody on debian, nfsnobody on fedora). When mounting volumes from the host, ensure this uid has the correct permission on the folders.

## Running

The quickest way to get it running without integrating with a download client or media server (plex)
```
sudo docker run --restart always --name jackett -p 9117:9117 -v /path/to/your/media/folder/:/volumes/media -v /path/to/your/completed/downloads:/volumes/completed tuxeh/jackett
```

You can link to the download client's volumes and plex using something similar:
```
sudo docker run --restart always --name jackett --volumes-from plex --link plex:plex --volumes-from deluge --link deluge:deluge -p 8989:8989 tuxeh/Jackett
```
