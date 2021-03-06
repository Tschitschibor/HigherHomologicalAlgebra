# SPDX-License-Identifier: GPL-2.0-or-later
# DerivedCategories: Derived categories of Abelian categories
#
# Declarations
#
##
#! @Chapter Exceptional collections
#!
#############################################################################



####################################
##
#! @Section Constructors
##
####################################

#! @Description
#!  The GAP category of exceptional collections.
#! @Arguments object
#! @Returns true or false
DeclareCategory( "IsExceptionalCollection", IsObject );

#! @Description
#!  #TODO
#!  If the input is full subcategory <A>A</A> in some category <C>C</C>, generated by finite number of objects 
#!  <A>A!.Objects</A>, then the output is the strong exceptional collection defined by these objects.
#!  If the input is a list of objects <A>L</A> of objects in some category <C>C</C>, 
#!  then the output is <A>CreateExceptionalCollection( A )</A>, where <A>A := FullSubcategoryGeneratedByListOfObjects(C,L)</A>.
#! @Arguments full, vertices_labels, cache
#! @Returns IsExceptionalCollection
DeclareOperation( "CreateExceptionalCollection", [ IsCapFullSubcategory, IsList, IsString ] );

DeclareOperation( "CreateExceptionalCollection", [ IsCapFullSubcategory, IsList ] );

DeclareOperation( "CreateExceptionalCollection", [ IsCapFullSubcategory ] );

DeclareOperation( "CreateExceptionalCollection", [ IsList, IsList, IsString ] );

DeclareOperation( "CreateExceptionalCollection", [ IsList, IsList ] );

DeclareOperation( "CreateExceptionalCollection", [ IsList ] );

#! @Description
#!  If the input is full subcategory <A>A</A> in some category <C>C</C>, generated by finite number of objects 
#!  <A>A!.Objects</A>, then the output is the strong exceptional collection defined by these objects returned as
#!  an attribute for <A>A</A>.
#! @Arguments A
#! @Returns IsExceptionalCollection
DeclareAttribute( "ExceptionalCollection", IsCapFullSubcategory );

#! @Description
#!  Returns the full subcategory that is generated by the elements of the strong exceptional collection <A>E</A>.
#! @Arguments E
#! @Returns 
DeclareAttribute( "DefiningFullSubcategory", IsExceptionalCollection );

#! @Description
#!  Returns the ambient category of <C>DefiningFullSubcategory</C>(<A>E</A>).
#! @Arguments E
#! @Returns 
DeclareAttribute( "AmbientCategory", IsExceptionalCollection );

#! @Description
#!  Returns the endomorphism quiver algebra of the exceptional collection <A>E</A>.
#! @Arguments E
#! @Returns a quiver algebra
DeclareAttribute( "EndomorphismAlgebraAttr", IsExceptionalCollection );

#! @Description
#!  delegates to <C>EndomorphismAlgebraAttr</C>(<A>E</A>).
#! @Arguments E
#! @Returns a quiver algebra
DeclareOperation( "EndomorphismAlgebra", [ IsExceptionalCollection ] );

#! @Description
#!  Returns the exceptional collection that defines the quiver algebra <A>A</A>.
#! @Arguments A
#! @Returns an exceptional collection
DeclareAttribute( "DefiningExceptionalCollection", IsQuiverAlgebra );

#! @Description
#!  Returns the algebroid defined by the endomorphism quiver algebra of the exceptional collection <A>E</A>.
#! @Arguments E
#! @Returns an algebroid
DeclareAttribute( "Algebroid", IsExceptionalCollection );

#! @Description
#!  Returns the category of quiver rows over the endomorphism algebra of <A>E</A>.
#! @Arguments E
#! @Returns a category
DeclareAttribute( "QuiverRows", IsExceptionalCollection );

#! @Description
#!  Returns the direct sum of the objects of the exceptional collection <A>E</A>.
#! @Arguments E
#! @Returns an object
DeclareAttribute( "TiltingObject", IsExceptionalCollection );

#! @Description
#!  Returns the number of objects of the exceptional collection <A>E</A>.
#! @Arguments E
#! @Returns IsInt
DeclareAttribute( "NumberOfObjects", IsExceptionalCollection );

#! @Description
#!  Returns a list of the objects of the exceptional collection <A>E</A>.
#! @Arguments E
#! @Returns IsList
DeclareAttribute( "UnderlyingObjects", IsExceptionalCollection );

#! @Description
#!  Returns the additive closure of the <C>DefiningFullSubcategory</C>(<A>E</A>).
#! @Arguments E
#! @Returns an additive category
DeclareAttribute( "AdditiveClosure", IsExceptionalCollection );

