
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name Sensores -dir "C:/Users/HeadHunters/Desktop/4to Semestre/DSD/Sensores/planAhead_run_1" -part xc3s500efg320-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/HeadHunters/Desktop/4to Semestre/DSD/Sensores/EstadosSensores.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/HeadHunters/Desktop/4to Semestre/DSD/Sensores} }
set_property target_constrs_file "EstadosSensores.ucf" [current_fileset -constrset]
add_files [list {EstadosSensores.ucf}] -fileset [get_property constrset [current_run]]
link_design
