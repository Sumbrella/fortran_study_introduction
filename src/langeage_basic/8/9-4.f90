!> program 9-4
program add_demo
    implicit none
    integer :: a, b
    integer, external:: add
    write(*, *) "Input two integer splited by space>>>"
    read(*, *) a, b
    write(*, *) add(a, b)

end program add_demo

function add(a, b)
    integer :: a, b
    integer :: add    !> give the return type of this function.

    add = a + b
end function
