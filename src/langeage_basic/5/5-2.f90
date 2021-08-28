!> program: 5-2
program if_else_demo
    implicit none
    integer :: score
    write(*, *) "输入成绩>>>"
    read(*, *) score

    if (score >= 60) then
        write(*, *) "及格"
    else
        write(*, *) "不及"
    end if

end program
