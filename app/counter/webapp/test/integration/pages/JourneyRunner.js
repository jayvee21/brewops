sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"brewops/counter/test/integration/pages/ProductsList.gen",
	"brewops/counter/test/integration/pages/ProductsObjectPage.gen"
], function (JourneyRunner, ProductsListGenerated, ProductsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('brewops/counter') + '/test/flp.html#app-preview',
        pages: {
			onTheProductsListGenerated: ProductsListGenerated,
			onTheProductsObjectPageGenerated: ProductsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

