echo "orderparameter         ==> ${1}"
echo "partition         ==> ${2}"
echo "Ncore         ==> ${3}"
echo "Spin         ==> ${4}"
echo "ProbDis        ==> ${5}"
echo "bonDim        ==> ${6}"
echo "L1        ==> ${7}"
echo "L2        ==> ${8}"
echo "space_L        ==> ${9}"
echo "J1        ==> ${10}"
echo "J2        ==> ${11}"
echo "space_J        ==> ${12}"
echo "D1        ==> ${13}"
echo "D2        ==> ${14}"
echo "space_D        ==> ${15}"
echo "seed1        ==> ${16}"
echo "seed2        ==> ${17}"
echo "Nseed :   ==> ${18}"
echo "BC :   ==> ${19}"
# echo "delta seed :   ==> ${20}"

date

orderparameter=${1}

partition=$(echo "scale=0; (${2})/1" | bc)
echo -e "partitio=$partition"

Ncore=$(echo "scale=0; (${3})/1" | bc)
echo -e "Ncore=$Ncore"

Spin=$(echo "scale=0; (${4})/1" | bc)
echo -e "Spin=$Spin"

ProbDis=$(echo "scale=0; (${5})/1" | bc)
echo -e "P=$P"

bonDim=$(echo "scale=0; (${6})/1" | bc)
echo -e "bonDim=$bonDim"

L1=$(echo "scale=0; (${7})/1" | bc)
echo -e "L1=$L1"
L2=$(echo "scale=0; (${8})/1" | bc)
echo -e "L2=$L2"
space_L=$(echo "scale=0; (${9})/1" | bc)
echo -e "space_L=$space_L"

J1=$(echo "scale=2; (${10})/1." | bc)
echo -e "J1=$J1"
J2=$(echo "scale=2; (${11})/1." | bc)
echo -e "J2=$J2"
space_J=$(echo "scale=2; (${12})/1." | bc)
echo -e "space_J=$space_J"

D1=$(echo "scale=2; (${13})/1." | bc)
echo -e "D1=$D1"
D2=$(echo "scale=2; (${14})/1." | bc)
echo -e "D2=$D2"
space_D=$(echo "scale=2; (${15})/1." | bc)
echo -e "space_D=$space_D"

seed1=$(echo "scale=0; (${16})/1" | bc)
echo -e "seed1=$seed1"
seed2=$(echo "scale=0; (${17})/1" | bc)
echo -e "seed2=$seed2"
Nseed=$(echo "scale=0; (${18})/1" | bc)
echo -e "Nseed=$Nseed"

BC=${19}
echo -e "BC=$BC"

sorting_Path="/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/submit_record/"

now_date="$(date +'%Y_%m_%d')/"
# now="${date}"

if [ -d "${sorting_Path}""${now_date}" ]; then
    # 目錄 /path/to/dir 存在
    echo -e "${sorting_Path}""${now_date}"
else
    # 目錄 /path/to/dir 不存在
    echo -e "mkdir""${sorting_Path}""${now_date}"
    mkdir "${sorting_Path}""${now_date}"
fi

file="${sorting_Path}${now_date}Orderparameter=${orderparameter};P=${P};B=${bonDim};L=${L1}_${L2}(${space_L});J=${J1}_${J2}(${space_J});D=${D1}_${D2}(${space_D});seed1=${seed1}_seed2=${seed2};Partition=${partition};BC=${BC};Number_of_core=${Ncore}"

echo -e "${file}"

date >> "${file}.txt"

echo -e "Partition:${partition};Number of core:${Ncore};Spin:${Spin};L:${L1}~${L2}(${space_L});J:${J1}~${J2}(${space_J});D:${D1}~${D2}(${space_D}),seed1:${seed1},seed2:${seed2};Orderparameter:${orderparameter};BC=${BC}" >> "${file}.txt"

sorting_Path="/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/submit_record/"

now_date="$(date +'%Y_%m_%d')/"
# now="${date}"

if [ -d "${sorting_Path}""${now_date}" ]; then
    # submit目錄存在
    echo -e "${sorting_Path}""${now_date}"
else
    # submit目錄不存在
    echo -e "mkdir""${sorting_Path}""${now_date}"
    mkdir "${sorting_Path}""${now_date}"
fi

file="${sorting_Path}${now_date}Orderparameter=${orderparameter};P=${P};B=${bonDim};L=${L1}_${L2}(${space_L});J=${J1}_${J2}(${space_J});D=${D1}_${D2}(${space_D});seed1=${seed1}_seed2=${seed2};Partition=${partition};BC=${BC};Number_of_core=${Ncore}"

