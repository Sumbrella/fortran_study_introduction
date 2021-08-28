!> program: 3-2
program format_test
    implicit none

    integer :: a = 123
    write(*, "(I2)") a
    write(*, "(I3)") a
    write(*, "(I4)") a
end program
