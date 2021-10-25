!> program 9-1
program inquire_demo
    implicit none
    character(len=*), parameter :: filename = "in"
    logical :: exists

    inquire(file=filename, exist=exists)

    if (exists) then
        write(*, *) "file:  ", filename, " exist."
    else
        write(*, *) "file:", filename, " don't exist."
    end if
end program
