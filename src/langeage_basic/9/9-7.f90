!> program 9-7
program main
    implicit none
    external :: sub1, sub2  !! use external to give definition of an subroutine.
    call call_subroutine(sub1)
    call call_subroutine(sub2)
end program

!! just use the subroutine.
subroutine call_subroutine(sub)
    implicit none
    external :: sub  !! use external give definition.
    call sub()
end subroutine

subroutine sub1()
    implicit none
    write(*, *) "Sub1: Be used!"
end subroutine

subroutine sub2()
    implicit none
    write(*, *) "Sub2: Be used!"
end subroutine
