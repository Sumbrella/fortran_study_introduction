# 文件
计算机系统中, 一切都是文件, 在我们进行输入输出时, 如果直接在全部用手输入到屏幕上或者是将数据全部输出到屏幕上都不是很好的办法。
当数据量变大时, 从键盘输入的方式显得低效, `fortran`可以对操作系统中的文件进行各种操作。

## 9.1 文件操作
### 9.1.1 OPEN
`fortran` 提供了`open`函数将文件读取进内存中, 函数原型如下:
```fortran
open(unit, file[, form, status, access,
    recl, err, iostat, blank, position,
    action, pad, delim])
```
其中 `unit` 和 `file` 为必填字段。
- unit: 给定文件打开后的端口号
- file: 文件的路径
比如下面的语句将打开一个文件，并给定`10`作为其端口号。

```fortran
open(unit=10, file="in.txt")
```
文件打开后, 可以**将`write/read`语句中的端口号改为文件的端口号**来对文件进行操作。
如:
```fortran
program write_file_demo
    implicit none
    open(unit=10, "demo.txt")
    write(10, *) "Hello"
    !    ^^^
    !   文件端口
end program
```
各个参数简单介绍:
- `form` 参数
    只有两个可选选项 `formatted` 或 `unformatted`。
    默认为`formatted`.
    - `formatted`:按照文本文件格式来进行输入输出。
    - `unformatted`:将按照二进制格式进行输入输出。
- `status` 参数
    指定文件打开时的状态。
    有五个可选选项`new`, `old`, `replace`, `scratch`, `unknown`
    默认值为`unknown`。
    - `new`: 文件原先不存在,如果打开时文件已存在，则会报错。
    - `old`: 文件已经存在, 如果打开时文件不存在，则会报错。
    - `replace`: 如果文件已经存在则会覆盖老文件, 如果不存在则新建。
    - `scratch`: 文件会被自动命名, 系统将会打开一个暂存盘, 程序运行结束后文件消失。
    - `unknown`: 不同编译器不同, 一般为`replace`
- `access` 参数
    指定文件的读取状态
    两个可选参数 `sequential`, `direct`
    默认为 `sequential`
    - `sequential`: 按照文件顺序逐一读取文件
    - `direct`: 直接读取文件
- `recl` 参数
    顺序模式时，指定一次读取文件内容的最大值。
    直接模式时，指定文件中每一个模块单元的长度。
- `err` 参数
    当读取文件出现错误时，程序会跳转到err所在的代码继续执行。
- `iostat` 参数
    表明文件打开的状态，接收一个整形参数。
    - 参数 > 0, 文件操作发生错误
    - 参数 = 0, 文件操作成功
    - 参数 < 0, 文件终止
- `blank` 参数
    输入数字时, 当所设置的文件字段中有空格所在时代表的意义。
    有两个可选字段 `NONE` 和 `ZERO`。
    `NONE`: 无意义
    `ZERO`: 空格表示0
- `position` 参数
    文件打开时所在的位置。
    有三个可选字段 `axis`, `rewind`, `append`。
    默认为 `axis`
    - `axis` 文件打开时的位置, 一般为开头。
    - `rewind` 移动到文件的开头。
    - `append` 移动到文件的结尾。

- `action` 参数
    文件打开后的权限。
    有三个可选字段`read`, `write`, `readwrite`。
    默认为`readwrite`
    - `read` 打开后文件只可读。
    - `write` 打开后文件只可写。
    - `readwrite` 打开后文件可读写。
- `pad` 参数
    格式化输入时不足是否填入空格。
    有两个可选字段`yes`, `no`。
    默认为`no`
    - `yes` 格式化输入时, 不足的位会填入空格。
    - `no`  格式化输入时, 不足的为不会填入空格。
    
