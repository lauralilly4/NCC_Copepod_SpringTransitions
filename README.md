# NCC_Copepod_SpringTransitions
Scripts and datafiles to plot visualizations and statistical analyses for Newport Hydrographic Line (NHL) copepod community, 1996-2020. Copepods are part of the zooplankton community.
Newport Hydrographic Line runs perpendiularly offshore from Newport, OR, USA, into the Northern California Current System. Station NH05 is located 5 nm offshore of Newport, in 
65 m water.

Datasets: 
  - 'NH05_CopeDens_log_subSpp_1996_2020.csv' - Copepod species-level density at Station NH05, sampled biweekly (as possible) between 1996-2020. Data are log-transformed 
                                                (log10[density+0.1]+1)
  - 'NH05_Cope_biom_MDSscore_v4_CAM_RawDts.csv' - nMDS scores (dimensions 1,2,3) for each sampling date, indicating locations on first three axes of ordination for copepod community
                                                - Scores are generated in 'Lilly_etal_NCC_CopePhys_S1_nMDS.R' but are pre-saved for running in subsequent codes
