cur_dir=`dirname $0`
cd ${cur_dir}
cur_dir=`pwd`

for filename in `ls -A ./ | grep -e "^\..*\|getwifi.sh" | grep -v ".DS_Store" | grep -v ".git"`
do
  rm -rf ~/${filename}
  ln -s ${cur_dir}/${filename} ~/
done
