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
            Criticality: availabilityCriticality
        }
    ]
);

// Product grouping
annotate service.Products with @(
    UI.PresentationVariant: {
        $Type : 'UI.PresentationVariantType',
        GroupBy: [category.name],
        SortOrder: [
            { $Type: 'Common.SortOrderType', Property: category.name },
            { $Type: 'Common.SortOrderType', Property: name },
        ],
        Visualizations: ['@UI.LineItem']
    }
);

// ---------- Labels for the object page tables ------------
annotate service.Condiments with {
    name @title: 'Ingredient';
    variety @title: 'Variety';
}

annotate service.ProductCondiments with {
    quantity @title: 'Quantity';
}

annotate service.InstructionSteps with {
    stepNumber @title: 'Step';
    instruction @title: 'Instruction';
}

annotate service.Products with {
    availabilityCriticality @UI.Hidden;
}

// ----------- Object Page -----------
annotate service.Products with @(
    UI.HeaderInfo: {
        $Type: 'UI.HeaderInfoType',
        TypeName: 'Product',
        TypeNamePlural: 'Menu',
        Title: { $Type: 'UI.DataField', Value: name },
        Description: { $Type: 'UI.DataField', Value: category.name },
        ImageUrl: imageUrl
    },

    UI.FieldGroup #Details: {
        $Type: 'UI.FieldGroupType',
        Data : [
            { $Type: 'UI.DataField', Value: description },
            { $Type: 'UI.DataField', Value: price },
            { $Type: 'UI.DataField', Value: category_ID },
            { $Type: 'UI.DataField', Value: isAvailable, Criticality: availabilityCriticality },
        ]
    },

    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'DetailsFacet', Label: 'Details', Target: '@UI.FieldGroup#Details' },
        { $Type: 'UI.ReferenceFacet', ID: 'RecipeFacet', Label: 'Recipe', Target: 'productCondiments/@UI.LineItem' },
        { $Type: 'UI.ReferenceFacet', ID: 'StepsFacet', Label: 'Preparation', Target: 'instructionSteps/@UI.PresentationVariant' },
    ]
);

// ---------- B004: recipe lines (no cost fields — Employee-visible) ----------
annotate service.ProductCondiments with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: condiment.name },
        { $Type: 'UI.DataField', Value: condiment.variety },
        { $Type: 'UI.DataField', Value: quantity }
    ]
);

// ---------- B005: instruction steps ----------
annotate service.InstructionSteps with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: stepNumber },
        { $Type: 'UI.DataField', Value: instruction }
    ],
    UI.PresentationVariant: {
        $Type         : 'UI.PresentationVariantType',
        SortOrder     : [ { $Type: 'Common.SortOrderType', Property: stepNumber } ],
        Visualizations: [ '@UI.LineItem' ]
    }
);