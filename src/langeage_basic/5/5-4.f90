!> program: 5-4
program select_demo
    implicit none
    integer :: score
    write(*, *) "输入成绩>>>"
    read(*, *) score
    select case (score)
    case (101:)
        write(*, *) "超出范围"
    case (:-1)
        write(*, *) "超出范围"
    case (60: 100)
        write(*, *) "及格"
    case (0: 59)
        write(*, *) "不及格"
    end select case
end program
