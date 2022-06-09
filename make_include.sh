set -eu

ignores=$(find gitignore -name '*.gitignore')
table="ignore_table.h"
data="ignore_files.h"

rm -f $table $data

cat <<EOF > $table
struct {
    char *name;
    unsigned char *data;
    unsigned int size;
} ignore_table[] = {
EOF

# count
count=0
for ignore in $ignores
do
  path=$ignore
  basename=$(basename $path)
  name=$(echo $basename | sed 's/\.gitignore//')
  name_lower=$(echo $name | tr '[:upper:]' '[:lower:]')
  array_name=$(echo $path | sed 's/[_/+.-]/_/g')
  new_array_name="ignore_file_$count"

  echo "    { \"$name_lower\", (unsigned char *)${new_array_name}, ${new_array_name}_len }," >> $table
  xxd -i $path | sed "s/$array_name/$new_array_name/g" | sed 's/unsigned int/const unsigned int/' >> $data

  echo "$name_lower - $array_name - $new_array_name"
  count=$((count+1))
done

cat <<EOF >> $table
};
static unsigned int ignore_table_size = sizeof(ignore_table) / sizeof(ignore_table[0]);
EOF