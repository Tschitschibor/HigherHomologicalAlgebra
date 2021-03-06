# SPDX-License-Identifier: GPL-2.0-or-later
# ToolsForHigherHomologicalAlgebra: Tools for the Higher Homological Algebra project
#
# Implementations
#

MakeReadWriteGlobal( "ENABLE_COLORS" );
ENABLE_COLORS := false;

InstallValue( ALL_FUNCTORS_METHODS, [ ] );


##
InstallMethod( AddFunctor,
          [ IsObject, IsObject, IsFunction, IsFunction, IsString ],
          
  function( F1, F2, F3, F4, F5 )
    
    AddFunctor( [ F1, F2, F3, F4, F5 ] );
    
end );

##
InstallMethod( AddFunctor,
          [ IsDenseList ],
          
  function( F )
    
    if Size( F ) <> 5 then
      
      Error( "The list should contain 5 entries" );
      
    fi;
    
    if not F in ALL_FUNCTORS_METHODS then
      
      Add( ALL_FUNCTORS_METHODS, F );
      
    fi;
    
end );

InstallMethod( ExtendFunctorMethod,
          [ IsDenseList, IsFunction, IsFunction, IsFunction, IsString ],
          
  function( F, filter, underlying_category, functor_constructor, name )
    local E;
    
    E :=
      [
        filter,
        filter,
        { category_1, category_2 } ->
              F[1]( underlying_category( category_1 ) ) and
              F[2]( underlying_category( category_2 ) ) and
              F[3]( underlying_category( category_1 ), underlying_category( category_2 ) ),
        { category_1, category_2 } -> functor_constructor( F[ 4 ]( underlying_category( category_1 ), underlying_category( category_2 ) ) ),
        Concatenation( "The functor defined by applying ", name, " on (", F[ 5 ], ")" )
      ];
    
    AddFunctor( E );
    
    return E;
    
end );

##
InstallMethod( KnownFunctors,
          [ IsCapCategory, IsCapCategory ],
          
  function( category_1, category_2 )
    local positions, i;
    
    positions := PositionsProperty(
                    ALL_FUNCTORS_METHODS,
                    function( F )
                      return F[1]( category_1 ) and F[2]( category_2 ) and F[3]( category_1, category_2 );
                    end
                  );
                  
    for i in [ 1 .. Size( positions ) ] do
      
      Print( i, ": ", ALL_FUNCTORS_METHODS[ positions[ i ] ][ 5 ], "\n" );
      
    od;
    
end );

##
InstallMethod( Functor,
          [ IsCapCategory, IsCapCategory, IsInt ],
          
  function( category_1, category_2, n )
    local positions, i;
    
    positions := PositionsProperty(
                    ALL_FUNCTORS_METHODS,
                    F -> F[1]( category_1 ) and F[2]( category_2 ) and F[3]( category_1, category_2 )
                  );
                  
    if n > Size( positions ) then
      
      return fail;
      
    fi;
    
    return ALL_FUNCTORS_METHODS[ positions[ n ] ][ 4 ]( category_1, category_2 );
    
end );

AddFunctor(
    IsCapCategory,
    IsCapCategory,
    { category_1, category_2 } -> IsIdenticalObj( category_1, category_2 ),
    { category_1, category_2 } -> IdentityFunctor( category_1 ),
    "Identity endofunctor"
);

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
InstallGlobalFunction( CreateDisplayNameWithColorsForFunctor,
  function( name, source, range )
    local r;
    
    r := RandomBoldTextColor( );
    
    return Concatenation( name, r[ 1 ],  ":", r[ 2 ], "\n\n",
                          Name( source ), "\n", r[ 1 ],
                          "  |\n  V", r[ 2 ], "\n",
                          Name( range ), "\n" );
  
end );


##
InstallMethod( CallFuncList,
          [ IsCapFunctor, IsList ],
          
  { F, a } -> ApplyFunctor( F, a[ 1 ] )
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
InstallMethod( Display,
          [ IsCapFunctor ],
          
  function( F )
    
    Print( CreateDisplayNameWithColorsForFunctor( Name( F ), SourceOfFunctor( F ), RangeOfFunctor( F ) ) );
    
end );

##
InstallMethod( FunctorFromLinearCategoryByTwoFunctions,
          [ IsString, IsCapCategory, IsCapCategory, IsFunction, IsFunction ],
          
  function( name, source_cat, range_cat, object_func, morphism_func )
    local source_ring, range_ring, conv, images_of_objects, images_of_morphisms, new_object_func, new_morphism_func, F;
        
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
        
        alpha := morphism_func( alpha );
        
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
