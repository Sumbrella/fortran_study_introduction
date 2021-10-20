!> program 9-10
program common_demo
    implicit none
    integer :: a, b
    common a, b
    call print_number()
    a = 1
    b = 2
    call print_number()

end program


subroutine print_number()
    implicit none
    integer :: n1, n2
    common n1, n2
    write(*, *) n1, n2
end subroutine
