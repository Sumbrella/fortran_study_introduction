!> program 6-3
program dowhile_demo
    implicit none
    integer :: i
    i = 1
    do while(i < 11)
        print *, i
        i = i + 1
    end do
end program
