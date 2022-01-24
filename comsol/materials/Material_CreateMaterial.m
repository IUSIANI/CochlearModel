function model  = Material_CreateMaterial(model, meanMaterialConductivity)
    fprintf('\t[-] Editing materials.\n');
    
    model.component('comp1').material.create('mat1', 'Common');
    model.component('comp1').material('mat1').selection.set([1]);
    model.component('comp1').material('mat1').label('Hueso promedio');
    model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {num2str(meanMaterialConductivity) '0' '0' '0' num2str(meanMaterialConductivity) '0' '0' '0' num2str(meanMaterialConductivity)});
    model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
    model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity_symmetry', '0');

    model.component('comp1').material.create('mat3', 'Common');
    model.component('comp1').material('mat3').selection.set([3]);
    model.component('comp1').material('mat3').label('endolinfa');
    model.component('comp1').material('mat3').propertyGroup('def').set('electricconductivity', {'0.67' '0' '0' '0' '0.67' '0' '0' '0' '0.67'});
    model.component('comp1').material('mat3').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
    model.component('comp1').material('mat3').propertyGroup('def').set('electricconductivity_symmetry', '0');

    model.component('comp1').material.create('mat4', 'Common');
    model.component('comp1').material('mat4').selection.set([4]);
    model.component('comp1').material('mat4').label('Organo de Corti');
    model.component('comp1').material('mat4').propertyGroup('def').set('electricconductivity', {'0.012' '0' '0' '0' '0.012' '0' '0' '0' '0.012'});
    model.component('comp1').material('mat4').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
    model.component('comp1').material('mat4').propertyGroup('def').set('electricconductivity_symmetry', '0');

    model.component('comp1').material.create('mat5', 'Common');
    model.component('comp1').material('mat5').selection.set([7]);
    model.component('comp1').material('mat5').label('Nervio');
    model.component('comp1').material('mat5').propertyGroup('def').set('electricconductivity', {'0.3' '0' '0' '0' '0.3' '0' '0' '0' '0.3'});
    model.component('comp1').material('mat5').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
    model.component('comp1').material('mat5').propertyGroup('def').set('electricconductivity_symmetry', '0');

    model.component('comp1').material.create('mat7', 'Common');
    model.component('comp1').material('mat7').selection.set([2 5]);
    model.component('comp1').material('mat7').label('Perilinfa');
    model.component('comp1').material('mat7').propertyGroup('def').set('electricconductivity', {'1.42' '0' '0' '0' '1.42' '0' '0' '0' '1.42'});
    model.component('comp1').material('mat7').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
    model.component('comp1').material('mat7').propertyGroup('def').set('electricconductivity_symmetry', '0');

    model.component('comp1').material.create('mat9', 'Common');
    model.component('comp1').material('mat9').selection.set([6]);
    %disp("ojo, se han cambiado las conductividades, antes estaba en 0.2")
    model.component('comp1').material('mat9').label('Hueso entre nervio y escalas');
    model.component('comp1').material('mat9').propertyGroup('def').label(['B' native2unicode(hex2dec({'00' 'e1'}), 'unicode') 'sico']);
    model.component('comp1').material('mat9').propertyGroup('def').set('electricconductivity', {'.2' '0' '0' '0' '.2' '0' '0' '0' '.2'});
    model.component('comp1').material('mat9').propertyGroup('def').set('electricconductivity_symmetry', '0');
    model.component('comp1').material('mat9').propertyGroup('def').set('relpermittivity', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
    model.component('comp1').material('mat9').propertyGroup('def').set('relpermittivity_symmetry', '0');    
end
