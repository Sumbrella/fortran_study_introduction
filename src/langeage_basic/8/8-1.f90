!> program 8-1
program read_write_array
    implicit none
    integer, parameter :: n = 5
    integer :: i
    integer :: array(n)
    write(*, "('Enter', I4, ' line, each line with an integer')") n
    do i = 1, n
        read(*, *) array(i)
    end do

    do i = 1, n
        write(*, *) array(i)
    end do

end program
