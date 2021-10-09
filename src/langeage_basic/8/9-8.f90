!> program 9-8
program main
    implicit none
    integer, external :: fact
    integer :: n = 5

    write(*, *) fact(n)

end program


recursive integer function fact(n) result(ans)
    !! get the result of n!
    !! Arguments:
    implicit none
    integer, intent(in) :: n

    if (n < 0) then
        write(*, *) 'ERROR: function fact argument `n` should be an positive integer.'
        ans = -1
        return
    else if (n == 0) then
        ans = 1
    else
        ans = fact(n - 1) * n
    end if

end function
