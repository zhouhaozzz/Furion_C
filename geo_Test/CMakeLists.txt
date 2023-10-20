aux_source_directory("${PROJECT_SOURCE_DIR}/geo_Test" DIR_GEO_TEST)
aux_source_directory("${PROJECT_SOURCE_DIR}/src/display" DIR_SOURCE_DISPLAY)
aux_source_directory("${PROJECT_SOURCE_DIR}/src/furion_scri" DIR_SOURCE_FUR_SCRI)
aux_source_directory("${PROJECT_SOURCE_DIR}/src/import_and_display_srw" DIR_SOURCE_IMP_DIS_SRW)
aux_source_directory("${PROJECT_SOURCE_DIR}/src/optical_element" DIR_SOURCE_OPT_ELE)
aux_source_directory("${PROJECT_SOURCE_DIR}/src/propagation" DIR_SOURCE_PROPAGATION)
aux_source_directory("${PROJECT_SOURCE_DIR}/src/surface" DIR_SOURCE_SURFACE)
aux_source_directory("${PROJECT_SOURCE_DIR}/src/xop" DIR_SOURCE_XOP)
aux_source_directory("${PROJECT_SOURCE_DIR}/src" DIR_SOURCE_SRC)

add_executable( Furion_test 
                #g_plane_test.cpp
                g_hole_test.cpp;
            tool_stderr.cpp;
                ${DIR_SOURCE_DISPLAY}
				${DIR_SOURCE_FUR_SCRI}
				${DIR_SOURCE_IMP_DIS_SRW}
				${DIR_SOURCE_OPT_ELE}
				${DIR_SOURCE_PROPAGATION}
				${DIR_SOURCE_SURFACE}
				${DIR_SOURSCE_XOP}
               
             
              
 ) 

target_include_directories(Furion_test PRIVATE                          
                          ${DIR_GEO_TEST}
                          ${DIR_SOURCE_SRC}
                           ${DISPLAY_H}
                           ${FUR_SCRI_H}
                           ${IMP_DIS_SRW_H}
                           ${OPT_ELE_H}
                           ${PROPAGATION_H}
                           ${SURFACE_H}
                           ${XOP_H}
                           ${SRC_H}
                           ${catkin_INCLUDE_DIRS}
                     
                           )
install(TARGETS Furion_test RUNTIME DESTINATION ${PROJECT_SOURCE_DIR}/geo_Test/bin/)