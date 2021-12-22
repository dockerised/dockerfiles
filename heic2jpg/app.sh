# /bin/bash

if [ -z "$(ls -A -- /imgs)" ]
then
  echo "ERROR: no imgs directory, add [-v <path to directory of .heif(s)>:/imgs] to your docker run command"
  exit 1
fi

heics=$(find /imgs -type f -regex ".*\.\(HEIC\|heic\)" -exec ls {} \;)
if [ ! $(echo $heics | wc -c) -gt 1 ] 
then
  echo "No .HEIC files found in /imgs"
fi
for f in $heics
do
  ls $f
  filenamenew="${f%????}jpg"
  tifig -v -p $f ${f%????}jpg
  if [[ "${DELETE_MODE}" = "true" ]] 
  then 
    if [[ -f $filenamenew ]] 
    then
      rm -f $f
      echo "Deleted $f"
    else
      echo "$filenamenew not found, delete failed"
    fi
  fi
done