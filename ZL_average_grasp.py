# Dimerization & String Order Parameter 
### average raw data to meta data
import os
import math
import time
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt 
from scipy.optimize import curve_fit
import sys


# parameter input

spin = int(sys.argv[1])

BC = str(sys.argv[2])

probDis = int(sys.argv[3])

chi = int(sys.argv[4])

L = int(sys.argv[5])

jdis = str(sys.argv[6])

dim = str(sys.argv[7])

initial_Seed = int(sys.argv[8])

final_Seed = int(sys.argv[9])

print("\n---------------Parameter List----------------\n")

print("spin:",spin)
print("BC:",BC)
print("Prob:",probDis)
print("chi:",chi)
print("L:",L)
print("Jdis",jdis)
print("Dim",dim)
print("initial_Seed",initial_Seed)
print("final_Seed",final_Seed)

print("\n---------------Direction Path----------------\n")

direc1 = '/home/aronton/tSDRG_project/Sorting_data/Spin' + str(spin) + '/metadata/'
print(direc1)
print("\n")

if(os.path.exists(direc1) == False):
    os.mkdir(direc1)
direc2 =  direc1 + 'ZL_Accumulation11/'
print(direc2)
print("\n")

if(os.path.exists(direc2) == False):
    os.mkdir(direc2)
direc3 =  direc2 + jdis +'/'
print(direc3)
print("\n")

if(os.path.exists(direc3) == False):
    os.mkdir(direc3)
direc4 =  direc3 + dim +'/'
print(direc4)
print("\n")

if(os.path.exists(direc4) == False):
    os.mkdir(direc4)

accumulation_path = direc4 +'ZL_Accumulation_' + jdis + "_" + dim + "_" + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'

die_seed_path = direc4 +'ZL_Die_Seed_' + jdis + "_" + dim + '_' + BC +'_L'+ str(L) +'_P' + str(probDis) + '_m'+ str(chi) + '.csv'

direc1_ave = '/home/aronton/tSDRG_project/Sorting_data/Spin' + str(spin) + '/metadata/'
print(direc1_ave)
print("\n")

if(os.path.exists(direc1_ave) == False):
    os.mkdir(direc1_ave)
direc2_ave =  direc1_ave + 'ZL1/'
print(direc2_ave)
print("\n")

if(os.path.exists(direc2_ave) == False):
    os.mkdir(direc2_ave)
direc3_ave =  direc2_ave + jdis +'/'
print(direc3_ave)
print("\n")

if(os.path.exists(direc3_ave) == False):
    os.mkdir(direc3_ave)
direc4_ave =  direc3_ave + dim +'/'
print(direc4_ave)
print("\n")

if (os.path.exists(direc4_ave) == False):
    os.mkdir(direc4_ave)

average_path = direc4_ave + BC + '_L' + str(L) + "_P" + str(probDis) + "_m" + str(chi) + "_ZL" + '.csv'

print("accumulation_path:")
print(accumulation_path)
print("\n")

print("average_path:")
print(average_path)
print("\n")


print("\n---------------averageFrame----------------\n")

averageFrame = pd.DataFrame(columns = ['ZL', 'error', 'Nseed', 'Nsample'])
print("averageFrame",averageFrame)

print("\n----------------Start---------------\n")


start_time = time.time()
print("start time:")
print(time.time())

if(initial_Seed != 1):

    initial_Seed = pd.read_csv(average_path).at[0, "Nseed"]
    initial_Seed = int(initial_Seed) + 1

    print("accumulation_path_exist\n")
    accumulation_frame = pd.read_csv(accumulation_path)

    print("accumulation_frame\n")
    print(accumulation_frame)

    print("average_frame\n")
    print(pd.read_csv(average_path))

    if(os.path.exists(die_seed_path)):
        print("die_seed_frame exist:\n")
        die_seed_frame = pd.read_csv(die_seed_path)
        print(die_seed_frame)
    else:
        print("die_seed_path does not exist, creatOne")
        die_seed_frame = pd.DataFrame(columns = ['die_seed_num'])
        print("die_seed_frame:\n")
        print(die_seed_frame)

    for seed_num in range(initial_Seed, final_Seed + 1):
        # print("seed_num:",seed_num)
        my_csv = '/home/aronton/tSDRG_project/tSDRG/Main_' + str(spin) + '/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed_num) + '/ZL' + '.csv'

        my_file = '/home/aronton/tSDRG_project/tSDRG/Main_' + str(spin) + '/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed_num) 

        if(os.path.exists(my_csv)):
            inputFrame = pd.read_csv(my_csv)
            ZL = inputFrame.at[0, "ZL"]
            accumulation_frame = accumulation_frame.append({"ZL": ZL,"seed_num": int(seed_num)}, ignore_index=True)
        else:
            if(os.path.exists(my_file)):
                die_seed_frame.append({"die_seed_num": int(seed_num)},ignore_index=True)
                print("die_seed_num:", seed_num)
                print("my_csv:", my_csv)
            else:
                print("missing data:", seed_num)
                print("my_file:", my_csv)
