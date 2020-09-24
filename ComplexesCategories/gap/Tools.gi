#
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
DeclareGlobalVariable( "DISABLE_ALL_SANITY_CHECKS" );
DeclareGlobalVariable( "SWITCH_LOGIC_OFF" );
DeclareGlobalVariable( "DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS" );
DeclareGlobalVariable( "ENABLE_COLORS" );
DeclareGlobalVariable( "SET_OF_ALL_CREATED_FUNCTORS" );

MakeReadWriteGlobal( "DISABLE_ALL_SANITY_CHECKS" );
MakeReadWriteGlobal( "SWITCH_LOGIC_OFF" );
MakeReadWriteGlobal( "DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS" );
MakeReadWriteGlobal( "ENABLE_COLORS" );
MakeReadWriteGlobal( "SET_OF_ALL_CREATED_FUNCTORS" );

DISABLE_ALL_SANITY_CHECKS := false;
SWITCH_LOGIC_OFF := false;
ENABLE_COLORS := false;
DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS := [ ];
SET_OF_ALL_CREATED_FUNCTORS := [ ];


BindGlobal( "SET_SPECIAL_SETTINGS",
  function( )
    
    DISABLE_ALL_SANITY_CHECKS := true;
    
    SWITCH_LOGIC_OFF := true;
    
    ENABLE_COLORS := true;
    
    DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS := [ IsChainComplexCategory, IsCochainComplexCategory ];
   
    if IsBound( IsMatrixCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsMatrixCategory" ) );
    fi;
    
    if IsBound( IsHomotopyCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal(  "IsHomotopyCategory" ) );
    fi;
    
    if IsBound( IsAdditiveClosureCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsAdditiveClosureCategory" ) );
    fi;
    
    if IsBound( IsQuiverRowsCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsQuiverRepresentationCategory" ) );
    fi;
    
    if IsBound( IsAlgebroid ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsAlgebroid" ) );
    fi;
    
    if IsBound( IsQuiverRowsCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsQuiverRowsCategory" ) );
    fi;
    
    if IsBound( IsCapProductCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsCapProductCategory" ) );
    fi;
    
    if IsBound( IsCategoryOfGradedRows ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsCategoryOfGradedRows" ) );
    fi;
    
    if IsBound( IsFreydCategory ) then
      Add( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, ValueGlobal( "IsFreydCategory" ) );
    fi; 
       
end );

##########################
#
# Functors
#
##########################

##
InstallMethod( CapFunctor,
          [ IsString, IsList, IsCapCategory ],
          
  function( name, source_list, range )
    local o, F;
    
    o := ValueOption( "sko_hil_ene_pav_mne" );
    
    if o = false then
      TryNextMethod( );
    fi;
    
    F := CapFunctor( name, source_list, range : sko_hil_ene_pav_mne := false );
    
    Add( SET_OF_ALL_CREATED_FUNCTORS, F );
    
    return F;
    
end, 5000 );

##
InstallMethod( SetOfKnownFunctors,
          [ IsCapCategory, IsCapCategory ],
  { category_1, category_2 }
      -> Filtered( SET_OF_ALL_CREATED_FUNCTORS,
          F -> IsIdenticalObj( SourceOfFunctor( F ), category_1 ) and IsIdenticalObj( RangeOfFunctor( F ), category_2 ) )
);

##########################
#
# Real time
#
##########################

InstallGlobalFunction( Time,
  function( command, arguments )
    local output, t0, t1;
    
    if not IsList( arguments ) then
      
      return Time( command, [ arguments ] );
      
    fi;
    
    t0 := NanosecondsSinceEpoch( );
    
    output := CallFuncList( command, arguments );
    
    t1 := NanosecondsSinceEpoch( );
    
    Print( Float( ( t1 - t0 ) / 10^9 ), " Secs.\n" );
    
    return output;
    
end );

#########################
#
# View Obj
#
########################

##
InstallMethod( ViewCapCategoryCell,
          [ IsCapCategoryCell ],
          
  function( c )
    ViewObj( c );
end );

##
InstallMethod( DisplayCapCategoryCell,
          [ IsCapCategoryCell ],
          
  function( c )
    Display( c );
end );

#############################################
#
# Finalizing
#
#############################################

InstallMethod( Finalize,
          [ IsCapCategory ],
  function( category )
    local o;
    
    o := ValueOption( "ksl_iho_niv_aje_nde" );
    
    if o = false then
      TryNextMethod( );
    fi;
    
    Finalize( category: ksl_iho_niv_aje_nde := false );
    
    if DISABLE_ALL_SANITY_CHECKS then
      DisableSanityChecks( category );
    fi;
    
    if SWITCH_LOGIC_OFF then
      CapCategorySwitchLogicOff( category );
    fi;
    
    if ForAny( DISABLE_CACHING_FOR_CATEGORIES_WITH_THESE_FILTERS, func -> func( category ) ) then
      DeactivateCachingOfCategory( category );
    fi;
    
end, 5000 );

##
InstallMethod( FinalizeCategory,
          [ IsCapCategory, IsBool ],
  function( cat, bool )
    
    if bool then
      
      Finalize( cat );
      
    fi;
    
end );

################################################
#
# Caching, Sanity checks, Logic
#
################################################

##
InstallGlobalFunction( DeactivateCachingForCertainOperations,
  function( category, list_of_operations )
    local current_name;
    
    for current_name in list_of_operations do
      
      SetCaching( category, current_name, "none" );
      
    od;
    
end );

##
InstallGlobalFunction( ActivateCachingForCertainOperations,
  function( category, list_of_operations )
    local equality_operations, current_name;
    
    equality_operations := [
                  "IsEqualForMorphisms",
                  "IsEqualForObjects",
                  "IsEqualForMorphismsOnMor",
                  "IsEqualForCacheForMorphisms",
                  "IsEqualForCacheForObjects"
                  ];
                  
    list_of_operations := Concatenation( equality_operations, list_of_operations );
    
    for current_name in RecNames( category!.caches ) do
      
      if current_name in list_of_operations then
        
        continue;
        
      fi;
      
      SetCaching( category, current_name, "none" );
      
    od;
    
end );

##
InstallGlobalFunction( CurrentCaching,
  function( cat )
  
    return cat!.default_cache_type;
    
end );

###################################
#
# Colors
#
###################################

##
InstallGlobalFunction( RandomTextColor,
  function ( name )
    local colors, colors_in_name, pos;
    if ENABLE_COLORS <> true then
      return [ "", "" ];
    else
      colors := [ "\033[32m", "\033[33m", "\033[34m", "\033[35m" ];
      colors_in_name := List( colors, c -> PositionSublist( name, c ) );
      pos := Positions( colors_in_name, fail );
      if Size( pos ) = 1 then
        pos := [ ];
      fi;
      if not IsEmpty( pos ) then
        return [ colors[ Random( pos ) ], "\033[0m" ];
      else
        return [ colors[ Position( colors_in_name, Maximum( colors_in_name ) ) ], "\033[0m" ];
      fi;
    fi;
end );


##
InstallGlobalFunction( RandomBoldTextColor,
  function (  )
    if ENABLE_COLORS <> true then
      return [ "", "" ];
    else
      return [ Random( [ "\033[1m\033[31m" ] ), "\033[0m" ];
    fi;
end );

##
InstallGlobalFunction( RandomBackgroundColor,
  function (  )
    if ENABLE_COLORS <> true then
      return [ "", "" ];
    else
      return [ Random( [ "\033[43m", "\033[42m", "\033[44m", "\033[45m", "\033[46m" ] ), "\033[0m" ];
    fi;
end );

##
InstallGlobalFunction( CreateNameWithColorsForFunctor,
  function( name, source, range )
    local r;
    
    r := RandomBoldTextColor( );
    
    return Concatenation( name, r[ 1 ],  ":", r[ 2 ], "\n\n",
                          Name( source ), "\n", r[ 1 ],
                          "  |\n  V", r[ 2 ], "\n",
                          Name( range ), "\n" );
  
end );

###################################
#
# Functors
#
###################################

##
InstallMethod( CallFuncList,
          [ IsCapFunctor, IsList ],
  { F, a } -> ApplyFunctor( F, a[ 1 ] )
);

##
InstallGlobalFunction( CheckNaturality,
  function( eta, alpha )
    local S, R;
    
    S := Source( eta );
    
    R := Range( eta );
    
    return IsCongruentForMorphisms(
              PreCompose( ApplyFunctor( S, alpha ), ApplyNaturalTransformation( eta, Range( alpha ) ) ),
              PreCompose( ApplyNaturalTransformation( eta, Source( alpha ) ), ApplyFunctor( R, alpha ) )
            );
end );
  
##
InstallMethod( CallFuncList,
          [ IsCapNaturalTransformation, IsList ],
  { nat, a } -> ApplyNaturalTransformation( nat, a[ 1 ] )
);

##
InstallGlobalFunction( CheckFunctoriality,
  function( F, alpha, beta )
    local bool, source_cat;
          
    bool := IsCongruentForMorphisms(
            ApplyFunctor( F, PreCompose( alpha, beta ) ),
            PreCompose( ApplyFunctor( F, alpha ), ApplyFunctor( F, beta ) )
            );
    
    source_cat := SourceOfFunctor( F );
    
    if HasIsAbCategory( source_cat ) and IsAbCategory( source_cat ) then
      
      if IsZero( alpha ) or IsZero( beta ) then
        
        Info( InfoWarning, 1, "Be carefull: At least one of the morphisms is zero!" );
        
      fi;
      
    fi;
    
    return bool;
    
end );

##
InstallMethod( Display,
          [ IsCapFunctor ],
  function( F )
    
    Print( CreateNameWithColorsForFunctor( Name( F ), SourceOfFunctor( F ), RangeOfFunctor( F ) ) );
    
end );

## Try number 0
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsInt ],
  function( name, source_cat, range_cat, object_func, morphism_func, n )
    local source_ring, range_ring, conv, F;
    
    if n <> 0 then
      
      TryNextMethod( );
      
    fi;
    
    if not ( HasIsLinearCategoryOverCommutativeRing( source_cat )
        and IsLinearCategoryOverCommutativeRing( source_cat ) ) or
          not ( HasIsLinearCategoryOverCommutativeRing( range_cat )
            and IsLinearCategoryOverCommutativeRing( range_cat ) ) then
        Error( "Wrong input!\n" );
        
    fi;
    
    source_ring := CommutativeRingOfLinearCategory( source_cat );
    
    range_ring := CommutativeRingOfLinearCategory( range_cat );
    
    if not IsIdenticalObj( source_ring, range_ring ) then
       
      conv := a -> a / range_ring;
      
    else
      
      conv := IdFunc;
      
    fi;
 
    object_func := FunctionWithCache( object_func );
    #morphism_func := FunctionWithCache( morphism_func );
    
    F := CapFunctor( name, source_cat, range_cat );
    
    F!.ValuesForObjects := [ [ ], [ ] ];
    F!.ValuesForMorphisms := [ [ ], [ ] ];
    
    AddObjectFunction( F,
      function( a )
        local p, Fa;
        
        p := Position( F!.ValuesForObjects[ 1 ], a );
         
        if p = fail then
          
          Fa := object_func( a );
          
          Add( F!.ValuesForObjects[ 1 ], a );
          Add( F!.ValuesForObjects[ 2 ], Fa );
          
          return Fa;
          
        else
          
          return F!.ValuesForObjects[ 2 ][ p ];
          
        fi;
        
    end );
      
    AddMorphismFunction( F,
      function( s, alpha, r )
        local a, b, p, basis, images, coeffs, pos;
        
        a := Source( alpha );
        
        b := Range( alpha );
        
        p := Position( F!.ValuesForMorphisms[ 1 ], [ a, b ] );

        if p = fail then
          
          basis := BasisOfExternalHom( a, b );
          
          images := [ ];
          
          if not IsEmpty( basis ) then
            
            Info( InfoComplexesCategories, 3, "\033[5mApplying the functor on a basis with ", Size( basis ), " element(s) ...\033[0m" );
            
            images := List( basis, morphism_func );
            
            Info( InfoComplexesCategories, 3, "Done!" );
            
          fi;
          
          Add( F!.ValuesForMorphisms[ 1 ], [ a, b ] );
          
          Add( F!.ValuesForMorphisms[ 2 ], images );
          
        else
          
          images := F!.ValuesForMorphisms[ 2 ][ p ];
          
        fi; 
        
        if IsEmpty( images ) then
          
          return ZeroMorphism( s, r );
          
        fi;
        
        coeffs := CoefficientsOfMorphism( alpha );
        
        pos := PositionsProperty( coeffs, c -> not IsZero( c ) );
        
        if IsEmpty( pos ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          return List( coeffs{ pos }, conv ) * images{ pos };
          
        fi;
        
    end );
    
    DeactivateCachingObject( ObjectCache( F ) );
    
    DeactivateCachingObject( MorphismCache( F ) );
    
    return F;
    
end );

## Try number 1, better, you are wellcome to improve it.
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsInt ],
  function( name, source_cat, range_cat, object_func, morphism_func, n )
    local source_ring, range_ring, conv, cached_object_func, cached_morphism_func, F;
    
    if n <> 1 then
      
      TryNextMethod( );
      
    fi;
    
    if not ( HasIsLinearCategoryOverCommutativeRing( source_cat )
        and IsLinearCategoryOverCommutativeRing( source_cat ) ) or
          not ( HasIsLinearCategoryOverCommutativeRing( range_cat )
            and IsLinearCategoryOverCommutativeRing( range_cat ) ) then
        Error( "Wrong input!\n" );
        
    fi;
    
    source_ring := CommutativeRingOfLinearCategory( source_cat );
    
    range_ring := CommutativeRingOfLinearCategory( range_cat );
    
    if not IsIdenticalObj( source_ring, range_ring ) then
       
      conv := a -> a / range_ring;
      
    else
      
      conv := IdFunc;
      
    fi;
 
    cached_object_func := FunctionWithCache( object_func );
    
    cached_morphism_func := FunctionWithCache( morphism_func );
    
    F := CapFunctor( name, source_cat, range_cat );
    
    AddObjectFunction( F, cached_object_func );
      
    AddMorphismFunction( F,
      function( s, alpha, r )
        local a, b, basis, coeffs, pos;
        
        a := Source( alpha );
        
        b := Range( alpha );
        
        basis := BasisOfExternalHom( a, b );
        
        coeffs := CoefficientsOfMorphism( alpha );
        
        pos := PositionsProperty( coeffs, c -> not IsZero( c ) );
        
        if IsEmpty( pos ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          return List( coeffs{ pos }, conv ) * List( basis{ pos }, cached_morphism_func );
          
        fi;
        
    end );
    
    DeactivateCachingObject( ObjectCache( F ) );
    
    DeactivateCachingObject( MorphismCache( F ) );
    
    return F;
    
end );

##
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsInt ],
  function( name, source_cat, range_cat, object_func, morphism_func, n )
    local source_ring, range_ring, conv, cached_object_func, cached_morphism_func, F;
    
    if n <> 2 then
      
      TryNextMethod( );
      
    fi;
    
    if not ( HasIsLinearCategoryOverCommutativeRing( source_cat )
        and IsLinearCategoryOverCommutativeRing( source_cat ) ) or
          not ( HasIsLinearCategoryOverCommutativeRing( range_cat )
            and IsLinearCategoryOverCommutativeRing( range_cat ) ) then
        Error( "Wrong input!\n" );
        
    fi;
    
    source_ring := CommutativeRingOfLinearCategory( source_cat );
    
    range_ring := CommutativeRingOfLinearCategory( range_cat );
    
    if not IsIdenticalObj( source_ring, range_ring ) then
       
      conv := a -> a / range_ring;
      
    else
      
      conv := IdFunc;
      
    fi;
 
    cached_object_func := FunctionWithCache( object_func );
    
    cached_morphism_func := FunctionWithCache(
      function( alpha )
        local s, r;
        
        s := object_func( Source( alpha ) );
        
        r := object_func( Range( alpha ) );
        
        if HasIsZero( alpha ) and IsZero( alpha ) then
          
          return ZeroMorphism( s, r );
          
        elif IsIdenticalToZeroMorphism( alpha ) then
          
          return ZeroMorphism( s, r );
          
        elif IsIdenticalToIdentityMorphism( alpha ) then
          
          return IdentityMorphism( s );
          
        fi;
        
        Info( InfoComplexesCategories, 3, "\033[5mApplying ", name, " on a morphism ...\033[0m" );
        alpha := morphism_func( alpha );
        Info( InfoComplexesCategories, 3, "Done!" );
        
        return alpha;
        
      end );
   
    F := CapFunctor( name, source_cat, range_cat );
    
    AddObjectFunction( F, cached_object_func );
      
    AddMorphismFunction( F,
      function( s, alpha, r )
        local a, b, basis, coeffs, pos;
        
        a := Source( alpha );
        
        b := Range( alpha );
        
        basis := BasisOfExternalHom( a, b );
        
        coeffs := CoefficientsOfMorphism( alpha );
        
        pos := PositionsProperty( coeffs, c -> not IsZero( c ) );
        
        if IsEmpty( pos ) then
          
          return ZeroMorphism( s, r );
          
        else
          
          return List( coeffs{ pos }, conv ) * List( basis{ pos }, cached_morphism_func );
          
        fi;
        
    end );
    
    DeactivateCachingObject( ObjectCache( F ) );
    
    DeactivateCachingObject( MorphismCache( F ) );
    
    return F;
    
end );

##
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction, IsInt ],
  function( name, source_cat, range_cat, object_func, morphism_func, n )
    local source_ring, range_ring, conv, images_of_objects, images_of_morphisms, new_object_func, new_morphism_func, F;
    
    if n <> 3 then
      
      TryNextMethod( );
      
    fi;
    
    if not ( HasIsLinearCategoryOverCommutativeRing( source_cat )
        and IsLinearCategoryOverCommutativeRing( source_cat ) ) or
          not ( HasIsLinearCategoryOverCommutativeRing( range_cat )
            and IsLinearCategoryOverCommutativeRing( range_cat ) ) then
        Error( "Wrong input!\n" );
        
    fi;
    
    source_ring := CommutativeRingOfLinearCategory( source_cat );
    
    range_ring := CommutativeRingOfLinearCategory( range_cat );
    
    if not IsIdenticalObj( source_ring, range_ring ) then
      
      conv := a -> a / range_ring;
      
    else
      
      conv := IdFunc;
      
    fi;
    
    images_of_objects := [ [ ], [ ] ];
     
    new_object_func :=
      function( a )
        local p, image_a;
        
        p := Position( images_of_objects[ 1 ], a );
         
        if p = fail then
          
          image_a := object_func( a );
          
          Add( images_of_objects[ 1 ], a );
          
          Add( images_of_objects[ 2 ], image_a );
          
          return image_a;
          
        else
          
          return images_of_objects[ 2 ][ p ];
          
        fi;

      end;
    
    images_of_morphisms := [ [ ], [ ] ];
    
    new_morphism_func :=
      function( alpha )
        local s, r;
        
        s := new_object_func( Source( alpha ) );
        
        r := new_object_func( Range( alpha ) );
        
        if HasIsZero( alpha ) and IsZero( alpha ) then
          
          return ZeroMorphism( s, r );
          
        elif IsIdenticalToZeroMorphism( alpha ) then
          
          return ZeroMorphism( s, r );
          
        elif IsIdenticalToIdentityMorphism( alpha ) then
          
          return IdentityMorphism( s );
          
        fi;
         
        Info( InfoComplexesCategories, 3, "\033[5mApplying \033[0m", name, " on a morphism ..." );
        alpha := morphism_func( alpha );
        Info( InfoComplexesCategories, 3, "Done!" );
        
        return alpha;
        
      end;
     
    F := CapFunctor( name, source_cat, range_cat );
    
    AddObjectFunction( F, new_object_func );
      
    AddMorphismFunction( F,
      function( s, alpha, r )
        local a, b, p, basis, coeffs, pos, images, output;
        
        a := Source( alpha );
        
        b := Range( alpha );
        
        p := Position( images_of_morphisms[ 1 ], [ a, b ] );
        
        if p = fail then
          
          Add( images_of_morphisms[ 1 ], [ a, b ] );
          
          Add( images_of_morphisms[ 2 ], [ ] );
          
          p := Size( images_of_morphisms[ 1 ] );
          
        fi;
        
        basis := BasisOfExternalHom( a, b );
        
        if IsEmpty( basis ) then
          
          return ZeroMorphism( s, r );
          
        fi;
        
        coeffs := CoefficientsOfMorphismWithGivenBasisOfExternalHom( alpha, basis );
        
        pos := PositionsProperty( coeffs, c -> not IsZero( c ) );
        
        if IsEmpty( pos ) then
          
          return ZeroMorphism( s, r );
          
        fi;
        
        images :=
          List( pos,
            function( i )
            
              if not IsBound( images_of_morphisms[ 2 ][ p ][ i ] ) then
                 
                images_of_morphisms[ 2 ][ p ][ i ] := new_morphism_func( basis[ i ] );
                
              fi;
              
              return images_of_morphisms[ 2 ][ p ][ i ];
            
            end );
        
        output := List( coeffs{ pos }, conv ) * images;
               
        return output;
        
    end );
    
    F!.images_of_objects := images_of_objects;
    
    F!.images_of_morphisms := images_of_morphisms;
    
    DeactivateCachingObject( ObjectCache( F ) );
    
    DeactivateCachingObject( MorphismCache( F ) );
    
    return F;
    
end );

## Always pick the last version, which "should" be the best.
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction ],
  { name, source_cat, range_cat, object_func, morphism_func }
    -> FunctorFromLinearCategoryByTwoFunctions( name, source_cat, range_cat, object_func, morphism_func, 3 )
);

