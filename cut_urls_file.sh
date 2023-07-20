#!/bin/bash

input_file="urls/urls_2022-12.txt"
output_file="urls/urls_2022-12_1.txt"
lines_to_cut=500000

# Count the total number of lines in the input file
total_lines=$(wc -l < "$input_file")

# Calculate the starting line number to cut
start_line=$((total_lines - lines_to_cut + 1))

# Use sed to extract the desired lines from the input file and write them to the output file
sed -n "$start_line,\$p" "$input_file" > "$output_file"

echo "Output file created: $output_file"