else:
    print("start from seed 1, creat one")
    accumulation_frame = pd.DataFrame(columns = ['ZL','seed_num'])

    die_seed_frame = pd.DataFrame(columns = ['die_seed_num'])
    print("die_seed_frame\n")
    print(die_seed_frame)
    
    # print("die_seed",die_seed)
    
    for seed_num in range(initial_Seed, final_Seed + 1):
        # print("seed_num:",seed_num)

        my_csv = '/home/aronton/tSDRG_project/tSDRG/Main_' + str(spin) + '/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed_num) + '/ZL' + '.csv'

        my_file = '/home/aronton/tSDRG_project/tSDRG/Main_' + str(spin) + '/data/'+ BC +'/'+ jdis + '/'+ dim + '/L'+ str(L) +'_P'+ str(probDis) +'_m'+ str(chi) +'_'+ str(seed_num) 

        if(os.path.exists(my_csv)):
            inputFrame = pd.read_csv(my_csv)
            ZL = inputFrame.at[0, "ZL"]
            accumulation_frame = accumulation_frame.append({"ZL": ZL,"seed_num": int(seed_num)}, ignore_index=True)
        else:
            if(os.path.exists(my_file)):
                die_seed_frame.append({"die_seed_num": int(seed_num)},ignore_index=True)
                print("die_seed_num:", seed_num)
                print("my_csv:", my_csv)
            else:
                print("missing data:", seed_num)
                print("my_file:", my_csv)


Nsample = len(accumulation_frame.index)
average = accumulation_frame.mean()["ZL"]
# averageFrame["Nsample"] = len(outputFrame.index)
# averageFrame["Nseed"] = final_Seed
std = accumulation_frame.std()["ZL"]
error = std/np.sqrt(Nsample)
averageFrame = averageFrame.append({"ZL":average,"error":error,"Nseed":final_Seed,"Nsample":Nsample}, ignore_index=True)


end_time = time.time()
print("end time:")
print(time.time())

print("tot_time:",end_time-start_time)

print("\n----------------end---------------\n")

print("Nsample",Nsample)
print("average",average)
print("std",std)
print("error",error)

# Nsample = np.size(ValueArray)
# average = np.average(ValueArray)
# error = np.std(ValueArray) / np.sqrt(Nsample)    
# outputFrame.loc[0] = {'ZL':average,'error':error, 'Nseed':final_Seed, 'Nsample':Nsample}

print("accumulation_frame:\n")
print(accumulation_frame)
if(accumulation_frame["ZL"].isnull().any() == True):
    print("accumulation_frame : No data")
    print(accumulation_frame)
else:
    accumulation_frame.to_csv(accumulation_path, index=False)
    print(accumulation_frame)


print("averageFrame:\n")
print(averageFrame)
if(averageFrame["ZL"].isnull().any() == True):
    print("averageFrame : No data")
    print(averageFrame)
else:
    averageFrame.to_csv(average_path, index=False)
    print(averageFrame)


print("die_seed_frame:\n")
print(die_seed_frame)
if(die_seed_frame["die_seed_num"].isnull().any() == True):
    print("die_seed_num : No data")
    print(die_seed_frame)
else:
    die_seed_frame.to_csv(die_seed_path, index=False)
    print(die_seed_frame)
# die_seed_frame.to_csv(die_seed_path, index=False)

# die_seed_num
# print("averageFrame:\n")
# print(averageFrame)
# averageFrame.to_csv(averge_path, index=False)

# print("die_seed:\n")
# die_seed_frame.to_csv(die_seed_path, index=False)

# zlArray[l,j,d] = average
# zlErrorArray[l,j,d] = error
# zlSampleArray[l,j,d] = Nsample

# averageFrame.to_csv(averge_path,index=0)

# np.save( "/home/aronton/tSDRG_project/Sorting_data/Spin" + str(spin) + "/zlArray" + str(spin) + ".npy", zlArray)
# np.save( "/home/aronton/tSDRG_project/Sorting_data/Spin" + str(spin) + "/zlErrorArray" + str(spin) + ".npy", zlErrorArray)
# np.save( "/home/aronton/tSDRG_project/Sorting_data/Spin" + str(spin) + "/zlSampleArray" + str(spin) + ".npy", zlSampleArray)

# zlArrayFrame = []
# zlErrorArrayFrame = []
# zlSampleArrayFrame = []

# for k in range(len(L)):
#     zlArrayFrame.append( pd.DataFrame( zlArray[k,:,:], columns = Dim, index = Jdis, dtype = int))
#     # print(L[k])
#     # print(ZLMetaArrayFrame[k])

# for k in range(len(L)):
#     zlErrorArrayFrame.append( pd.DataFrame( zlErrorArray[k,:,:], columns = Dim, index = Jdis, dtype = int))
#     # print(L[k])
#     # print(SOPMetaArrayFrame[k])

# for k in range(len(L)):
#     zlSampleArrayFrame.append( pd.DataFrame( zlSampleArray[k,:,:], columns = Dim, index = Jdis, dtype = int))
#     # print(L[k])
#     # print(SOPMetaArrayFrame[k])

# zlArrayWriter = pd.ExcelWriter('zlArray' + str(spin) + '.xlsx', engine='xlsxwriter')
# zlErrorArrayWriter = pd.ExcelWriter('zlErrorArray' + str(spin) + '.xlsx', engine='xlsxwriter')
# zlSampleArrayWriter = pd.ExcelWriter('zlSampleArray' + str(spin) + '.xlsx', engine='xlsxwriter')


# for k in Ls:
#     zlArrayFrame[k].to_excel(zlArrayWriter, sheet_name = str(k))

# for k in Ls:
#     zlErrorArrayFrame[k].to_excel(zlErrorArrayWriter, sheet_name = str(k))

# for k in Ls:
#     zlSampleArrayWriter[k].to_excel(zlSampleArrayWriter, sheet_name = str(k))


# zlArrayWriter.save()
# zlErrorArrayWriter.save()
# zlSampleArrayWriter.save()

print('all done')