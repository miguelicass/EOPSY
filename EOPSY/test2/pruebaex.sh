
# command options and arguments interpreter example
# simple version

# the name of the script without a path
name=`basename $0`
aux=0
newname=""

#split the name y extension and saving
split_file ()
{
dir=`dirname $1`
in=`basename $1`
IFS='.' read -ra ADDR <<< "$in"
for i in "${ADDR[@]}"; do
    aux=1;
done
in1="${ADDR[0]}"
in2="${ADDR[1]}"
#echo "$in1"
#echo "$in2"
}
#funcion para comprobar el sed
sed=""
sed_function()
{
  sed="$1"
  IFS='/' read -ra ADDR <<< "$sed"
  for i in "${ADDR[@]}"; do
      aux=1;
  done
  sed1="${ADDR[0]}"
  sed2="${ADDR[1]}"
  sed3="${ADDR[2]}"

  if test "$sed1" = "s"
  then
    s=y;

  elif test "$sed1" = "y"
  then
    yy=y;

  else
    error_msg "bad option $1"; exit 1 ;
  fi


}



# function for printing error messages to diagnostic output
error_msg()
{

        echo "$name: error: $1" 1>&2

        echo "Please write it with argument (-h) to find help" 1>&2

}

# if no arguments given
if test -z "$1"
then
cat<<EOT 1>&2
  Please write it with argument (-h) to find help

  Example:  ./$name -h

EOT
exit 1;
fi

# if  arguments -h
if test "$1" = -h
then
cat<<EOT 1>&2

$name: help
        (-r) ==> the operation is did with recursion for all files of the directory; or without (-r) it just change the name of directory.
        (-l) ==> changes the name of the file or directory in lowercase letters
        (-u) ==> changes the name of the file or directory in uppercase letter
        (modify modify 's/old_string/new_string/') ==> changes a string selectioned for another new string
        (modify modify 'y/new_characters/old_characters/') ==>  changes the characters selectioned for another new characters, matching one by one
        (<dir/file names...>) ==> rute of the file or directory

$name: examples
        Please write next comand to see examples

        ./modify_examples.sh

EOT
exit 1;
fi

# do with command line arguments

r=n
l=n
u=n
s=n
yy=n
while test "x$1" != "x"
do
        case "$1" in
                -r) r=y;;
                -l) split_file "$2"; shift; shift; l=y;;
                -u) split_file "$2"; shift; shift; u=y;;
                 *) sed_function $1; shift; split_file "$1"; shift;;
                -*) error_msg "bad option $1"; exit 1 ;;
        esac
        shift
done



if [[ $r = "y" && -d "$dir/$in" ]]
then
      echo "with option -r"





      if test $s = "y"
      then
        echo "with option -s"
        echo "split: $sed1 / $sed2 / $sed3 "
        in1=${in1/$sed2/$sed3}
        if [[ -d "$dir/$in" ]]; then
          newname="$in1"
        else
          newname="$in1.$in2"
        fi
        mv "$dir/$in" "$dir/$newname"
        echo $newname
      fi

      if test $yy = "y"
      then
        echo "with option -y"
        echo "split: $sed1 / $sed2 / $sed3"

        for (( i = 0; i <= 10 ; i++ )); do
          for (( j = 0; j < 10; j++ )); do
            in1=${in1/${sed2:i:1}/${sed3:i:1}}
          done
        done
        if [[ -d "$dir/$in" ]]; then
          newname="$in1"
        else
          newname="$in1.$in2"
        fi
        mv "$dir/$in" "$dir/$newname"
        echo $newname
      fi


      if test $l = "y"
      then
          echo "with option -l"
          echo "split: $in1 & $in2"
          in1="${in1,,}"
          if [[ -d "$dir/$in" ]]; then
            newname="$in1"
          else
            newname="$in1.$in2"
          fi
          mv "$dir/$in" "$dir/$newname"
          echo $newname
      fi

      if test $u = "y"
      then
        echo "with option -u"
        echo "split: $in1 & $in2"
        in1="${in1^^}"
        if [[ -d "$dir/$in" ]]; then
          newname="$in1"
        else
          newname="$in1.$in2"
        fi
        mv "$dir/$in" "$dir/$newname"
        echo $newname
      fi



else

      if test $s = "y"
      then
        echo "just with option -s , s=$s"
        echo "split: $sed1 / $sed2 / $sed3 "
        in1=${in1/$sed2/$sed3}
        if [[ -d "$dir/$in" ]]; then
          newname="$in1"
        else
          newname="$in1.$in2"
        fi
        mv "$dir/$in" "$dir/$newname"
        echo $newname
      fi


      if test $yy = "y"
      then
        echo "just with option -y , y=$yy"
        echo "split: $sed1 / $sed2 / $sed3"
        for (( i = 0; i <= 10 ; i++ )); do
          for (( j = 0; j < 10; j++ )); do
            in1=${in1/${sed2:i:1}/${sed3:i:1}}
          done
        done
        if [[ -d "$dir/$in" ]]; then
          newname="$in1"
        else
          newname="$in1.$in2"
        fi
        mv "$dir/$in" "$dir/$newname"
        echo $newname
      fi


      if test $l = "y"
      then
          echo "just with option -l, $name"
          echo "split: $in1 & $in2"
          in1="${in1,,}"
          if [[ -d "$dir/$in" ]]; then
            newname="$in1"
          else
            newname="$in1.$in2"
          fi
          mv "$dir/$in" "$dir/$newname"
          echo $newname
      fi


      if test $u = "y"
      then
          echo "just with option -u , $name"
          echo "split: $in1 & $in2"
          in1="${in1^^}"
          if [[ -d "$dir/$in" ]]; then
            newname="$in1"
          else
            newname="$in1.$in2"
          fi
          mv "$dir/$in" "$dir/$newname"
          echo $newname
      fi

fi
