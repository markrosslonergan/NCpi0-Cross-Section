HOSTNAME=$(hostname -s)

if [[ $HOSTNAME == uboonegpvm* ]]
then
## Set up UPS
source /cvmfs/uboone.opensciencegrid.org/products/setup_uboone.sh

## Set up compatible versions of ROOT and cmake
#setup root v6_12_06a -q e15:prof
#setup root v6_28_12 -q e20:p3915:prof
setup root v6_20_08a -q e20:p383b:prof
#setup cmake v3_7_0
setup cmake v3_27_4
#setup python v2_7_3
#setup python v3_9_15
setup python v3_8_3b
#setup tbb v2021_9_0 -q e20:prof

## Right now the installation of the MAT that has been correctly modified for uBooNE
## usage lives exclusively in Rob's user area. He plans to commit the needed change
## to a branch of the MAT repo so that it can be checked out by any future uBooNE users.
## Source code for PlotUtils at /exp/uboone/app/users/ltong/MAT/DPUtils/PlotUtils/src

## Add MAT to relevant environment variables
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/exp/uboone/app/users/ltong/MAT/opt2/lib/
#export PATH=$PATH:/exp/uboone/app/users/ltong/MAT/opt2/bin/
#export ROOT_INCLUDE_PATH=/exp/uboone/app/users/ltong/MAT/opt2/include/PlotUtils:/exp/uboone/app/users/ltong/MAT/opt2/include:${ROOT_INCLUDE_PATH}
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/exp/uboone/app/users/eyandel/MAT/opt/lib/
export PATH=$PATH:/exp/uboone/app/users/eyandel/MAT/opt/bin/
export ROOT_INCLUDE_PATH=/exp/uboone/app/users/eyandel/MAT/opt/include/PlotUtils:/exp/uboone/app/users/eyandel/MAT/opt/include:${ROOT_INCLUDE_PATH}
export PLOTUTILSROOT=/exp/uboone/app/users/eyandel/MAT/opt/lib

elif [[ $HOSTNAME == "manannan" ]]
then
## Set up UPS
source /opt/root/6.32.00_binary/root/bin/thisroot.sh

## Right now the installation of the MAT that has been correctly modified for uBooNE
## usage lives exclusively in Rob's user area. He plans to commit the needed change
## to a branch of the MAT repo so that it can be checked out by any future uBooNE users.
## Source code for PlotUtils at /exp/uboone/app/users/ltong/MAT/DPUtils/PlotUtils/src

## Add MAT to relevant environment variables
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/app/users/lntong/MAT/opt/lib/
export PATH=$PATH:/app/users/lntong/MAT/opt/bin/
export ROOT_INCLUDE_PATH=/app/users/lntong/MAT/opt/include/PlotUtils:/app/users/lntong/MAT/opt/include:${ROOT_INCLUDE_PATH}

else

echo "Setup failed. Hostname $HOSTNAME not found."

fi
