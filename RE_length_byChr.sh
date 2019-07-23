#!/bin/bash

# This script calculates the total length (in nt) of each repetitive element(RE)
# The input file is the repeat master viz downladed from http://genome.ucsc.edu/cgi-bin/hgTables



database=/PATH/RepeatMasker/RepeatMaskerViz.sorted.bed 
outputF=/OUTPATH

chrNN="chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chrX chrY"
RepElem=`cat $database | awk -F"\t|#" -v OFS='\t' '{print $5}'| sort | uniq` # save the list of all posible Repetitive elements (RE)

# Manual list
#RepElem="Simple_repeat LINE/L1 SINE/Alu LTR/ERVL-MaLR SINE/B4 SINE/B2 LTR/ERVK Low_complexity SINE/MIR LTR/ERVL DNA/hAT-Charlie LINE/L2 LTR/ERV1 SINE/ID Satellite DNA/TcMar-Tigger Other LINE/CR1 DNA/hAT-Tip100 Unknown scRNA tRNA DNA/hAT-Blackjack DNA/hAT-Ac LINE/RTE-BovB LTR/ERVK? snRNA Unknown/Y-chromosome LTR/Gypsy DNA DNA/hAT DNA? DNA/TcMar-Tc2 LINE/RTE-X rRNA LTR LTR? SINE/5S-Deu-L2 SINE/tRNA DNA/TcMar-Mariner LINE/Penelope DNA/hAT? SINE/tRNA-RTE LTR/Gypsy? LTR/ERVL? DNA/hAT-Tag1 RNA srpRNA SINE/tRNA-Deu DNA/TcMar RC/Helitron DNA/hAT-Tip100? LINE/Jockey DNA/PiggyBac DNA/PIF-Harbinger LTR/ERV1? LINE/Dong-R4 DNA/TcMar-Tc1 DNA/Kolobok DNA/TcMar? DNA?/hAT-Tip100? DNA?/PiggyBac? RC?/Helitron? SINE?/tRNA LINE/L1-Tx1 DNA/TcMar-Pogo Satellite/centr"

# RE length for each element and chr

for RE in $RepElem; do
echo $RE
for chr in $chrNN; do
	echo $chr `cat $database | awk -F"\t|#" -v OFS='\t' '{print $1,$3-$2,$5}' | grep -w $RE$ | grep -w $chr| awk '{ SUM += $2; print SUM}'| tail -1`
 done

done > $outputF/RMV_TE_analysis.txt

#Briefly: Read DB.bed. Extract Chr, end-start position (RE length) and RE class for each RE feature. Calculates the total length of each RE for each chromosome

