#!/bin/bash
# A Bash script to parse and extract slices from the Freebase data dumps.
#
# Run with: $ s0-run-parse-extract-triples.sh [fb-data]


## s1-c0 Setting File Names
INPUT_FILE=$1
OUTPUT_FILE_S01_C01="fb-rdf-s01-c01"
OUTPUT_FILE_S01_C02="fb-rdf-s01-c02"

## s1-c1 Substring replacement: URLs 
FB_URI='http:\/\/rdf.freebase.com'
FB_NS_URI='http:\/\/rdf.freebase.com\/ns'
W3_URI='http:\/\/www.w3.org\/[0-9]*\/[0-9]*\/[0-9]*-*'

sed "s/$FB_NS_URI//g; s/$W3_URI//g; s/$FB_URI//g" $INPUT_FILE | pv -pterbl -s 425229008315 >$OUTPUT_FILE_S01_C01

## Optional: s1-c2 Substring replacement: <,> Signs
# gsed "s/^<//g; s/\t</\t/g; s/>\t/\t/g" $OUTPUT_FILE_S01_C01 | pv -pterbl >$OUTPUT_FILE_S01_C02


## s2-c1 Extract Triples:

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-common"; fname_rest = "fb-rdf-rest-01";
if($2 ~ "</common.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-s01-c01 

T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"


T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-type"; fname_rest = "fb-rdf-rest-02";
if($2 ~ "</type.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-01

T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-w3-type"; fname_rest = "fb-rdf-rest-03";
if($2 == "<rdf-syntax-ns#type>") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-02

T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-music"; fname_rest = "fb-rdf-rest-04";
if($2 ~ "</music.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-03

T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-key"; fname_rest = "fb-rdf-rest-05";
if($2 ~ "</key.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-04

T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-w3-label"; fname_rest = "fb-rdf-rest-06";
if($2 == "<rdf-schema#label>") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-05

T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-kg"; fname_rest = "fb-rdf-rest-07";
if($2 ~ "</kg.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-06

T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-base"; fname_rest = "fb-rdf-rest-08";
if($2 ~ "</base.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-07


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-film"; fname_rest = "fb-rdf-rest-09";
if($2 ~ "</film.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-08


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-tv"; fname_rest = "fb-rdf-rest-10";
if($2 ~ "</tv.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-09


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-location"; fname_rest = "fb-rdf-rest-11";
if($2 ~ "</location.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-10


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-people"; fname_rest = "fb-rdf-rest-12";
if($2 ~ "</people.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-11


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-measurement_unit"; fname_rest = "fb-rdf-rest-13";
if($2 ~ "</measurement_unit.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-12


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-book"; fname_rest = "fb-rdf-rest-14";
if($2 ~ "</book.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-13


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-freebase"; fname_rest = "fb-rdf-rest-15";
if($2 ~ "</freebase.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-14


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-dataworld"; fname_rest = "fb-rdf-rest-16";
if($2 ~ "</dataworld.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-15


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-media_common"; fname_rest = "fb-rdf-rest-17";
if($2 ~ "</media_common.") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-16


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-medicine"; fname_rest = "fb-rdf-rest-18";
if($2 ~ "</medicine.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-17


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-award"; fname_rest = "fb-rdf-rest-19";
if($2 ~  "</award.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-18


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-biology"; fname_rest = "fb-rdf-rest-20";
if($2 ~  "</biology.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-19


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-sports"; fname_rest = "fb-rdf-rest-21";
if($2 ~  "</sports.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-20


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-organization"; fname_rest = "fb-rdf-rest-22";
if($2 ~  "</organization.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-21


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-education"; fname_rest = "fb-rdf-rest-23";
if($2 ~ "</education.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-22


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-baseball"; fname_rest = "slices-new/fb-rdf-pred-base-only";
if($2 ~  "</baseball.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' slices-new/fb-rdf-pred-base


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-business"; fname_rest = "fb-rdf-rest-24";
if($2 ~  "</business.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-23


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-imdb"; fname_rest = "fb-rdf-rest-25";
if($2 ~  "</imdb.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-24


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-topic_server"; fname_rest = "fb-rdf-rest-26";
if($2 ~  "</topic_server*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-25


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-user"; fname_rest = "fb-rdf-rest-27";
if($2 ~  "</user.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-26


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-government"; fname_rest = "fb-rdf-rest-28";
if($2 ~  "</government.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-27


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-cvg"; fname_rest = "fb-rdf-rest-29";
if($2 ~  "</cvg.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-28


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-soccer"; fname_rest = "fb-rdf-rest-30";
if($2 ~  "</soccer.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-29


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-time"; fname_rest = "fb-rdf-rest-31";
if($2 ~  "</time.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-30


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-astronomy"; fname_rest = "fb-rdf-rest-32";
if($2 ~  "</astronomy.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-31


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-pipeline"; fname_rest = "fb-rdf-rest-33";
if($2 ~  "</pipeline.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-32


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-basketball"; fname_rest = "fb-rdf-rest-34";
if($2 ~  "</basketball*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-33


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-american_football"; fname_rest = "fb-rdf-rest-35";
if($2 ~  "</american_football.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-34


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-olympics"; fname_rest = "fb-rdf-rest-36";
if($2 ~  "</olympics.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-35


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-fictional_universe"; fname_rest = "fb-rdf-rest-37";
if($2 ~  "</fictional_universe.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-36


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-theater"; fname_rest = "fb-rdf-rest-38";
if($2 ~  "</theater.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-37


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-visual_art"; fname_rest = "fb-rdf-rest-39";
if($2 ~  "</visual_art.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-38

T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-military"; fname_rest = "fb-rdf-rest-40";
if($2 ~  "</military.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-39

T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-protected_sites"; fname_rest = "fb-rdf-rest-41";
if($2 ~  "</protected_sites.*")
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-40


T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-geography"; fname_rest = "fb-rdf-rest-42";
if($2 ~  "</geography.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-41


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-broadcast"; fname_rest = "fb-rdf-rest-43";
if($2 ~  "</broadcast.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-42


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-architecture"; fname_rest = "fb-rdf-rest-44";
if($2 ~  "</architecture.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-43


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-food"; fname_rest = "fb-rdf-rest-45";
if($2 ~  "</food.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-44


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-aviation"; fname_rest = "fb-rdf-rest-46";
if($2 ~  "</aviation.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-45


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-finance"; fname_rest = "fb-rdf-rest-47";
if($2 ~  "</finance.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-46


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-transportation"; fname_rest = "fb-rdf-rest-48";
if($2 ~  "</transportation.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-47


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-boats"; fname_rest = "fb-rdf-rest-49";
if($2 ~  "</boats.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-48


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-computer"; fname_rest = "fb-rdf-rest-50";
if($2 ~  "</computer.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-49


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-royalty"; fname_rest = "fb-rdf-rest-51";
if($2 ~  "</royalty.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-50


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-library"; fname_rest = "fb-rdf-rest-52";
if($2 ~  "</library.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-51


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-internet"; fname_rest = "fb-rdf-rest-53";
if($2 ~  "</internet.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-52


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-wine"; fname_rest = "fb-rdf-rest-54";
if($2 ~  "</wine.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-53


# 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-projects"; fname_rest = "fb-rdf-rest-55";
if($2 ~  "</projects.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-54


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-chemistry"; fname_rest = "fb-rdf-rest-56";
if($2 ~  "</chemistry.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-55


# 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-w3-domain"; fname_rest = "fb-rdf-rest-57";
if($2 == "<rdf-schema#domain>") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-56


# 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-w3-range"; fname_rest = "fb-rdf-rest-58";
if($2 == "<rdf-schema#range>") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-57


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-cricket"; fname_rest = "fb-rdf-rest-59";
if($2 ~  "</cricket.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-58


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-travel"; fname_rest = "fb-rdf-rest-60";
if($2 ~  "</travel.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-59


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-symbols"; fname_rest = "fb-rdf-rest-61";
if($2 ~  "</symbols.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-60


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-religion"; fname_rest = "fb-rdf-rest-62";
if($2 ~  "</religion.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-61


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-influence"; fname_rest = "fb-rdf-rest-63";
if($2 ~  "</influence.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-62


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-language"; fname_rest = "fb-rdf-rest-64";
if($2 ~  "</language.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-63


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-community"; fname_rest = "fb-rdf-rest-65";
if($2 ~  "</community.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-64


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-metropolitan_transit"; fname_rest = "fb-rdf-rest-66";
if($2 ~  "</metropolitan_transit.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-65


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-automative"; fname_rest = "fb-rdf-rest-67";
if($2 ~  "</automotive.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-66


# 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-digicams"; fname_rest = "fb-rdf-rest-68";
if($2 ~  "</digicams.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-67


# 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-law"; fname_rest = "fb-rdf-rest-69";
if($2 ~  "</law.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-68


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-exhibitions"; fname_rest = "fb-rdf-rest-70";
if($2 ~  "</exhibitions.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-69


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-tennis"; fname_rest = "fb-rdf-rest-71";
if($2 ~  "</tennis.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-70


# 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-venture_capital"; fname_rest = "fb-rdf-rest-72";
if($2 ~  "</venture_capital.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-71


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-opera"; fname_rest = "fb-rdf-rest-73";
if($2 ~  "</opera.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-72


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-comic_books"; fname_rest = "fb-rdf-rest-74";
if($2 ~  "</comic_books.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-73


# # # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-amusement_parks"; fname_rest = "fb-rdf-rest-75";
if($2 ~  "</amusement_parks.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-74


# # # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-dining"; fname_rest = "fb-rdf-rest-76";
if($2 ~  "</dining.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-75


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-ice_hockey"; fname_rest = "fb-rdf-rest-77";
if($2 ~  "</ice_hockey.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-76


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-event"; fname_rest = "fb-rdf-rest-78";
if($2 ~  "</event.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-77


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-spaceflight"; fname_rest = "fb-rdf-rest-79";
if($2 ~  "</spaceflight.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-78


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-zoo"; fname_rest = "fb-rdf-rest-80";
if($2 ~  "</zoo.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-79


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-meteorology"; fname_rest = "fb-rdf-rest-81";
if($2 ~  "</meteorology.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-80


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-w3-inverseof"; fname_rest = "fb-rdf-rest-82";
if($2 == "<owl#inverseOf>") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-81


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-martial_arts"; fname_rest = "fb-rdf-rest-83";
if($2 ~  "</martial_arts.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-82


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-periodicals"; fname_rest = "fb-rdf-rest-84";
if($2 ~  "</periodicals.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-83


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-games"; fname_rest = "fb-rdf-rest-85";
if($2 ~  "</games.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-84


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-celebrities"; fname_rest = "fb-rdf-rest-86";
if($2 ~  "</celebrities.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-85


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-nytimes"; fname_rest = "fb-rdf-rest-87";
if($2 ~  "</nytimes.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-86


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-rail"; fname_rest = "fb-rdf-rest-88";
if($2 ~  "</rail.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-87


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-interests"; fname_rest = "fb-rdf-rest-89";
if($2 ~  "</interests.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-88


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-atom"; fname_rest = "fb-rdf-rest-90";
if($2 ~  "</atom.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-89


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-boxing"; fname_rest = "fb-rdf-rest-91";
if($2 ~  "</boxing.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-90


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-comic_strips"; fname_rest = "fb-rdf-rest-92";
if($2 ~  "</comic_strips.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-91


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-conferences"; fname_rest = "fb-rdf-rest-93";
if($2 ~  "</conferences.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-92


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-skiing"; fname_rest = "fb-rdf-rest-94";
if($2 ~  "</skiing.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-93


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-engineering"; fname_rest = "fb-rdf-rest-95";
if($2 ~  "</engineering.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-94


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-fashion"; fname_rest = "fb-rdf-rest-96";
if($2 ~  "</fashion.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-95


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-radio"; fname_rest = "fb-rdf-rest-97";
if($2 ~  "</radio.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-96


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-kp_lw"; fname_rest = "fb-rdf-rest-98";
if($2 ~  "</kp_lw.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-97


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-distilled_spirits"; fname_rest = "fb-rdf-rest-99";
if($2 ~  "</distilled_spirits.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-98


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-chess"; fname_rest = "fb-rdf-rest-100";
if($2 ~  "</chess.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-99


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-physics"; fname_rest = "fb-rdf-rest-101";
if($2 ~  "</physics.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-100


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-geology"; fname_rest = "fb-rdf-rest-102";
if($2 ~  "</geology.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-101


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-bicycles"; fname_rest = "fb-rdf-rest-103";
if($2 ~  "</bicycles.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-102


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"

T0=$(gdate +"%s%3N")

gawk '{ fname = "slices-new/fb-rdf-pred-comedy"; fname_rest = "fb-rdf-rest-104";
if($2 ~  "</comedy.*") 
{ print $0 >> fname; } 
else { print $0 >> fname_rest; } }' fb-rdf-rest-103


# # 
T1=$(gdate +"%s%3N")
printf "$T0 \t $T1 \n"


