read -p "Oz, ZL, bulk_corr?(Oz,ZL,bulk_corr) : " orderparameter
sinfo
# read -p "subpartition : " subpartition
read -p "partition : " partition
scontrol show partition "scopion${partition}"
# read -p "sub Number of core : " subNcore
read -p "Number of core : " Ncore
read -p "Spin : " Spin
# read -p "BC(PBC or OBC) : " BC
read -p "ProDis : " P
read -p "BonDim : " bonDim
read -p "Init_L : " L1
read -p "Final_L : " L2
read -p "Space_L : " space_L
read -p "Init_J : " J1
read -p "Final_J : " J2
read -p "Space_J : " space_J
read -p "Init_D : " D1
read -p "Final_D : " D2
read -p "Space_D : " space_D
read -p "seed1 : " s1
read -p "seed2 : " s2
read -p "Nseed : " Nseed
read -p "BC : " BC
read -p "deltaSeed : " deltaSeed


# cp /home/aronton/tSDRG_project/Sorting_data/Spin15/sub/sub.sh /home/aronton/tSDRG_project/Sorting_data/Spin15/sub/sub_copy.sh

# sed -e "s@--partition=scopion@--partition=scopion$subpartition@" -i /home/aronton/tSDRG_project/tSDRG/Main_15/sub/sub_copy.sh

# sed -e "s@--cpus-per-task@--cpus-per-task=$subNcore@" -i /home/aronton/tSDRG_project/tSDRG/Main_15/sub/sub_copy.sh

# sed -e "s@/home/aronton/tSDRG_project/tSDRG/Main_15/jobRecord/slurmOutput/fileName@/home/aronton/tSDRG_project/tSDRG/Main_15/sub/sub_copy@" -i /home/aronton/tSDRG_project/tSDRG/Main_15/sub/sub_copy.sh

echo "Partition:" ${partition} "Number of core:" ${cpuspertask} "Spin:${Spin}"";L:"${L1}"~" ${L2} "(" ${space_L} ")" ";J:" ${J1} "~" ${J2} "(" ${space_J} ")" ";D:" ${D1} "~" ${D2} "(" ${space_D} ")" ",seed1:" ${s1} ",seed2:" ${s2} "Orderparameter:" ${orderparameter}

read -p "Continue or not (Y/N): " Continue

nohup sh /home/aronton/tSDRG_project/Sorting_data/tSDRG_Sorting/Metasub_${orderparameter}.sh $orderparameter $partition $Ncore $Spin $P $bonDim $L1 $L2 $space_L $J1 $J2 $space_J $D1 $D2 $space_D $s1 $s2 $Nseed $BC $deltaSeed&
