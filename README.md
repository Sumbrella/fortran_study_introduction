<!-- Use control + shift + M to open markdown preview-->

# Fortran STUDY Introduction

## 编写初衷
> 2021.6.15

由于学校的安排，需要学习 Fortran 语言。但是，一方面由于 Fortran 网上现有的自学资源往往比较零散，大部分都是在介绍 Fortran 的基本特性，而面向对象、重载、包管理等内容往往没有系统的介绍。另一方面，由于 Fortran 的编程范式割裂，同一书籍中往往出现两种截然不通的编程范式，很多老代码编写的程序放飞自我，而官方又没有权威范式，给学习带来了很多障碍。

为了方便学弟学妹及广大学习 Fortran 的同道中人，加深我自己对这门语言的理解和认识，我开始编写这篇 fortran study introduction 文档。我会平时一边学习一边把学到的知识一点点加到这里面。
**文档中，我会尽量按照现代编程规范，编写易阅读、易使用、易拓展的代码。笔者能力有限，欢迎各位指正**。

我不知道我能写多少内容，但是我希望某一年，当你们~~因为专业要求迫不得已学习~~这门语言时，能够在这里系统全面的该语言掌握各项内容。


## TodoList && Content
这个坑大概可能会包含如下内容:

**0. 基本配置**

- [ ] [Windows 下配置](/docs/install/windows.md)
- [ ] [Mac 下配置](/docs/install/mac.md)

**1. 基础内容**
> 除了语法基础以外, 代码风格与注释规范对于入门者来说是十分重要的内容, 可以多次阅读参考。

- [ ] [Fortran 注释规范](/docs/comment.md)
- [ ] [Fortran 语法基础](/docs/language_basic/index.md)
- [ ] [Fortran 代码风格](/docs/style.md)
- [ ] Fortran 最佳实践

**2. 进阶内容**
- [ ] [Fortran 基本算法](/docs/algorithms/index.md)
- [ ] Fortran 面向对象
- [ ] Fortran 模块管理
- [ ] Fortran 图形界面编程
- [ ] Fortran 兼容性调整
- [ ] Fortran 并行运算
- [ ] Fortran 网络通讯

**3. 其他**
- [ ] Fortran 常用库介绍及教程
- [ ] Fortran 学习资源
- [ ] Fortran 踩过的坑

## 常用库推荐
1. [Fortran stdlib](https://github.com/fortran-lang/stdlib): 官方提供的标准库。
2. [Fortran Package Manager](https://github.com/fortran-lang/fpm): 官方提供的第三方库管理模块。
2. [fypp](https://github.com/aradi/fypp): 基于python的库, 目的是批量生成fortran模版类等。
3. [fortran gtk](https://github.com/vmagnin/gtk-fortran): 图形化编程。
4. [FORD](https://github.com/Fortran-FOSS-Programmers/ford): fortran自动文档生成器, 特点是可以自动生成函数调用关系图

## 参考
<https://www.bootwiki.com/fortran/fortran-data-types.html>

Fortran95 程序设计

Fortran 权威设计指南

<https://gcc.gnu.org/onlinedocs/gfortran/PACK.html>

Chapman - 2018 - Fortran for scientists and engineers
