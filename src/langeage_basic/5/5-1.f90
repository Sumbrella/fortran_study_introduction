!> program: 5-1
program one_if_demo
    implicit none
    integer :: score
    write(*, *) "输入成绩>>>"
    read(*, *) score

    if (score >= 60) then
        write(*, *) "及格"
    end if

end program
