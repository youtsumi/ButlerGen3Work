## Eric instruction https://confluence.slac.stanford.edu/pages/viewpage.action?pageId=245696522
source /u/ek/echarles/lsst/software/stable/config/lsst.bashrc
lsst_setup w_2021_16

pipetask run \
    -b /sdf/group/lsst/camera/IandT/repo_gen3/spot_test \
    -i LSSTCam/raw/all,LSSTCam/calib,/calib/run_12781 \
    -d "instrument='LSSTCam' AND detector=29 AND exposure.observation_type='spot' AND exposure.science_program IN ('12788') AND exposure.seq_num=1820" \
    -o u/youtsumi/spot/20210405a \
    -p /u/ki/youtsumi/gpfs/Spot/cpSpot.yaml \
    --register-dataset-types

pipetask run \
    -b /sdf/group/lsst/camera/IandT/repo_gen3/spot_test \
    -i LSSTCam/raw/all,LSSTCam/calib,/calib/run_12781 \
    -d "instrument='LSSTCam' AND detector=29 AND exposure.observation_type='spot' AND exposure.science_program IN ('12788') AND exposure.seq_num=1820" \
    -o u/youtsumi/spot/junk \
    -p /u/ki/youtsumi/gpfs/Spot/cpSpot2.yaml \
    --register-dataset-types

pipetask run \
    -b /sdf/group/lsst/camera/IandT/repo_gen3/spot_test \
    -i LSSTCam/raw/all,LSSTCam/calib,/calib/run_12781 \
    -d "instrument='LSSTCam' AND detector=29 AND exposure.observation_type='spot' AND exposure.science_program IN ('12784', '12785', '12788', '12789')" \
    -o u/youtsumi/spot/Nov2020 \
    -p /u/ki/youtsumi/gpfs/Spot/cpSpot2.yaml \
    --register-dataset-types -j 4

pipetask run \
    -b /sdf/group/lsst/camera/IandT/repo_gen3/spot_test \
    -i LSSTCam/raw/all,LSSTCam/calib,/calib/run_12781 \
    -d "instrument='LSSTCam' AND detector=29 AND exposure.observation_type='spot' AND exposure.science_program IN ('12788')" \
    -o u/youtsumi/spot/20210504b \
    -p /u/ki/youtsumi/gpfs/Spot/cpSpot2.yaml \
    --register-dataset-types

pipetask run \
    -b /sdf/group/lsst/camera/IandT/repo_gen3/spot_test \
    -i LSSTCam/raw/all \
    -d "instrument='LSSTCam' AND exposure.observation_reason='spot_flat' AND exposure.science_program IN ('12788') AND exposure.seq_num>1820" \
    -o u/youtsumi/spot/20210324 \
    -p /u/ki/youtsumi/gpfs/Spot/cpBias.yaml \
    --register-dataset-types


(lsst-scipipe-0.4.3-ext) -bash-4.2$  butler query-dimension-records  /sdf/group/lsst/camera/IandT/repo_gen3/spot_test detector
instrument  id full_name name_in_raft raft  purpose
---------- --- --------- ------------ ---- ---------
# R10_S02
   LSSTCam  29   R10_S02          S02  R10   SCIENCE
# R22_S20
   LSSTCam  96   R22_S20          S20  R22   SCIENCE

sqlite> select * from detector;
sqlite> .head on
sqlite> .table
instrument|id|full_name|name_in_raft|raft|purpose

sqlite> select * from detector where full_name in ( "R10_S02", "R22_S20" );
instrument|id|full_name|name_in_raft|raft|purpose
LSSTCam|29|R10_S02|S02|R10|SCIENCE
LSSTCam|96|R22_S20|S20|R22|SCIENCE


https://pipelines.lsst.io/v/DM-28598/middleware/faq.html#how-do-i-fix-an-empty-quantumgraph
pipetask build -p cpSpot.yaml --pipeline-dot pipeline.dot
dot pipeline.dot -Tsvg > pipeline.svg    


##### CHANGE TASKS
git clone https://github.com/lsst/pipe_tasks
edit files ...

setup -j -r pipe_tasks
scons version
