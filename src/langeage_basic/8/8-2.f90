!> program 8-2
program demo_allocate
    implicit none
    !> The maximum size of one student's name
    integer, parameter :: name_max_size = 20

    !> Normal variales
    integer :: student_number, err, i
    character(len=20), allocatable :: student_names(:)

    write(*, "('Please enter the number of students', /, '>>> ', $)")
    read (*, *) student_number

    !> Allocate `student_names` array
    allocate(student_names(student_number), stat=err)
    if (err /= 0) print *, "student_names: Allocation request denied."

    !> Read all student names
    do i = 1, student_number
        write(*, "('Enter the ', I0,'th student''s name', /, '>>> ', $)") i
        read(*, *) student_names(i)
    end do

    !> Output all names
    write(*, *) "Each name of your student:"
    do i = 1, student_number
        write(*, "(I0,' th student''s name is: ', A)") i, student_names(i)
    end do

    !> Dellocate `student_names` array
    if (allocated(student_names)) deallocate(student_names, stat=err)
    if (err /= 0) print *, "student_names: Deallocation request denied."

end program
