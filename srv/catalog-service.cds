using { brewops as db } from '../db/schema';


service CatalogService @(path: '/catalog') {
    @restrict: [
        { grant: 'READ', to: ['Employee', 'InventoryManager', 'Manager'] },
        { grant: ['UPDATE', 'CREATE'], to: ['InventoryManager', 'Manager'] },
        { grant: 'DELETE', to: ['Manager'] }
    ]
    entity Categories as projection on db.Categories;
    @restrict: [
        { grant: 'READ', to: ['Employee', 'InventoryManager', 'Manager'] },
        { grant: ['UPDATE', 'CREATE'], to: ['InventoryManager', 'Manager'] },
        { grant: 'DELETE', to: ['Manager'] }
    ]
    entity Products as projection on db.Products;

    @restrict: [
        { grant: 'READ', to: ['Employee', 'InventoryManager', 'Manager'] },
        { grant: ['UPDATE', 'CREATE'], to: ['InventoryManager', 'Manager'] },
        { grant: 'DELETE', to: ['Manager'] }
    ]
    entity UnitOfMeasures as projection on db.UnitOfMeasures;

    @restrict: [
        { grant: 'READ', to: ['Employee', 'InventoryManager', 'Manager'] },
        { grant: ['UPDATE', 'CREATE'], to: ['InventoryManager', 'Manager'] },
        { grant: 'DELETE', to: ['Manager'] }
    ]
    entity Condiments as projection on db.Condiments;
}