program integer_test

    implicit none

    integer(kind=2)  :: shortint
    integer(kind=4)  :: longint
    integer(kind=8)  :: verylongint
    integer(kind=16) :: veryverylongint

    integer :: defval

    write(*, *) "short: ", shortval
    write(*, *) "long: ", longint
    write(*, *) "verylong: ", verylongint
    write(*, *) "veryverylongval: ", veryverylongint
    write(*, *) "defval", defval

end program integer_test