#! @Description
#!  Returns the category of right quiver representations over the opposite algebra of the endomorphism algebra
#!  of the collection.
#! @Arguments E
#! @Returns an abelian category
DeclareAttribute( "CategoryOfQuiverRepresentationsOverOppositeAlgebra", IsExceptionalCollection );

#! @Description
#!  Returns the homotopy category of the additive closure of <C>DefiningFullSubcategory</C>(<A>E</A>).
#! @Arguments E
#! @Returns a category
#DeclareOperation( "HomotopyCategory", [ IsExceptionalCollection ] );

#DeclareOperation( "HomotopyCategory", [ IsExceptionalCollection, IsBool ] );

#! @Description
#!  Returns the additive closure of the <C>DefiningFullSubcategory</C>(<A>E</A>) as an additive
#!  full subcategory in <C>AmbientCategory</C>(<A>E</A>).
#! @Arguments E
#! @Returns an additive category
DeclareAttribute( "AdditiveClosureAsFullSubcategory", IsExceptionalCollection );

#! @Description
#!  Returns the embedding functor of <C>DefiningFullSubcategory</C>(<A>E</A>) in <C>TiltingObjectAsCategory</C>(<A>E</A>).
#! @Arguments E
#! @Returns a functor
DeclareOperation( "InterpretMorphismInExceptionalCollectionAsEndomorphismOfTiltingObject",
    [ IsExceptionalCollection, IsCapCategoryMorphismInAFullSubcategory ] );

#! @Description
#!  Returns the $i$'th object in <A>E</A>.
#! @Arguments E, i
#! @Returns an object
DeclareOperation( "\[\]", [ IsExceptionalCollection, IsInt ] );

#! @Description
#!  Returns a generating set for the vector space of morphisms from $E_i$ to $E_j$ that can be factored
#!  along at least one object $E_l$ in $E$ with $i+1\leq l\leq j-1$.
#! @Arguments E, i, j
#! @Returns IsList
KeyDependentOperation( "PathsOfLengthGreaterThanOne", IsExceptionalCollection, IsList, ReturnTrue );

#! @Description
#!  Returns a basis for a complementing vector space in Hom$(E_i,E_j)$ to the vector space
#!  generated by <C>PathsOfLengthGreaterThanOne</C>$(E,i,j)$.
#! @Arguments E, i, j
#! @Returns IsList
KeyDependentOperation( "PathsOfLengthOne", IsExceptionalCollection, IsList, ReturnTrue );

#! @Description
#!  Delegates to <C>PathsOfLengthOne</C>$(E,[i,j])$.
#! @Arguments E, i, j
#! @Returns IsList
DeclareOperation( "Arrows", [ IsExceptionalCollection, IsInt, IsInt ] );

#! @Description
#!  It returns the union of <C>PathsOfLengthOne</C> and <C>PathsOfLengthGreaterThanOne</C> applied
#!  on the same arguments. In other words it returns a generating set for the vector space Hom$(E_i,E_j)$.
#! @Arguments E, i, j
#! @Returns IsList
KeyDependentOperation( "AllPaths", IsExceptionalCollection, IsList, ReturnTrue );

#! @Description
#!  It returns a basis for Hom$(E_i,E_j)$ which cosists only from paths.
#! @Arguments E, i, j
#! @Returns IsList
KeyDependentOperation( "BasisOfPaths", IsExceptionalCollection, IsList, ReturnTrue );

#! @Description
#!  It returns labels for <C>PathsOfLengthOne</C>$(E,i,j)$. A label for path of length one
#!  gives information about the source, target and position of the path.
#! @Arguments E, i, j
#! @Returns IsList
KeyDependentOperation( "LabelsForPathsOfLengthOne", IsExceptionalCollection, IsList, ReturnTrue );

#! @Description
#!  It returns labels for <C>PathsOfLengthGreaterThanOne</C>$(E,i,j)$
#!  A label for a path of length greater than one gives information about the labels of the arrows
#!  whose composition is the path.
#! @Arguments E, i, j
#! @Returns a list of lists
KeyDependentOperation( "LabelsForPathsOfLengthGreaterThanOne", IsExceptionalCollection, IsList, ReturnTrue );

#! @Description
#!  It returns labels for <C>AllPaths</C>$(E,i,j)$.
#! @Arguments E, i, j
#! @Returns a list of lists
KeyDependentOperation( "LabelsForAllPaths", IsExceptionalCollection, IsList, ReturnTrue );

#! @Description
#!  It returns labels for <C>BasisOfPaths</C>$(E,i,j)$.
#! @Arguments E, i, j
#! @Returns a list of lists
KeyDependentOperation( "LabelsForBasisOfPaths", IsExceptionalCollection, IsList, ReturnTrue );