echo -e "${file}"

date >> "${file}.txt"

echo -e "Partition:${partition};Number of core:${Ncore};Spin:${Spin};L:${L1}~${L2}(${space_L});J:${J1}~${J2}(${space_J});D:${D1}~${D2}(${space_D}),seed1:${seed1},seed2:${seed2};Orderparameter:${orderparameter};BC=${BC}" >> "${file}.txt"

if [ "${space_L}" == "0" ]
then
    t0=$(echo "${space_L}" | bc)
else
    t0=$(echo "(${L2}-${L1})/${space_L}" | bc)
fi

if [ "${space_J}" == "0" ]
then
    t1=$(echo "${space_J}" | bc)
else
    t1=$(echo "(${J2}-${J1})/${space_J}" | bc)
fi

if [ "${space_D}" == "0" ]
then
    t2=$(echo "${space_D}" | bc)
else
    t2=$(echo "(${D2}-${D1})/${space_D}" | bc)
fi

for (( l=0; l<=${t0}; l=l+1 ))
do
        L=$(echo "scale=3; ${L1}+${l}*${space_L}" | bc)
        echo -e "ooooooooooL_L=${L}_oooooooooo"
        echo -e "\n\noooooooooo_L=${L}_oooooooooo\n\n" >> "${file}.txt"

        if [ -d "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}" ]; then
            # 記錄檔目錄存在
            echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}_ok"
            echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}_ok" >> "${file}.txt"
        else
            # 記錄檔目錄不存在
            echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}"
            echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}" >> "${file}.txt"
            mkdir "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}"
        fi

        if [ -d "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}" ]; then
            # 腳本目錄存在
            echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}_ok"
            echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}_ok" >> "${file}.txt"
        else
            # 腳本目錄不存在
            echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}"
            echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}" >> "${file}.txt"
            mkdir "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}"
        fi

        for (( j=0; j<=${t1}; j=j+1 ))
        do
                J=$(echo "scale=3; ${J1}+${j}*${space_J}" | bc)
                J_100=$(echo "scale=0; 100*(${J1}+${j}*${space_J})/1" | bc)

                if [ $J_100 -lt 10 ]
                then
                    Jdis="Jdis00"$J_100
                elif [ $J_100 -ge 10 ] && [ $J_100 -lt 100 ]
                then
                    Jdis="Jdis0"$J_100
                else
                    Jdis="Jdis"$J_100
                fi

                echo "xxxxxxxxxxxxxxx_${Jdis}_xxxxxxxxxxxxxxx"
                echo -e "\n\nxxxxxxxxxxxxxxx_${Jdis}_xxxxxxxxxxxxxxx\n\n" >> "${file}.txt"

                echo "J:"$J
                echo -e "J:${J}\n" >> "${file}.txt"

                if [ -d "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}" ]; then
                    # 記錄檔目錄存在
                    echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}_ok"
                    echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}_ok" >> "${file}.txt"
                else
                    # 記錄檔目錄不存在
                    echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}"
                    echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}" >> "${file}.txt"
                    mkdir "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}"
                fi

                if [ -d "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}" ]; then
                    # 腳本目錄存在
                    echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}_ok"
                    echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}_ok" >> "${file}.txt"
                else
                    # 腳本目錄不存在
                    echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}"
                    echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}" >> "${file}.txt"
                    mkdir "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}"
                fi

                for (( d=0; d<=${t2}; d=d+1 ))
                do
                        D=$(echo "scale=3; ${D1}+${d}*${space_D}" | bc)
                        D_100=$(echo "scale=0; 100*(${D1}+${d}*${space_D})/1" | bc)

                        if [ $D_100 -lt 10 ]
                        then
                            Dim="Dim00"$D_100
                        elif [ $D_100 -ge 10 ] && [ $D_100 -lt 100 ]
                        then
                            Dim="Dim0"$D_100
                        else
                            Dim="Dim"$D_100
                        fi

                        if [ -d "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}/${Dim}" ]; then
                            # 記錄檔目錄存在
                            echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}/${Dim}_ok"
                            echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}/${Dim}_ok" >> "${file}.txt"
                        else
                            # 記錄檔目錄不存在
                            echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}/${Dim}"
                            echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}/${Dim}" >> "${file}.txt"
                            mkdir "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}/${Dim}"
                        fi
                        
                        if [ -d "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}/${Dim}" ]; then
                            # 腳本目錄存在
                            echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}/${Dim}_ok" 
                            echo -e "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}/${Dim}_ok" >> "${file}.txt"
                        else
                            # 腳本目錄不存在
                            echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}/${Dim}"
                            echo -e "mkdir /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}/${Dim}" >> "${file}.txt"
                            mkdir "/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/slurm/${orderparameter}/L${L}/${Jdis}/${Dim}"
                        fi

                        echo -e "---------------${Dim}---------------" 
                        echo -e "\n\n---------------${Dim}---------------\n\n" >> "${file}.txt"

                        echo -e "D:"$D
                        echo -e "D:${D}\n" >> "${file}.txt"

                        fileDirection="/home/aronton/tSDRG_project/tSDRG/Main_${Spin}/data/PBC/${Jdis}/${Dim}/L${L}_P${ProbDis}_m${bonDim}_${seed}/L${L}_P${ProbDis}_m${bonDim}_${seed}corr1.csv"

                        echo -e "${fileDirection}"

                        # if ! [ -f ${fileDirection} ]; then
                        #     continue
                        # fi

                        cp /home/aronton/tSDRG_project/Sorting_data/tSDRG_Sorting/${orderparameter}_sub.sh /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}/${Dim}/${orderparameter}_spin${Spin}_L${L}_${Jdis}_${Dim}_seed1=${seed1}_seed2=${seed2}.sh

                        echo -e "cp /home/aronton/tSDRG_project/Sorting_data/tSDRG_Sorting/${orderparameter}_sub.sh /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}/${Dim}/${orderparameter}_spin${Spin}_L${L}_${Jdis}_${Dim}_seed1=${seed1}_seed2=${seed2}.sh\n" 

                        echo -e "cp /home/aronton/tSDRG_project/Sorting_data/tSDRG_Sorting/${orderparameter}_sub.sh /home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}/${Dim}/${orderparameter}_spin${Spin}_L${L}_${Jdis}_${Dim}_seed1=${seed1}_seed2=${seed2}.sh\n" >> "${file}.txt"

                        scriptDirection="/home/aronton/tSDRG_project/Sorting_data/Spin${Spin}/record/${orderparameter}/L${L}/${Jdis}/${Dim}/${orderparameter}_spin${Spin}_L${L}_${Jdis}_${Dim}_seed1=${seed1}_seed2=${seed2}.sh"
                        
                        echo -e "${scriptDirection}"

                        replace="L${L}/${Jdis}/${Dim}/${orderparameter}_spin${Spin}_L${L}_${Jdis}_${Dim}_seed1=${seed1}_seed2=${seed2}"

                        sed -e "s@Spin@Spin${Spin}@" -i ${scriptDirection}

                        sed -e "s@fileName@${replace}@" -i ${scriptDirection}

                        sed -e 's/scopion/scopion'"${partition}"'/' -i ${scriptDirection}

                        sed -e "s@cpus-per-task@cpus-per-task=${Ncore}@" -i ${scriptDirection}
                        
                        sbatch ${scriptDirection} ${Spin} ${BC} ${ProbDis} ${bonDim} ${L} ${Jdis} ${Dim} ${seed1} ${seed2} 

                        echo -e "sbatch ${scriptDirection} ${Spin} ${BC} ${ProbDis} ${bonDim} ${L} ${Jdis} ${Dim} ${seed1} ${seed2}\n" 

                        echo -e "sbatch ${scriptDirection} ${Spin} ${BC} ${ProbDis} ${bonDim} ${L} ${Jdis} ${Dim} ${seed1} ${seed2}\n" >> "${file}.txt"
                done
        done
done

echo "\n\n Orderparameter:${orderparameter};Partition: ${partition} ;Number of core: ${Ncore} ;Spin:${Spin} ;L: ${L1} ~ ${L2} ( ${space_L} );J: ${J1} ~ ${J2} ( ${space_J} ) ;D: ${D1} ~ ${D2} ( ${space_D} ) ,seed1: ${s1} ,seed2: ${s2} ;BC=$BC"

echo -e "\n\n Orderparameter:${orderparameter};Partition: ${partition} ;Number of core: ${Ncore} ;Spin:${Spin} ;L: ${L1} ~ ${L2} ( ${space_L} );J: ${J1} ~ ${J2} ( ${space_J} ) ;D: ${D1} ~ ${D2} ( ${space_D} ) ,seed1: ${s1} ,seed2: ${s2} ;BC=$BC">> "${file}.txt"

echo -e "\ndone."
date