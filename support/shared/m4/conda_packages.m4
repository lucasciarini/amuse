# AX_CONDA_LIST()
#
# Runs conda list and saves the result in ax_conda_list.
# The conda list command is rather slow, so we can avoid an annoying wait by running
# it once and saving the output for use with AX_CONDA_PACKAGE below.
#
# Note that we can't save newlines in a shell variable, so we're replacing them with
# circumflexes instead. We change them back below before grepping.
AC_DEFUN([AX_CONDA_LIST],[
    ax_conda_list="$(conda list | tr '\n' '^')"
])


# AX_CONDA_PACKAGE(VARIABLE, NAME)
#
# Checks that the given package is installed in the active conda environment.
#
# You must run AX_CONDA_LIST() before calling this macro.
#
# Sets $VARIABLE to "yes" if the package was found
AC_DEFUN([AX_CONDA_PACKAGE],[
    AC_MSG_CHECKING([for conda package $2])
    ax_conda_package_line="$(echo $ax_conda_list | tr '^' '\n' | grep '^$2 ')"
    AS_IF([test "$?" = "0"], [
        # $1="$(AS_ECHO("$ax_conda_package_line") | tr -s ' ' | cut -f 2 -d ' ')"
        $1="yes"
        AC_MSG_RESULT([yes])
    ], [
        AC_MSG_RESULT([no])
    ])
])
