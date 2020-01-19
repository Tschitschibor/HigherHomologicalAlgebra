
DeclareOperation( "LiftInfos", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
DeclareOperation( "ColiftInfos", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareGlobalFunction( "Time" );

DeclareGlobalFunction( "CheckNaturality" );

DeclareGlobalFunction( "CheckFunctoriality" );

DeclareOperation( "FunctorFromLinearCategoryByTwoFunctions",
    [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsInt ] );

DeclareOperation( "FunctorFromLinearCategoryByTwoFunctions",
    [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction ] );

DeclareGlobalFunction( "DeactivateCachingForCertainOperations" );

DeclareOperation( "FinalizeCategory", [ IsCapCategory, IsBool ] );