############################
#
# find weak kernel in verious categories
#
############################

##
InstallMethod( _WeakKernelEmbedding,
          [ IsCapCategoryMorphism ],
  function( alpha )
    local cat;
    
    cat := CapCategory( alpha );
    
    if CanCompute( cat, "KernelEmbedding" ) then
      return KernelEmbedding( alpha );
    else
      TryNextMethod( );
    fi;
  
end, 5000 );

###########################
#
# Other
#
##########################

##
InstallMethod( \.,
        [ IsChainComplexCategory, IsPosInt ],
   { C, string_as_int } -> ( UnderlyingCategory( C ).( NameRNam( string_as_int ) ) ) / C
);

##
InstallMethod( \.,
        [ IsCochainComplexCategory, IsPosInt ],
   { C, string_as_int } -> ( UnderlyingCategory( C ).( NameRNam( string_as_int ) ) ) / C
);

#########################
#
# LIST_OF_SYNONYMS
#
#########################

DeclareGlobalVariable( "LIST_OF_SYNONYMS_FOR_CAP_OPERATIONS" );
MakeReadWriteGlobal( "LIST_OF_SYNONYMS_FOR_CAP_OPERATIONS" );

LIST_OF_SYNONYMS_FOR_CAP_OPERATIONS :=
  [
    [ "id", IdentityMorphism ],
    [ "hom", HomStructure ],
    [ "bhom", BasisOfExternalHom ]
  ];

