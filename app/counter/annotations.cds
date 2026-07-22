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
    category @title: 'Category';
}



// Value help 
annotate service.Products with {
    name @(
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'Products',
            SearchSupported: true,
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: name,
                    ValueListProperty: 'name'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'price'
                }
            ]
        }
    );
        category @(
        Common.Text                    : category.name,
        Common.TextArrangement         : #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Categories',
            Label         : 'Categories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: category_ID,
                    ValueListProperty: 'ID'
                }
            ]
        }
    );

}

// Fiter bar - Category, display the category name instead of the ID
annotate service.Categories with {
    ID @(
        Common.Text           : name,
        Common.TextArrangement: #TextOnly
    );
    name @title: 'Category';
    description @title: 'Description';
}

annotate service.Categories with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: name },
        { $Type: 'UI.DataField', Value: description }
    ]
);


// List Report - Filter bar + table

annotate service.Products with @(
    UI.SelectionFields: [
        name, isAvailable, category_ID
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