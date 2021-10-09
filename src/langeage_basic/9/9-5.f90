!> program 9-5
program main
    integer :: a = 4
    write(*, *) "Program Main: before subroutine, the value of a is ", a
    call division_by_two(a)
    write(*, *) "Program Main: after subroutine, the value of a is ", a
end program

subroutine division_by_two(number)
    integer :: number
    number = number / 2
end subroutine
