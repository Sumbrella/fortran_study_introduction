!> program 6-5
program exit_demo
    implicit none
    integer :: i

    do i = 1, 100
      if (i > 10) then
        exit  ! Stop printing numbers
      end if
      print *, i
    end do
    ! Here i = 11
end program exit_test
