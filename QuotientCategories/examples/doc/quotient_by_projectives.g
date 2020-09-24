# This example contains a function is_equivalent_morphisms which can not be displayed nicely using the
# standard way of inserting examples, hence this way.

#! @Chunk abelian_groups
#! @BeginExampleSession
#! gap> LoadPackage( "ModulePresentations" );
#! true
#! gap> LoadPackage( "QuotientCategories" );
#! true
#! gap> ZZ := HomalgRingOfIntegers( );
#! Z
#! gap> cat := LeftPresentations( ZZ );
#! Category of left presentations of Z
#! gap> is_equivalent_morphisms :=
#!        function( alpha, beta )
#!          local epi;
#!
#!          if not IsEqualForObjects( Source( alpha ), Source( beta ) ) or
#!               not IsEqualForObjects( Range( alpha ), Range( beta ) ) then
#!                 Error( "Wrong input for the test function!" );
#!          fi;
#!          
#!          epi := EpimorphismFromSomeProjectiveObject( Range( alpha ) );
#!
#!          return Lift( alpha - beta, epi ) <> fail;
#!          
#!      end;;
#! gap> quotient_cat := QuotientCategory( cat, is_equivalent_morphisms );
#! The Quotient category of Category of left presentations of Z by 
#! is_equivalent_morphisms
#! gap> F := Projection( quotient_cat );
#! Canonical projection functor from Category of left presentations of Z in 
#! The Quotient category of Category of left presentations of Z by 
#! is_equivalent_morphisms
#! gap> a := FreeLeftPresentation( 3, ZZ );
#! <An object in Category of left presentations of Z>
#! gap> quotient_a := ApplyFunctor( F, a );
#! <An object in The Quotient category of Category of left presentations of Z by 
#! is_equivalent_morphisms>
#! gap> IsZero( quotient_a );
#! true
#! @EndExampleSession
#! @EndChunk
