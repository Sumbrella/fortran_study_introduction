!> program 9-6
!! print an array for the first n elements.
subroutine print_array(array, n)
    implicit none
    integer, intent(in) :: array(*)  ! declaction of array
    integer, intent(in) :: n         ! the number to be printed
    integer             :: i         ! control variable of loop
    do i = 1, n
        write(*, "(I0, ' ', $)") array(i)
    end do
end subroutine

program main
    integer, parameter :: n = 10
    integer            :: i
    integer            :: array(n)

    array(1: 2) = [0, 1]
    do i = 3, n
        array(i) = array(i - 1) + array(i - 2)
    end do

    call print_array(array, n)
end program
