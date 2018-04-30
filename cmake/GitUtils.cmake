find_package(Git REQUIRED)

# update submodule
macro(git_submodule sourcedir)
  execute_process(
    COMMAND "${GIT_EXECUTABLE}" submodule update --init "${sourcedir}"
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
  )
endmacro()

# clone submodule dir to a build dir
macro(git_submodule_to_build name rev sourcedir binarydir versionfile)

  # rerun cmake if version changes
  configure_file("${sourcedir}/${versionfile}" "${versionfile}")

  # clone to build dir if not already
  add_custom_command(
    OUTPUT "${binarydir}"
    COMMAND "${GIT_EXECUTABLE}" clone "${sourcedir}" "${binarydir}"
    DEPENDS "${sourcedir}/.git"
    COMMENT "Cloning ${name}"
  )

  # pull to build dir when version in submodule dir updates
  add_custom_command(
    OUTPUT "${binarydir}/${versionfile}"
    COMMAND "${GIT_EXECUTABLE}" pull origin +${rev}
    COMMAND "${CMAKE_COMMAND}" -E copy "${sourcedir}/${versionfile}" "${binarydir}/${versionfile}"
    WORKING_DIRECTORY "${binarydir}"
    DEPENDS "${sourcedir}/${versionfile}" "${binarydir}"
    COMMENT "Pulling ${name} ${rev}"
  )
endmacro()

