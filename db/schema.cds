namespace brewops;
using { cuid, managed } from '@sap/cds/common';

entity Categories : cuid, managed {
    name :  String(111);
    description : String(111);
    products : Association to many Products on products.category = $self;
}

entity Products : cuid, managed {
    name : String(1111);
    description : String(1000);
    price : Decimal(9,2);
    imageUrl: String(1111);
    category : Association to one Categories;
}