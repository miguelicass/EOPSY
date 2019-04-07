name=`basename $0`

# function for printing error messages to diagnostic output
error_msg()
{
        echo "$name: error: $1, please write it down without argument" 1>&2
}


# if no arguments given
if test -z "$1"
then
cat<<EOT 1>&2

usage:
  $name   [-r] [-l|-u] <dir/file names...>
  $name   [-r] <sed pattern> <dir/file names...>
  $name   [-h]

$name correct syntax examples:
  $name -r -l|-u dir
  $name -r -l|-u file.sh
  $name -l|-u dir
  $name -r  modify 's/AA/BB/' file.sh
  $name -r  modify 'y/AB/ab/' file.sh
  $name -h

$name incorrect syntax example:
  $name -d
  $name asdf

EOT
fi



# do with command line arguments
f=n
s=n
while test "x$1" != "x"
do
        case "$1" in

                *) error_msg "bad option $1"; exit 1 ;;


        esac
        shift
done
