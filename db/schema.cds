namespace brewops;
using { cuid, managed, sap.common.CodeList} from '@sap/cds/common';

entity Categories : cuid, managed {
    name :  String(111);
    description : String(111);
    products : Association to many Products on products.category = $self;
}

entity Products : cuid, managed {
    name : String(200);
    description : String(200);
    price : Decimal(9,2);
    imageUrl: String(200);
    isAvailable : Boolean default true;
    category : Association to one Categories;
    productCondiments : Composition of many ProductCondiments on productCondiments.product = $self;
    instructionSteps : Composition of many InstructionSteps on instructionSteps.product = $self;
}

entity UnitOfMeasures : CodeList {
    key code : String(10);
}

@assert.unique.oneVarietyPerCondiment : [name, variety]
entity Condiments : cuid, managed {
    name : String(111);
    variety :String(111);
    unitOfMeasure : Association to one UnitOfMeasures;
    costPerUnit : Decimal(9, 4);
    isAvailable : Boolean default true;
}

@assert.unique.oneLinePerCondiment : [product, condiment]
entity ProductCondiments : cuid, managed {
    product : Association to one Products;
    condiment: Association to one Condiments;
    quantity : Decimal(7,2);
    lineCost : Decimal(11,4) = quantity * condiment.costPerUnit;
}

@assert.unique.oneStepPerNumber : [product, stepNumber]
entity InstructionSteps : cuid, managed {
    product : Association to one Products;
    stepNumber: Integer;
    instruction : String(5000);
}