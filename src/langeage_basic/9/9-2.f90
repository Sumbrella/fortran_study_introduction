!> program 9-2: auto mark line numbers for a file.
program mark_line_numbers
    implicit none
    integer, parameter :: max_string_length = 203

    integer, parameter :: in_unit = 99
    integer, parameter :: out_unit = 100

    character(max_string_length) :: in_file
    character(max_string_length) :: out_file

    character(max_string_length) :: buffer

    integer :: stat
    integer :: counter

    write(*, *) "Please enter input filepath >>>"
    read(*, *) in_file

    write(*, *) "Please enter output filepath >>>"
    read(*, *) out_file

    call check_file_exists(in_file)

    !> Use status=old, action=read to open input file.
    open(unit=in_unit, file=in_file, status="old", action="read")
    !> User status=replace, action=write to open output file.
    open(unit=out_unit, file=out_file, status="replace", action="write")

    counter = 0
    do while (.true.)
        read (in_unit,  "(A203)", iostat=stat) buffer
        if (stat /= 0) exit  !> the file is over
        !> write into output file
        write(out_unit, "(I3, '.', A)") counter, trim(buffer)
        counter = counter + 1
    end do

    close(in_unit)
    close(out_unit)

end program


subroutine check_file_exists(filename)
    !! check a file exists or not.
    !! if the file don't exist, program will quit.
    implicit none
    character(*), intent(in) :: filename
    logical :: exists

    inquire(file=filename, exist=exists)
    if (.not. exists) then
        write(*, *) "file :", filename, " don't exist."
        stop
    end if
end subroutine
