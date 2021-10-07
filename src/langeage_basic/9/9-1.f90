!> program 9-1
program sayHello
    implicit none
    integer :: i

    do i = 1, 5
        call say()
    end do

end program

subroutine say()
    write(*, *) "Hello World!"
end subroutine
