!> program 6-2
program do_step_demo
    implicit none
    integer :: i
    do i = 1, 10, 2
        write(*, *) i
    end do
end program
