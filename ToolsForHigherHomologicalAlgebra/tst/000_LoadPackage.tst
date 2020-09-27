#
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "ToolsForHigherHomologicalAlgebra", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "ToolsForHigherHomologicalAlgebra" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
