# 结构体
很多时候, `fortran`提供的数据类型不足以满足实际生产的需要, 比如如果要定义一本书的记录, 可能需要用书名、作者、书号等来描述, 这样就需要存储3个变量,不符合直观的生活规律。
为了方便, `fortran`提供了结构图(派生数据类型)来让用户自定义自己需要的数据类型。
## 10.1 结构体定义
定义派生类型需要遵循如下语法:
```fortran
type type_name
    type_1 :: member1
    type_2 :: member2
    ...
end type
```
比如定义一本书:
```fortran
type Book
    character(len=50) :: title
    character(len=50) :: author
    character(len=50) :: id
end type
```

## 10.2 结构体声明
声明一个结构体变量时的语法如下:
```fortran
type(type_name) :: var_name
```
如:
```fortran
type(Book) :: mybook
```

## 10.2 结构体成员访问
定义一个结构体如`book`后, 其包含的字段如`title`, `author`, `id`被称为该结构体的成员, `fortran`通过`%`符来访问一个结构体的成员。
如:
```fortran
mybook%title = "Fortran Study Introduction"
mybook%author = "Sumbrella"
mybook%id = "2039205"
```

其他的操作如`write, read`等, 与普通的变量相同。
