## docker-php-wine

本容器包含了包含了wine的容器,可以运行能在wine运行的程序.
配置php可以做在线功能的二次开发

容器包含以下的软件:

* Xvfb - X11 in a virtual framebuffer
* x11vnc - A VNC server that scrapes the above X11 server
* [noNVC](https://kanaka.github.io/noVNC/) - A HTML5 canvas vnc viewer
* Fluxbox - a small window manager
* Explorer.exe - to demo that it works



## 运行

    docker run --rm -p 8080:8080 -p 8000:80 solarkennedy/wine-x11-novnc-docker
    xdg-open http://localhost:8080


## php中调用wine

    putenv('LANGUAGE=en_US.UTF-8');
    putenv('WINEARCH=win32');
    putenv('WINEPREFIX=/root/prefix32');
    $command = '/usr/bin/wine Z:\\\\root\\\\bin\\\\samesoft.exe ';

    exec($command,$log,$status);// $log 输出的内容 $status 运行状态
    if($status!=0){
      echo ('执行命令失败,error code: '.$status);
    }else{
      echo('执行成功, msg: ' .$log);
    }
## nginx 代理vnc
如果需要在在nginx中显示远程的代理页面.需要在nginx中添加以下的配置

    location /websockify {
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-Scheme $scheme;
      proxy_set_header X-Forwarded-Proto  $scheme;
      proxy_set_header X-Forwarded-For    $remote_addr;
      proxy_pass       http://172.17.0.1:8000;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "Upgrade";
    }

## 引用
https://github.com/solarkennedy/wine-x11-novnc-docker