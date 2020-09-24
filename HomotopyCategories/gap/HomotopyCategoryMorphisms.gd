#
# HomotopyCategories: Homotopy categories of additive categories
#
# Declarations
#
#
#####################################################################


DeclareCategory( "IsHomotopyCategoryMorphism",
                 IsHomotopyCategoryCell and IsStableCategoryMorphism );

DeclareOperation( "HomotopyCategoryMorphism",
            [ IsHomotopyCategory, IsChainOrCochainMorphism ] );

DeclareOperation( "HomotopyCategoryMorphism",
            [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsList, IsInt ] );

DeclareOperation( "HomotopyCategoryMorphism",
            [ IsHomotopyCategoryObject, IsList, IsInt, IsHomotopyCategoryObject ] );

DeclareOperation( "HomotopyCategoryMorphism",
            [ IsHomotopyCategoryObject, IsHomotopyCategoryObject, IsZFunction ] );

DeclareOperation( "HomotopyCategoryMorphism",
            [ IsHomotopyCategoryObject, IsZFunction, IsHomotopyCategoryObject ] );


DeclareOperation( "\[\]",
            [ IsHomotopyCategoryMorphism, IsInt ] );

DeclareAttribute( "AsChainMorphism", IsHomotopyCategoryMorphism );

DeclareAttribute( "AsCochainMorphism", IsHomotopyCategoryMorphism );

DeclareProperty( "IsQuasiIsomorphism", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "MappingCone", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "NaturalInjectionInMappingCone", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "NaturalProjectionFromMappingCone", IsHomotopyCategoryMorphism );

##
DeclareAttribute( "HomotopyMorphisms", IsChainComplex );

##
DeclareOperation( "MappingConeColift", [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ] );

##
DeclareOperation( "MappingConePseudoFunctorial",
    [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism ] );

DeclareOperation( "BoxProduct",
    [ IsHomotopyCategoryMorphism, IsHomotopyCategoryMorphism, IsCapCategory ] );

DeclareOperation( "ViewHomotopyCategoryMorphism",
            [ IsHomotopyCategoryMorphism ] );

DeclareOperation( "LaTeXStringOp", [ IsHomotopyCategoryCell ] );
