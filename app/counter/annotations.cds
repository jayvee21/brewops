using CatalogService as service from '../../srv/catalog-service';

/**
 * Labels (define once, reused by every table/form below)
 */
annotate service.Products with {
    name @title: 'Product Name';
    description @title: 'Description';
    price @title: 'Price';
    imageUrl @title: 'Image URL';
    isAvailable @title: 'Available?';
}

annotate service.Categories with {
    name @title: 'Category';
    description @title: 'Description';
}


// List Report - Filter bar + table

annotate service.Products with @(
    UI.SelectionFields: [
        name, isAvailable, category.name
    ],
    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: category.name,
        },
        {
            $Type: 'UI.DataField',
            Value: price,
        },
        {
            $Type: 'UI.DataField',
            Value: isAvailable,
        }
    ]
);