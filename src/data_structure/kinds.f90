module kinds
    use iso_fortran_env, only: int8, int16, int32, int64
    use iso_fortran_env, only: real32, real64, real128
    use iso_c_binding, only: c_bool
    implicit none
    private
    public int8, int16, int32, int64, real32, real64, real128, c_bool
    integer, parameter :: lk = kind(.true.)
end module kinds
