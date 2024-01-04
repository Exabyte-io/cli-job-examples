#!/bin/bash
# ---------------------------------------------------------------- #
#  This file contains variables that will be sourced in run.sh     #
#  Update the variables below as appropriate.                      #
# ---------------------------------------------------------------- #

#  Accounting.
#  Uncomment and replace with organizational account name as appropriate.
# PROJECT_NAME=${PROJECT_NAME:-"seminar-default"}

#  Compute.
QUEUE=${QUEUE:-"D"}
WALLTIME=${WALLTIME:-"00:01:00:00"}
NODES=${NODES:-1}
PPN=${PPN:-1}

#  General
JOB_NAME_PREFIX=${JOB_NAME_PREFIX:-"DeepMD-MLFF"}
EMAIL=${EMAIL:-"info@mat3ra.com"}
WAIT_FOR_COMPLETION=${WAIT_FOR_COMPLETION:-""}
WAIT_TIMEOUT=${WAIT_TIMEOUT:-1800}              # 30 minutes.
WAIT_POLL_INTERVAL=${WAIT_POLL_INTERVAL:-5}     # 5 sec.

# ---------------------------------------------------------------- #
#  Util function(s) follow below. Not intended to be modified.     #
# ---------------------------------------------------------------- #
create_job_script_with_with_dependency() {

    STEP_NAME=$1
    FILE=$2
    JOB_ID_TO_WAIT_FOR=$3

    NEW_FILE="$FILE.with_dependency"
    cp $FILE $NEW_FILE

    [[ ! -z $PROJECT_NAME ]] && sed -i "s/##PBS -A.*/#PBS -A ${PROJECT_NAME}/g" $NEW_FILE

    [[ ! -z $NODES ]] && sed -i -E "s/(#PBS -l nodes=).*/\1${NODES}/g" $NEW_FILE
    [[ ! -z $PPN ]] && sed -i -E "s/(#PBS -l ppn=).*/\1${PPN}/g" $NEW_FILE
    [[ ! -z $WALLTIME ]] && sed -i -E "s/(#PBS -l walltime=).*/\1${WALLTIME}/g" $NEW_FILE
    [[ ! -z $QUEUE ]] && sed -i -E "s/(#PBS -q ).*/\1${QUEUE}/g" $NEW_FILE
    [[ ! -z $EMAIL ]] && sed -i -E "s/(#PBS -M ).*/\1${EMAIL}/g" $NEW_FILE

    [[ ! -z $JOB_NAME_PREFIX ]] && sed -i -E "s/(#PBS -N ).*/\1${JOB_NAME_PREFIX}-${STEP_NAME}/g" $NEW_FILE

    [[ ! -z $JOB_ID_TO_WAIT_FOR ]] && sed -i -E "s/##PBS -W(.*)JOB_ID_TO_WAIT_FOR/#PBS -W\1${JOB_ID_TO_WAIT_FOR}/g" $NEW_FILE

    echo $NEW_FILE

}
