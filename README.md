### 常用脚本

1. [bchrome](https://github.com/dchaofei/shells/blob/master/bchrome) 启动 chrome

2. [bphpstorm](https://github.com/dchaofei/shells/blob/master/bphpstorm) 启动 phpstorm

3. [got](https://github.com/dchaofei/shells/blob/master/got) 创建 go 文件
    ```bash
    $ got main Or got main.go 创建 go 文件
    $ got main r 【arg１　arg2 ...】 执行
    $ <leader> + . vim 内执行
    ```
    
4. [yii](https://github.com/dchaofei/shells/blob/master/yii) 执行 yii command

5. [fiddler](https://github.com/dchaofei/shells/blob/master/fiddler) 启动 fiddler

6. [inflect](https://github.com/dchaofei/shells/blob/master/inflect) 英语单词单数转复数
    ```bash
    $ inflect number
    numbers
    ```
    
7. [ssh_auto_password](https://github.com/dchaofei/shells/blob/master/ssh_auto_password) ssh 自动输入密码  
	通过 在 ssh config 里配置 `#Password 你的密码` 可以实现自动输入密码，依赖于`sshpass`  
	先取个方便的名字 `ln -s ssh_auto_password /usr/local/bin/ssh`
	
	```bash
	$ ssha host
	```

