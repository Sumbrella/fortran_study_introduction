# Windows 下配置 Fortran 编译环境
## 目录

1. [Mac 编译器安装](#1)
    1. [Gfortran](#1.1)
    2. [Intel](#1.1)
2. [Mac 推荐编辑器及其配置](#2)
    1. [Visual Studio Code](#2.1)
    2. [Atom](#2.2)
    3. [Sublime Text](#2.3)



## <span id="1">编译器安装</span>
### <span id="1.1">GFortran</span>

### <span id="1.2"> Intel </span>


***
## <span id="2"> 推荐编辑器及其配置 </span>

### <span id="2.1"> Visual Studio Code</span>
`visual studio code`是美国微软公司是一个项目：运行于 Mac OS X、Windows和 Linux 之上的，针对于编写现代 Web 和云应用的跨平台源代码编辑器。

整体上来说`vscode` 有着好看的界面，轻量的环境，丰富的插件，是一款很不错的编辑器。

#### Visual Studio Code 安装
按照安装包要求安装即可。
**[官网](https://code.visualstudio.com)**

#### Fortran 插件安装
在右侧菜单栏中选择`Plugin`(小方块)，搜索并安装 `Modern Fortran`.
![Screen Shot 2021-07-22 at 12.08.36 AM](/assets/Screen%20Shot%202021-07-22%20at%2012.08.36%20AM.png)
另外，如果需要中文，可以搜索chinese并安装中文插件。
![Screen Shot 2021-07-22 at 12.09.25 AM](/assets/Screen%20Shot%202021-07-22%20at%2012.09.25%20AM.png)

#### 第一份Fortran代码
新建任意一个后缀为 `fortran` 后缀的源文件，输入如下代码。
![Screen Shot 2021-07-22 at 12.12.21 AM](/assets/Screen%20Shot%202021-07-22%20at%2012.12.21%20AM.png)
在右上角点击小三角Run即可运行代码。
***

### <span id="2.2">Atom</span>

Atom 是 Github 开源的文本编辑器，这个编辑器完全是使用Web技术构建的(基于Node-Webkit)。启动速度快，提供很多常用功能的插件和主题，可以说Atom已经足以胜任“半个IDE”了。

Atom 对Fortran 支持良好，==笔者Fortran使用的就是Atom==。
但是可能本体和插件下载速度较慢，并且==配置起来有一点麻烦==。
为了搭建舒适的环境需要 **python2.7+ 或 python3.0+，并安装`fortran-language-server`** 支持。
如果嫌麻烦可以跳过。

#### Atom 安装
[Atom官网](https://atom.io) 下载安装即可。

#### Python 安装
请安装好python2.7+ 或 python3.0+，并安装好 pip。
> [python安装教程](http://c.biancheng.net/view/4164.html)
> [python安装pip](https://www.jianshu.com/p/263b9107a047)
> [python更换清华源](https://blog.csdn.net/qq_43340659/article/details/82948529)

#### fortran-language-server 安装
- python2
    ```bash
    pip install fortran-language-server
    ```
- python3
    ```bash
    pip3 install fortran-language-server
    ```
如果报如下错误:

`'install_requires' must be a string or list of strings containing valid project/version requirement specifiers`

请尝试更新`setuptools`:
```bash
pip install -U setuptools
pip install fortran-language-server
```

#### Atom + ide-fortran

进入Fortran后，使用 `Command + ,` 进入设置界面，选择 `Install`, 搜索 `fortran`

<img src=/assets/Screen%20Shot%202021-07-21%20at%204.13.15%20PM.png width=60%>

安装`ide-fortran` 及 `language-fortran`.

另外，再搜索并安装 `atom-ide-ui`.
<img src=/assets/Screen%20Shot%202021-07-22%20at%2012.04.46%20AM.png width=60%>

安装完成后重启 `Atom`。

#### 项目创建
1. 打开 `Atom` 。

2. 选择 `Add folders` 随意打开一个项目文件夹。

3. 打开后创建一个`fortran`源文件。
 <img src=/assets/Screen%20Shot%202021-07-21%20at%204.31.09%20PM.png width=60%>

4.输入如下代码
```fortran
program main
    implicit none
    write(*, *) "Hello World!"
end program main
```
5.右击项目目录，选择 `Make Active Fortran Project`
    <img src=/assets/Screen%20Shot%202021-07-21%20at%204.34.27%20PM.png width=60%>

6. 下方会弹出控制栏
  <img src=/assets/Screen%20Shot%202021-07-21%20at%204.35.27%20PM.png width=80%>
 使用快捷键 `control + F6` 编译并运行。并在下方 output 栏中查看运行结果。


#### 支持特性
- 文件大纲
- 自动补全
- 签名帮助
- 跳转Peek定义
- GoTo 实现
- 悬停
- 查找参考资料
- 全项目范围的符号搜索
- 符号重命名
- 文档解析（Doxy和FORD风格)
***

### <span id="2.3">Sublime Text</span>

我觉得配置完以后手感一般，特性也比较少。
可以参考博客<https://www.cnblogs.com/kaikaikai/p/9827283.html>
