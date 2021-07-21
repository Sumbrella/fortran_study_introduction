# Mac 下配置 Fortran 编译环境

## 目录
[[toc]]

1. [Mac 编译器安装](#1)
2. [Mac 编辑器选择和配置](#2)


## <span id="1">编译器安装</span>
### GFortran
GFortran 是 GNU 出品的开源编译器，是 GCC 的组成部分, 也是 Linux 平台下最主流的编译器。 也是 Linux 平台下最主流的编译器。

GfFrtran被集成在gcc中，而macOS本身不提供gcc而是clang。

1. **通过 brew 安装**
如果你的 Mac 电脑上安装了 `homebrew` 可以直接在终端输入
    ```bash
    $ brew install gcc
    ```

    > [homebrew安装](https://zhuanlan.zhihu.com/p/90508170)
    > [homebrew更改国内源](https://zhuanlan.zhihu.com/p/157067214)

2. **直接下载安装**
通过 GitHub 上的 `dmg` 安装，链接: <https://github.com/fxcoudert/gfortran-for-macOS/releases>
![Screen Shot 2021-07-21 at 3.47.43 PM](/assets/Screen%20Shot%202021-07-21%20at%203.47.43%20PM.png)
下载对应版本的 `dmg` 安装即可。
安装好后，可以通过在终端输入

```
$ gfortran --version
```

### GFortran

来测试是否安装成功,
![Screen Shot 2021-07-21 at 3.56.02 PM](/assets/Screen%20Shot%202021-07-21%20at%203.56.02%20PM.png)
如果出现如图所示提示，则说明成功安装。

## <span id="2"> 编辑器选择和配置 </span>

### Atom

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

另外，再搜索并安装 `atom-ide-base`

<img src=/assets/Screen%20Shot%202021-07-21%20at%204.15.12%20PM.png width=60%>

安装完成后重启 `Atom`。

#### 项目创建
1. 打开 `Atom` 。

2. 选择 `Add folders` 随意打开一个项目文件夹。

3. 打开后创建一个`fortran`源文件。

![Screen Shot 2021-07-21 at 4.31.09 PM](/assets/Screen%20Shot%202021-07-21%20at%204.31.09%20PM.png)

4.输入如下代码
```fortran
program main
    implicit none
    print * "Hello World!"
end program main
```
5.右击项目目录，选择 `Make Active Fortran Project`
    <img src=/assets/Screen%20Shot%202021-07-21%20at%204.34.27%20PM.png width=60%>

6. 下方会弹出控制栏
 ![Screen Shot 2021-07-21 at 4.35.27 PM](/assets/Screen%20Shot%202021-07-21%20at%204.35.27%20PM.png)
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
