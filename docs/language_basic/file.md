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
    有三个可选字段 `asis`, `rewind`, `append`。
    默认为 `asis`
    - `asis` 文件打开时的位置, 一般为开头。
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
- `delim` 参数
    格式化输出字符串时是否加引号。
    三个可选字段`none`, `quote`, `apostrophe`
    - none 直接输出
    - quote 增加单引号
    - apostrophe 增加双引号

### 9.1.2 inquire
该函数用于查询文件的状态。
比如使用`inquire`查询文件是否存在。
```fortran
!> program 9-1
program inquire_demo
    implicit none
    character(len=*), parameter :: filename = "in"
    logical :: exists

    inquire(file=filename, exist=exists)

    if (exists) then
        write(*, *) "file:  ", filename, " exist."
    else
        write(*, *) "file:", filename, " don't exist."
    end if
end program
```

当然, `inquire`还有其他功能, 其所有的参数如下:
- `unit`
需要查询的文件通道
- `file`
需要查询的文件名
- `iostat`
文件输入输出情况
    - stat > 0 操作错误
    - stat = 0 操作成功
    - stat < 0 文件终了
- `err`
发生错误后会转到指定的代码运行
- `exist`
文件是否存在
- `opened`
是否已经被打开
- `number`
查询文件所在代码
- `named`
文件是否有名字。(判断文件是否为暂存文件)
- `access`
查询文件读取格式。
返回为`sequential`, `direct`, `undefiend`中的一个。
- `sequential`
查询文件是否为顺序格式
返回为`YES`, `NO`, `UNKNOWN`中的一个
- `direct`
查询文件是否使用直接格式。
返回值为`YES`, `NO`, `UNKNOWN`.
- `form`
查看文件的保存方法。
`FORMATTED`, `UNFORMATTED`, `UNDEFINED`中的一个。

- `formatted`
查询文件是否为文本读取方式。
返回值为`YES`, `NO`, `UNKNOWN`.
- `unformatted`
查询文件是能否为二进制文件
返回值为`YES`, `NO`, `UNKNOWN`。
- `recl`
返回文件`open`时设置的`recl`值。
- `nextrec`
返回下一次文件读写位置
- blank
文件 `open`时 `blank`参数所给定的字符
- position
返回打开文件时`position`所给定的字符串。
可以是`APPEND`, `ASIS`, `UNDEFINED`
- action
查询文件打开时`action`所赋值的字符串。
- read
查询文件是否可读
返回值为`YES`, `NO`, `UNKNOWN`。
- write
查询文件是否可写
返回值为`YES`, `NO`, `UNKNOWN`。
- readwrite
查询文件是否可读写。
返回值为`YES`, `NO`, `UNKNOWN`
- delim
打开文件时, `delim`字段设置的字符。
- pad
打开文件时, `pad`设置的字符。

### 9.1.3 其他指令
1. **BACKSPACE**
`backspace(unit, err, iostat)`
把文件的读写位置退回一步。
2. **REWIND**
`rewind(unit, err, iostat)`
退回到文件开头。
3. **CLOSE**
`close(unit, status, err, iostat)`
关闭文件.
其中`status`字段可以是:
    - `keep`: 关闭文件后保存。
    - `delete`: 关闭文件后删除。

## 9.2 文件操作规范
1. iostat 参数
在对文件进行操作时, 应保证必要时对该参数进行检查, 如
    ```fortran
    open(unit=iounit, file=filename, iostat=ios)
    if ( ios /= 0 ) stop "Error opening file filename"
    ```

2. action 参数
在文件打开时, 如果文件只有读的必要, 可将`action`参数设置为`read`, 以免操作时对文件错误修改; 或是文件只有写的必要, 可将`action`参数设置为`write`。如:
    ```fortran
    open(unit=inunit, file='in', action='read', iostat=ios)
    open(unit=outunit, file='out', action='write', iostat=ios)
    ```

3. close 命令
文件打开后, 需要及时将文件关闭, 避免占用过多的内存空间。
    ```fortran
    close(unit=iounit, iostat=ios)
    if ( ios /= 0 ) stop "Error closing file unit ", iounit
    ```

## 9.3 文件操作示例
### 9.3.1 顺序文件操作
下面的程序将为文件自动标注行号:
```fortran {class="line-numbers"}
!> program 9-2: auto mark line numbers for a file.
program mark_line_numbers
    implicit none
    integer, parameter :: max_string_length = 203

    integer, parameter :: in_unit = 99
    integer, parameter :: out_unit = 100

    character(max_string_length) :: in_file
    character(max_string_length) :: out_file

    character(max_string_length) :: buffer

    integer :: stat
    integer :: counter

    write(*, *) "Please enter input filepath >>>"
    read(*, *) in_file

    write(*, *) "Please enter output filepath >>>"
    read(*, *) out_file

    call check_file_exists(in_file)

    !> Use status=old, action=read to open input file.
    open(unit=in_unit, file=in_file, status="old", action="read")
    !> User status=replace, action=write to open output file.
    open(unit=out_unit, file=out_file, status="replace", action="write")

    counter = 0
    do while (.true.)
        read (in_unit,  "(A203)", iostat=stat) buffer
        if (stat /= 0) exit  !> the file is over
        !> write into output file
        write(out_unit, "(I3, '.', A)") counter, trim(buffer)
        counter = counter + 1
    end do

    close(in_unit)
    close(out_unit)

end program


subroutine check_file_exists(filename)
    !! check a file exists or not.
    !! if the file don't exist, program will quit.
    implicit none
    character(*), intent(in) :: filename
    logical :: exists

    inquire(file=filename, exist=exists)
    if (.not. exists) then
        write(*, *) "file :", filename, " don't exist."
        stop
    end if
end subroutine
```

### 9.3.2 直接文件操作
> 待补
### 9.3.3 二进制文件操作
> 待补

## 9.4 内部文件
`fortran`除了可以将内容格式化写入文件外, 还可以将其写入字符串中。
```fortran{class="line-numbers"}
program internal_demo
    implicit none
    integer :: a = 2
    integer :: b = 3
    character(len=20) :: string
    write(unit=string, fmt="(I2, '+', I2, '=', I2)") a, b, a + b
    write(*, *) string
end program
```
输出:
```
 2+ 3= 5
```
当然, 字符串也可以使用`read`语句来进行读取, 在这里不再赘述。

## 9.5 NAMELIST
命名空间(`namelist`)将一组变量封装在一起，可以快速的进行输入输出。
如:
```fortran {class="line-numbers"}
program namelist_demo
    implicit none
    integer :: a = 1, b = 2, c = 3
    namelist /na/ a, b, c
    write(*, nml=na)
end program
```
输出如下:
```
&NA
 A=1          ,
 B=2          ,
 C=3          ,
 /
 ```
`namelist`的语法为:

```
namelist /nl_name/ var1, var2,...
```

之后在`read`或是`write`中将`nml`参数更改为命名的`namelist`名字就可以进行输入输出操作了。
```fortran
write[read](*, nml=na)
```
但是`namelist`的输入输出有固定格式, 输入时要以`&na` 开始, 赋值变量, `/`结束， 如:
```
&na a=1 a=2 /
```
