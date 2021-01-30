//
//  ProductConstant.swift
//  GoJekShop
//
//  Created by Sudar on 07/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import UIKit

enum ProductConstant {
    
    //Viewcontroller Identifier
    static let VDishViewController  = "DishViewController"
    static let VCreateAddonsController = "CreateAddonsController"
    static let VCreateProductController = "CreateProductController"
    static let VCreateCategoryController = "CreateCategoryController"
    static let VAddonsListController = "AddonsListController"
    static let VProductListController = "ProductListController"
    static let VCategoryListController = "CategoryListController"
    static let VCategoryViewController = "CategoryViewController"
    static let VSelectAddonsViewController = "SelectAddonsViewController"
    
    static let TDishTableViewCell = "DishTableViewCell"
    static let TAddOnsListTableViewCell = "AddOnsListTableViewCell"
    static let TAddCategoryTableViewCell =
    "AddCategoryTableViewCell"
    static let PromoCell = "PromoCell"
    static let TSelectAddonsTableViewCell = "SelectAddonsTableViewCell"
    
    //string
    static let TProduct = "Product"
    static let TAddons = "Addons"
    static let TCategory = "Category"
    static let TDish = "Dishes"
    static let TItems = "Items"
    static let price = "Price"
    static let userLimit = "User Limit"
    static let discountType = "Discount Type"
    static let expiration = "Expiration"
    static let discount = "Discount"
    static let quantity = "Quantity"
    static let percentage = "Percentage"
    static let unit = "Unit"
    static let selectAddons = "Select Addons"
    static let noAddonsListEmpty = "No Addons found"
    static let noproductsListEmpty = "No Products found"
    static let addAddons = "Add Addons"
    static let addCategory = "Add Categories"
    static let enterAddonName = "Enter Addons name"
    static let addonsList = "Addons List"
    static let createAddons = "Create Addons"
    static let addonsSuccess = "Addons added sucessfully"
    static let addonsDelete = "Are you sure want to delete Addons?"
    static let categoryDelete = "Are you sure want to delete Category?"

    static let productDelete = "Are you sure want to delete Product?"
    static let promoDelete = "Are you sure want to delete PromoCode?"
    static let categoryList = "Category List"
    static let noCategoryListEmpty = "No Category List found"
    static let description = "Description"
    static let productCuisine = "Product Cuisine"
    static let status = "Status"
    static let productOrder = "Product Order"
    static let category = "Category"
    static let minAmount = "Min Amount"
    static let maxAmount = "Max Amount"
    static let eligibility = "Eligibility"
    static let addProduct = "Add Products"
    static let productList = "Product List"
    static let imageUpload = "Image Upload"
    static let uploadImage = "Upload Image"
    static let imageFormat = "You can upload png format"
    static let nameEmpty = "Please enter Name"
    static let promoEmpty = "Please enter promoCode"
    static let descriptionEmpty = "Please enter Description"
    static let categoryOrderEmpty = "Please enter Category Order"
    static let categoryEmpty = "Please enter Category"
    static let percentageEmpty = "Please enter Percentage"
    
    static let minEmpty = "Please enter minimum Amount"
    static let expirationEmpty = "Please enter Expiration"
    static let maxEmpty = "Please enter maximum Amount"

    
    static let discountEmpty = "Please enter Discount Price"
    static let discountTypeEmpty = "Please enter Discount Type"
    static let AddonsEmpty = "Please select Addons"
    static let availablity = "Availablity"

    static let statusEmpty = "Please enter Status"
    static let userLimitEmpty = "Please enter user Limit"

    static let createCategory = "Create Category"
    static let categoryOrder = "Category Order"
    static let createProduct = "Create Product"
    static let createPromo = "Create PromoCode"

    static let categoryImageEmpty = "Please upload Category Image"
    static let priceEmpty = "Please enter the price"
    static let qtyEmpty = "Please enter the quantity"
    static let unitEmpty = "Please select the unit"
    static let addons = "Addons"
    static let productImageEmpty = "Please upload product image"
    static let promoImageEmpty = "Please upload promo image"
    static let productEmpty = "Product Created Sucessfully"
    static let promoAddSuccess = "PromoCode Created Sucessfully"
    static let promoEditSuccess = "PromoCode Changed Sucessfully"

    //Parameters
    static let PId = "id"
    static let PLimit = "limit"
    static let POffset = "offset"
    static let hash = "/"
    static let PaddonName = "addon_name"
    static let Pmethod = "_method"
    static let PaddonStatus = "addon_status"
    static let PStoreId = "store_id"
    static let PStore_category_name = "store_category_name"
    static let PStore_category_description = "store_category_description"
    static let PStore_category_status = "store_category_status"
    static let PPicture = "picture"
    static let PItemName = "item_name"
    
    static let Ppromo_code = "promo_code"
    static let P_method = "_method"
    static let Pservice = "service"
    static let Peligibility = "eligibility"
    static let Ppercentage = "percentage"
    static let Pmin_amount = "min_amount"
    static let Pmax_amount = "max_amount"
    static let Ppromo_description = "promo_description"
    static let Pexpiration = "expiration"
    static let Puser_limit = "user_limit"

    static let PItemDescription = "item_description"
    static let PStoreCategory_id = "store_category_id"
    static let PIsVeg = "is_veg"
    static let PItemPrice = "item_price"
    static let PItemDiscount = "item_discount"
    static let PItemDiscountType = "item_discount_type"
    static let PStatus = "status"
    static let PAddonPrice = "addon_price"
    static let PAddon = "addon"
    static let PPatch = "PATCH"
    static let PPage = "page"
    static let PUnit = "unit"
    static let PQty = "quantity"
    static let PLowStock = "low_stock"
    
    
    //Images
    static let noAddonsList = "ic_no_notification"
    static let dummy = "dummy"
    static let ic_Product_upload = "Product_upload"
    static let ic_plus = "plus"
}

//MARK:- isVegorNonVeg

enum isVegorNonVeg: String {
    case pureVeg = "Pure Veg"
    case nonVeg = "Non Veg"
}

//MARK:- ProductAPI

enum ProductAPI{
    
    static let addonsList = "/shop/addon"
    static let productList = "/shop/itemsindex"
    static let categoryIndex = "/shop/categoryindex"
    static let addAddons = "/shop/addons"
    static let product = "/shop/items"
    static let promo = "/shop/promocode"
    static let category = "/shop/category"
    static let selectAddons = "/shop/addonslist"
    static let unitList = "/shop/units"
    
}
