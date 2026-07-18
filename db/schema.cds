namespace brewops;
using { cuid, managed } from '@sap/cds/common';

entity Categories : cuid, managed {
    name :  String(111);
    description : String(111);
}