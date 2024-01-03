#!/bin/bash
# ---------------------------------------------------------------- #
#                                                                  #
#  Run script that executes steps included in this directory       #
#                                                                  #
#  Submits jobs in a sequence and make them wait for one another   #
#                                                                  #
#  For more information visit https://docs.exabyte.io/cli/jobs     #
# ---------------------------------------------------------------- #

set_dependency_for_file_on_job_id() {
    FILE=$1
    JOB_ID=$2
    if [[ ! -z $JOB_ID ]]; then
        sed "s/##PBS -W/#PBS -W/g" $FILE > "$FILE.with_dependency"
        sed -i "s/JOB_ID_TO_WAIT_FOR/${JOB_ID}/g" "$FILE.with_dependency"
    else
        cp $FILE $FILE.with_dependency
    fi
}

echo "Submitting the job for step_01"

cd step_01*
JOB_ID_STEP_01=$(qsub job.pbs)
cd - &> /dev/null

echo "Submitting the job for step_02"
cd step_02*
    set_dependency_for_file_on_job_id job.pbs $JOB_ID_STEP_01
    JOB_ID_STEP_02=$(qsub job.pbs.with_dependency)
cd - &> /dev/null

echo "Submitting the job for step_03"
cd step_03*
    set_dependency_for_file_on_job_id job.pbs $JOB_ID_STEP_02
    JOB_ID_STEP_03=$(qsub job.pbs.with_dependency)
cd - &> /dev/null

echo "Submitting the job for step_04"
cd step_04*
    set_dependency_for_file_on_job_id job.pbs $JOB_ID_STEP_03
    JOB_ID_STEP_04=$(qsub job.pbs.with_dependency)
cd - &> /dev/null

echo "Finished submitting jobs for $JOB_ID_STEP_01, $JOB_ID_STEP_02, $JOB_ID_STEP_03, $JOB_ID_STEP_04."

echo "Waiting for the last job to finish..."
echo "Use 'qstat' to check the status of the jobs."
echo "Use 'watch -n 5 ls -lhtra step_0?*/output' to check the output directories of the jobs."
