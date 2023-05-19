# NCC_Copepod_SpringTransitions
Scripts and datafiles to plot visualizations and statistical analyses for manuscript: "Lilly et al. (in prep). Oceanographic drivers of the spring transition in the copepod community of the Northern California Current System."

Datasets are of copepod community density, 1996-2020, at Newport Hydrographic Line (NHL) Station NH05, located 5 nm offshore of Newport, OR, USA, in 65 m of water. Samples are taken biweekly (as possible). Copepods are an integral part of the zooplankton community in the Northern California System. These codes are part of a study examining interannual species variability in the copepod community, timing of the 'Biological Spring Transition' from a winter warm-water to a summer cool-water species group, and habitat ranges and descriptors of each species. 

NOTE: Generalized Additive Model (GAMs) equations are for a subtype called 'Variable Coefficient' GAMs, which evaluate the time-varying impact of a habitat variable (e.g., sea surface temperature) on species abundance. 


CODES: 
  - 'Lilly_etal_NCC_CopePhys_S1 - S2.R' - Two-part script to run nMDS on copepod community across all years
  - 'Lilly_etal_NCC_CopePhys_S3' - Partitioning of species densities into proportions of the total community, to examine changes in species proportions on biweekly and interannual scales. Densities are first log-transformed for improved visualization of sparser species
  - 'Lilly_etal_NCC_CopePhys_S4' - NOTE: 'S4' must be run after 'S3'. .Cluster analysis of interannual variability in copepod community for four seasons (Winter, Spring Transition, Summer, Fall Transition)
  - 'Lilly_etal_NCC_CopePhys_S5_1 - S5_3' - Three-part script to set up and evaluate all GAM options for a species, using a suite of physical variables



DATASETS: 
  - 'NH05_CopeDens_log_subSpp_1996_2020.csv' - Copepod species-level density at Station NH05, sampled biweekly (as possible) between 1996-2020. Data are log-transformed 
                                                (log10[density+0.1]+1)
  - 'NH05_Cope_biom_MDSscore_v4_CAM_RawDts.csv' - nMDS scores (dimensions 1,2,3) for each sampling date, indicating locations on first three axes of ordination for copepod community
                                                - Scores are generated in 'Lilly_etal_NCC_CopePhys_S1_nMDS.R' but are pre-saved for running in subsequent codes
  - 'Phys_Inds' - Folder of physical indices used to run GAMs (Codes S5_1 - S5_3)



