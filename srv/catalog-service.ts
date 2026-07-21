import cds from '@sap/cds';

class CatalogService extends cds.ApplicationService {
    init() {
        this.before('CREATE', 'ProductCondiments', async (req) => {
            const { product_ID, condiment_ID } = req.data;
            const existingEntry = await SELECT.one.from('ProductCondiments').where({ product_ID, condiment_ID });
            if (existingEntry) {
                req.reject(409, `The condiment with '${condiment_ID}' is already associated with the product with ID '${product_ID}'.`);
            }
        });
        return super.init();
    }
}

export default CatalogService;