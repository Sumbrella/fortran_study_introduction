!> program: 6-6
program cycle_demo
    implicit none
    integer :: i

    do i = 1, 10
      if (mod(i, 2) == 0) then
          cycle  ! Don't print even numbers
      end if
      print *, i
    end do
end program
