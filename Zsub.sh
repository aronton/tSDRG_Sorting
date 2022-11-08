#!/bin/bash
#SBATCH --partition=scopion
#SBATCH --cpus-per-task
#SBATCH --output=/home/aronton/tSDRG_project/Sorting_data/Spin/slurm/fileName.out

# [ "$#" -lt 9 ] && echo "The number of parameter is less than 9.  Stop here." && exit 0
echo "spin         ==> ${1}"
echo "BC         ==> ${2}"
echo "probDis         ==> ${3}"
echo "chi        ==> ${4}"
echo "L        ==> ${5}"
echo "jdis         ==> ${6}"
echo "dim         ==> ${7}"
echo "initial_Seed         ==> ${8}"
echo "final_Seed        ==> ${9}"
# echo "s1        ==> ${10}"
# echo "s2        ==> ${11}"
# echo "Nseed        ==> ${12}"
# echo "Spin         ==> ${13}"


date
    #echo "L:" ${1}~${2}"("${3}")"; "J:" ${4}~${5}"("${6}")"; "D:" ${7}~${8}"("${9}")"; "seed:" ${10}~${11}"("${12}")"; >> /home/aronton/tSDRG_project/Sorting_data/Spin1/record
    python /home/aronton/tSDRG_project/Sorting_data/ZL_average_grasp.py ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8} ${9} 
echo -e "\ndone.\n\n"
date


# [ "$#" -lt 13 ] && echo "The number of parameter is less than 13.  Stop here." && exit 0
# echo "L1         ==> ${1}"
# echo "L2         ==> ${2}"
# echo "space_L         ==> ${3}"
# echo "J1        ==> ${4}"
# echo "J2        ==> ${5}"
# echo "space_J         ==> ${6}"
# echo "D1         ==> ${7}"
# echo "D2         ==> ${8}"
# echo "space_D        ==> ${9}"
# echo "s1        ==> ${10}"
# echo "s2        ==> ${11}"
# echo "Nseed        ==> ${12}"
# echo "Spin         ==> ${13}"


# date
#     #echo "L:" ${1}~${2}"("${3}")"; "J:" ${4}~${5}"("${6}")"; "D:" ${7}~${8}"("${9}")"; "seed:" ${10}~${11}"("${12}")"; >> /home/aronton/tSDRG_project/Sorting_data/Spin1/record
#     python /home/aronton/tSDRG_project/Sorting_data/Spin15/ZL_Metadatacopy.py ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8} ${9} ${10} ${11} ${12} ${13}
# echo -e "\ndone.\n\n"
# date