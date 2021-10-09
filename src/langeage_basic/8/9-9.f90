!> program 9-9
program main
    implicit none

    interface
        elemental function multiply_by_two(num) result(res)
            implicit none
            integer, intent(in) :: num
            integer             :: res
        end function
    end interface

    integer :: i
    integer :: a(10) = [(i, i = 1, 10)]

    write(*, "(10I3)") a
    write(*, *) "After operation"
    write(*, "(10I3)") multiply_by_two(a)

end program

elemental function multiply_by_two(num) result(res)
    implicit none
    integer, intent(in) :: num
    integer             :: res
    res = num * 2
end function
