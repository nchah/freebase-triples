#! /bin/bash

OUTFILE="fb-rdf-pred-"

# Excluded: common, kg, type

declare -a q=(
	"</american_football.*"
	"</amusement_parks.*"
	"</architecture.*"
	"</astronomy.*"
	"</automotive.*"
	"</aviation.*"
	"</award.*"
	"</base.*"
	"</baseball.*"
	"</basketball.*"
	"</bicycles.*"
	"</biology.*"
	"</boats.*"
	"</book.*"
	"</boxing.*"
	"</broadcast.*"
	"</business.*"
	"</celebrities.*"
	"</chemistry.*"
	"</chess.*"
	"</comedy.*"
	"</comic_books.*"
	"</comic_strips.*"
	"</community.*"
	"</computer.*"
	"</conferences.*"
	"</cricket.*"
	"</cvg.*"
	"</dataworld.*"
	"</digicams.*"
	"</dining.*"
	"</distilled_spirits.*"
	"</education.*"
	"</engineering.*"
	"</event.*"
	"</exhibitions.*"
	"</fashion.*"
	"</fictional_universe.*"
	"</film.*"
	"</finance.*"
	"</food.*"
	"</freebase.*"
	"</games.*"
	"</geography.*"
	"</geology.*"
	"</government.*"
	"</ice_hockey.*"
	"</imdb.*"
	"</influence.*"
	"</interests.*"
	"</internet.*"
	"</kp_lw.*"
	"</language.*"
	"</law.*"
	"</library.*"
	"</location.*"
	"</martial_arts.*"
	"</measurement_unit.*"
	"</media_common.*"
	"</medicine.*"
	"</meteorology.*"
	"</metropolitan_transit.*"
	"</military.*"
	"</music.*"
	"</nytimes.*"
	"</olympics.*"
	"</opera.*"
	"</organization.*"
	"</people.*"
	"</periodicals.*"
	"</physics.*"
	"</pipeline.*"
	"</projects.*"
	"</protected_sites.*"
	"</radio.*"
	"</rail.*"
	"</religion.*"
	"</royalty.*"
	"</skiing.*"
	"</soccer.*"
	"</spaceflight.*"
	"</sports.*"
	"</symbols.*"
	"</tennis.*"
	"</theater.*"
	"</time.*"
	"</topic_server.*"
	"</transportation.*"
	"</travel.*"
	"</tv.*"
	"</user.*"
	"</venture_capital.*"
	"</visual_art.*"
	"</wine.*"
	"</zoo.*")


### v2 Implementation

awk -F"\t" -v arr="$(echo ${q[@]})" 'BEGIN{split(arr,a," ");} 
{ for (k in a) if($2 ~ a[k]) fname=("fb-rdf-pred-"substr(a[k], 3, length(a[k]) - 4)); 
print $0 >>fname; close(fname); if(FNR % 10000 == 0) { printf ("Processed %d lines \n", FNR)} } ' \
fb-rdf-s01-c01-test2

# gawk version to call sfrtime:
gawk -F"\t" -v arr="$(echo ${q[@]})" 'BEGIN{split(arr,a," ");} 
{ for (k in a) if($2 ~ a[k]) fname=("fb-rdf-pred-"substr(a[k], 3, length(a[k]) - 4)); 
print $0 >>fname; 
close(fname); 
if(FNR % 10000 == 0) { 
printf ("Processed %d lines - - ", FNR); 
printf strftime("t = %Y-%m-%d %H:%M:%S \n"); } 
} ' \
fb-rdf-s01-c01-test2


# todo: parallel version
# cat fb-rdf-s01-c01 | parallel --pipe --block 2M --progress \
# awk -F"\t" -v arr="$(echo ${q[@]})" \''BEGIN{split(arr,a," ");} { for (k in a) if($2 ~ a[k]) print     $0 >>("fb-rdf-pred-" substr(a[k], 3, length(a[k]) - 4 )) } '\'



### v1 Implementation

# for i in "${q[@]}" 
# do {
#	cat fb-rdf-s01-c01 | parallel --pipe --block 2M --progress \
#	awk -F"\t" \'' $2 ~ "'"$i"'" '\' >>$OUTFILE${i:2:${#i}-4}
#	echo -e "\n\n * * * DONE: " "'"$i"'" '\n\n';
#	sleep 3
#}
# done
