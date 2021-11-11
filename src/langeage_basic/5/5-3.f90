!> program: 5-3
program if_demo
    implicit none
    integer :: score
    write(*, *) "输入成绩>>>"
    read(*, *) score
    if (score > 100 .or. score < 0) then
        write(*, *) "超出范围"
    else if (score >= 60) then
        write(*, *) "及格"
    else
        write(*, *) "不及"
    end if
end program