# (D)ECLARE the synonyms
#
BindGlobal( "DLIST_OF_SYNONYMS_FOR_CAP_OPERATIONS", 
  function( )
    local l;
    
    for l in LIST_OF_SYNONYMS_FOR_CAP_OPERATIONS do
      
      if not IsString( l[ 1 ] ) then
        
        Error( "The first entry of each list should be a string!" );
        
      elif not EvalString( Concatenation( "IsBound( ", l[ 1 ], ")" ) ) then
        
        DeclareSynonym( l[ 1 ], l[ 2 ] );
        
      fi;
      
    od;
    
end );

######################
#
# LaTeX
#
#####################

##
DeclareGlobalFunction( "ShowLaTeXString" );

##
InstallGlobalFunction( ShowLaTeXString,
  function( latex_string )
    local scale, dir, filename, string, file, x, str;
    
    scale := ValueOption( "ScaleBox" );
    
    if scale = fail then
      
      scale := "1";
      
    elif not IsString( scale ) then
      
      scale := String( scale );
      
    fi;
     
    dir := DirectoryTemporary();
    
    filename := Filename( dir, "main.tex" );
    
    string := Concatenation(
    """
\documentclass[12pt,makeidx]{amsbook}
\usepackage{mathtools}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{amsmath}
\usepackage[dvipsnames]{xcolor}
\setcounter{MaxMatrixCols}{100}
\begin{document}
\begin{center}
\scalebox{""",
scale,
"""}{$""",
    latex_string,
"""$}
\end{center}
\end{document}
"""
    );
    
    file := OutputTextFile( filename, true );
    
    SetPrintFormattingStatus( file, false );
    
    PrintTo( file, string );
    
    str := "";
    
    x := Process(
            dir,
            Filename( DirectoriesSystemPrograms(), "pdflatex" ),
            InputTextUser( ),
            OutputTextString( str, true ),
            [ "-halt-on-error", "main.tex" ]
          );
    
    if x <> 0 then
      
      Error( "Something went wrong!, please check the main.tex file at ", filename );
      
    elif Filename(DirectoriesSystemPrograms(), "xdg-open" ) <> fail then
      
      Exec( Concatenation( "xdg-open ", Filename( dir, "main.pdf" ), " &" ) );
      
    else
      
      Print( Filename( dir, "main.pdf" ) );
      
    fi;
    
    return;
    
end );

