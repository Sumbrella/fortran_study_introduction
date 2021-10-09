!> program 9-2
program subroutine_demo
    implicit none
    integer :: i
    write(*, *) "Enter an integer>>>"
    read(*, *) i

    call show_integer(i)
end program

subroutine show_integer(i)
    integer :: i
    write(*, *) "The number is", i
end subroutine show_integer
