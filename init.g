#
# DerivedCategories: Gap package to create derived categories
#
# Reading the declaration part of the package.
#

ReadPackage( "DerivedCategories", "gap/DerivedCategories.gd");
ReadPackage( "DerivedCategories", "gap/ExceptionalCollection.gd" );
ReadPackage( "DerivedCategories", "gap/QPA.gd" );
ReadPackage( "DerivedCategories", "gap/Decomposition.gd" );
ReadPackage( "DerivedCategories", "gap/Convenience.gd" );
ReadPackage( "DerivedCategories", "gap/Functors.gd" );
ReadPackage( "DerivedCategories", "gap/Hom.gd" );
ReadPackage( "DerivedCategories", "gap/Tensor.gd" );
ReadPackage( "DerivedCategories", "gap/NaturalTransformations.gd" );
ReadPackage( "DerivedCategories", "gap/BoxProduct.gd" );
ReadPackage( "DerivedCategories", "gap/ExceptionalReplacement.gd" );

if IsPackageMarkedForLoading( "BBGG", ">= 2019.04.16" ) then
  ReadPackage( "DerivedCategories", "gap/CohrerntScheavesOverProjectiveSpace.gd" );
  ReadPackage( "DerivedCategories", "gap/ProductOfProjectiveSpaces.gd" );
fi;

if IsPackageMarkedForLoading( "NConvex", ">= 2020.01.01" ) then
  ReadPackage( "DerivedCategories", "gap/ToolsForHomalg.gd" );
  ReadPackage( "DerivedCategories", "gap/ToolsForFreydCategories.gd" );
fi;
