#!/bin/sh
# This is meant ot be included (sourced) by filter tests with:
# . _common.sh

set -e

this_scripts_dir_rel=`dirname $0`
this_scripts_dir=`cd "$this_scripts_dir_rel"; pwd`
root_dir=`cd "$this_scripts_dir"; cd ../../..; pwd`
filters_dir="$root_dir/src/main/filters"
build_dir="$root_dir/build"
tmp_dir="$build_dir/tmp"
our_name=`basename -s '.sh' $0`

in_file="$tmp_dir/${our_name}_input.md"
out_file="$tmp_dir/${our_name}_expected_output.md"
exp_out_file="$tmp_dir/${our_name}_actual_output.md"
diff_file="$tmp_dir/${our_name}_actual_diff.txt"

mkdir -p "$build_dir"
mkdir -p "$tmp_dir"

run_filter() {
	params="$@"

	cd "$build_dir"
	cat "$in_file" \
		| pandoc \
			$params \
			-f markdown -t markdown --atx-headers \
			--filter "$filters_dir/${our_name}.py" \
		> "$out_file"
}

eval_result() {
	diff "$out_file" "$exp_out_file" > "$diff_file" \
		|| ( echo "Filter changes were different then expected!"; exit 1 ) \
		&& echo "Success."
}

