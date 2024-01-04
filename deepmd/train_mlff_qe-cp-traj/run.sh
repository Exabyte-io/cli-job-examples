#!/bin/bash
# ---------------------------------------------------------------- #
#                                                                  #
#  Run script that executes steps included in this directory       #
#                                                                  #
#  Submits jobs in a sequence and make them wait for one another   #
#                                                                  #
#  For more information visit https://docs.exabyte.io/cli/jobs     #
# ---------------------------------------------------------------- #

source ./settings.sh

STEPS=(
    "step_01"
    "step_02"
    "step_03"
    "step_04"
)

for step_name in ${STEPS[@]}; do
    cd $step_name*
        JOB_SCRIPT=$(create_job_script_with_with_dependency $step_name job.pbs $JOB_ID)
        JOB_ID=$(qsub $JOB_SCRIPT)
        echo "Submitted job for $step_name with id $JOB_ID."
    cd - &> /dev/null
done

# Get the job id number from the job id string, such as "94854.master-production-20160630-cluster-001...."
JOB_ID_NUMBER=${JID%%.*}
LAST_STEP_NAME_PREFIX=./${STEPS[-1]}/

echo "Use 'qstat' to check the status of the jobs."
echo "Use 'watch -n 5 ls -lhtra */output' to periodically check output directories of the jobs."

if [ ! -z "$WAIT_FOR_COMPLETION" ]; then
    while ! ls $LAST_STEP/* | grep $JOB_ID_NUMBER &> /dev/null && ((SECONDS <= $WAIT_TIMEOUT)); do
        printf "%0.s=" {1..80}
        echo
        echo "Waiting for the last job $JOB_ID to finish: ${SECONDS} of ${WAIT_TIMEOUT}...\n"
        echo
        printf "%0.s=" {1..80}
        ls -lhtra ./*/output
        sleep ${WAIT_POLL_INTERVAL}
    done
else
    echo "Submitted jobs and exiting."
fi