####################################
##
#! @Section General Operations
##
####################################

#! @Description
#!  The arguments are two objects <A>A</A>, <A>B</A> and a list of morphisms <A>L</A>$:=(f_i:A\to B)$ for $i=1,\dots,n$ that live in
#!  a category equipped with homomorphism structure $(1,H(-,-),\nu)$. The output is
#!  the morphism $\langle \nu(f_1),\nu(f_2),\dots,\nu(f_n)\rangle:\oplus_{i=1}^n 1 \to H(A,B)$.
#! @Arguments A, B, L
#! @Returns a morphism in range category of homomorphism structure
DeclareOperation( "InterpretListOfMorphismsAsOneMorphismInRangeCategoryOfHomomorphismStructure",
    [ IsCapCategoryObject, IsCapCategoryObject, IsList ] );

#! @Description
#!  The arguments are a field <A>F</A> and three non-negative integers <A>m</A>, <A>n</A> and <A>r</A>
#!  It returns a quiver algebra with <A>m</A> vertices, <A>n</A> arrows and at most <A>r</A> relations; and whose indecomposable 
#!  projective or injective objects define an exceptional collection.
#! @Arguments F, m, n, r
#! @Returns a quiver path algebra
DeclareGlobalFunction( "RandomQuiverAlgebraWhoseIndecProjectiveRepsAreExceptionalCollection" );


DeclareOperation( "BoxProduct",
    [ IsExceptionalCollection, IsExceptionalCollection, IsCapCategory ]
);

DeclareOperation( "EndomorphismAlgebra",
    [ IsExceptionalCollection, IsField ] );


#! @Description
#!  The argument is a list of morphism <A>L</A> in some $k$-linear category equipped with homomorphism structure.
#!  The output is the relations between the morphisms.
#! @Arguments L
#! @Returns a list of ring elements
DeclareGlobalFunction( "RelationsBetweenMorphisms" );

#TODO Please find another place for this!
##
#! @Description
#!  The argument is an abelian category <A>C</A> with enouph projectives. The output the full subcategory
#!  generated by projective objects in <A>C</A>.
#! @Arguments cat
#! @Returns a full subcategory
DeclareAttribute( "FullSubcategoryGeneratedByProjectiveObjects", IsCapCategory );

##
#! @Description
#!  The argument is an abelian category <A>C</A> with enouph injectives. The output the full subcategory
#!  generated by injective objects in <A>C</A>.
#! @Arguments cat
#! @Returns a full subcategory
DeclareAttribute( "FullSubcategoryGeneratedByInjectiveObjects", IsCapCategory );

#! @Description
#!  The argument is a category of quiver representations over some finite dimensional quiver algebra or
#!  a category of functors into a matrix category of some homalg field.
#!  The output the full subcategory generated by the indecomposable projective objects.
#! @Arguments cat
#! @Returns a full subcategory
DeclareAttribute( "FullSubcategoryGeneratedByIndecProjectiveObjects",
        IsCapCategory );

#! @Description
#!  The argument is a category of quiver representations over some finite dimensional quiver algebra or
#!  a category of functors into a matrix category of some homalg field.
#!  The output the full subcategory generated by the indecomposable injectives objects.
#! @Arguments cat
#! @Returns a full subcategory
DeclareAttribute( "FullSubcategoryGeneratedByIndecInjectiveObjects",
        IsCapCategory );

#! @Description
#!  The argument is an algebroid <A>algebroid</A> over some algebra $A$. The output is
#! <C>FullSubcategoryGeneratedByIndecProjectiveObjects</C>($A^{op}$).
#! @Arguments algebroid
#! @Returns a full subcategory
DeclareAttribute( "FullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra",
        IsAlgebroid );

#! @Description
#!  The argument is an exceptional collection <A>E</A>. The output is
#!  <C>FullSubcategoryGeneratedByIndecProjectiveObjects</C>($A^{op}$) where $A$
#!  is the endomorphism algebra of the exceptional collection.
#! @Arguments E
#! @Returns a full subcategory
DeclareAttribute( "FullSubcategoryGeneratedByIndecProjRepresentationsOverOppositeAlgebra",
        IsExceptionalCollection );


#! @Description
#!  The argument is a non-additive full subcategory <A>full</A> whose ambient category $C$ is additive.
#!  The output is an additive full subcategory of $C$ generated by all direct sums of objects in <A>full</A>.
#! @Arguments full
#! @Returns an additive full subcategory
DeclareAttribute( "AdditiveClosureAsFullSubcategory",
        IsCapFullSubcategory );

