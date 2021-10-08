!>program 9-3!
program swap_demo
    implicit none
    integer :: a, b

    a = 3
    b = 2

    write(*, *) "a = ", a, "b = ", b
    call swap(a, b)
    write(*, *) "a = ", a, "b = ", b

end program swap_demo


subroutine swap(a, b)
    implicit none
    integer :: a, b
    integer :: t
    t = a
    a = b
    b = t
end subroutine swap
