#
# QuotientCategoriesForCAP: A gap package to create quotient categories of CAP categories
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "QuotientCategoriesForCAP" );

TestDirectory(DirectoriesPackageLibrary( "QuotientCategoriesForCAP", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
