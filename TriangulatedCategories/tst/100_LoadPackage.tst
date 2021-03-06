# SPDX-License-Identifier: GPL-2.0-or-later
# TriangulatedCategories: Framework for triangulated categories
#
# This file tests if the package can be loaded without errors or warnings.
#
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "TriangulatedCategories", false );
true
gap> LoadPackage( "DerivedCategories", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "TriangulatedCategories" );
true
gap> LoadPackage( "DerivedCategories" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
