program view_of_fortran
    use ios_fortran_env, only: int32, real32
    implicit none
    integer(int32) :: high
    real(real32)   :: weight, bmi

    write(*, *) "Please enter your high(cm) >>>"
    read(*, *) heigh

    write(*, *) "Please enter your weight(kg) >>>"
    read(*, *) weight

    bmi   = weight / (height / 100 * height / 100)
    write(*, *) "Your bmi is:", bmi

end program
