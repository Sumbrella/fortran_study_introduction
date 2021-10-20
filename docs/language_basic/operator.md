#数据运算
## 1. 运算符
`fortran`中最基本的五种运算符为
1. `+`  加
2. `-`  减
3. `*`  乘
4. `/`  除
5. `**` 乘方
6. `mod(a, b)` a对b取余

优先级: 乘法 > 乘除 > 加减,
同一级别从左到右依次运算。

## 2. 运算关系符

| 记号表达式   |  字母表达式  | 含义|
| :----: | :------: | :--: |
| `< ` |  .lt. | 小于
| `<=` |  .le. | 小于等于
| `==` |  .eq. | 等于
| `/=` |  .ne. | 不等于
| `>`  |  .gt. | 大于
| `>=` |  .ge. | 大于等于

在使用时，可以使用记号表达式也可以使用字母表达式，但是不推荐使用字母表达式。
使用字母表达式时, `.`不能省略。
1. 如果运算关系符左右两侧为算数表达式，则先进行算数运算。如`5 + 1 > 2`, 会先运算`5 + 1`, 再与`2`比较大小。
2. 表达式结果为 `Logical` 类型
3. 赋值表达式`=` 与 相等`==`不同。


## 3. 逻辑表达式
|字母表达式| 含义 |
|:------:| :--:|
|.AND.| 和
|.OR.|  或
|.NOT.| 非
|.EQV.| 逻辑等
|.NEQV.| 逻辑不等

> 注意 `.`不能省略

## 4. 运算优先级
![Screen Shot 2021-08-27 at 6.12.01 PM](/assets/Screen%20Shot%202021-08-27%20at%206.12.01%20PM.png)

## 5. 位运算 (`Fortran95` 增加)
使用位运算有如下的优点
1. 直接接触数据底层, 运算速度最高 (基本不需要时间)
    例如计算 $2^{63}$, 可以直接让 $1$ 左移63位, 而不是计算63次乘法。
2. 可以进行状态压缩, 以实现特殊算法

- `IALL`:	  	`Bitwise AND of array elements`
- `IAND`:	  	`Bitwise logical and`
- `IANY`:	  	`Bitwise OR of array elements`
- `IEOR`:	  	`Bitwise logical exclusive or`
- `IOR`:	  	`Bitwise logical or`
- `IPARITY`:	  	`Bitwise XOR of array elements`
- `LSHIFT`:	  	`Left shift bits`
- `RSHIFT`:	  	`Right shift bits`
