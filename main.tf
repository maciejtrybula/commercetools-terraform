terraform {
  required_providers {
    commercetools = {
      source = "labd/commercetools"
    }
  }
}

resource "commercetools_project_settings" "private-mt-project" {
  name = "Private project"
  countries = ["US", "PL"]
  currencies = ["EUR", "PLN"]
  languages = ["en", "pl"]
  messages = {
    enabled = true
  }
  carts = {
    country_tax_rate_fallback_enabled = true
  }
  shipping_rate_input_type = "CartClassification"

  shipping_rate_cart_classification_value {
    key = "Small"
    label = {
      "en" = "Small"
      "pl" = "Mały"
    }
  }
}

resource "commercetools_channel" "private-mt-project" {
  key = "polish-stock"
  roles = ["Primary"]
  name = {
    pl-PL = "Channel PL"
  }
  description = {
    pl-PL = "Channel for polish warehouse"
  }
}

resource "commercetools_tax_category" "standard" {
  name = "Vat 23% for polish products"
}

resource "commercetools_tax_category_rate" "standard-tax-category-PL" {
  tax_category_id   = commercetools_tax_category.standard.id
  name              = "23%"
  amount            = 0.23
  included_in_price = true
  country           = "PL"
}

resource "commercetools_tax_category_rate" "standard-tax-category-US-california" {
  tax_category_id   = commercetools_tax_category.standard.id
  name              = "7.75%"
  amount            = 0.775
  included_in_price = false
  country           = "US"
  state             = "California"
}

resource "commercetools_shipping_method" "standard" {
  name = "Post Office"
  key = "po"
  description = "Polish Post Office"
  is_default = false
  tax_category_id = commercetools_tax_category.standard.id
  predicate = "1 = 1"
}

resource "commercetools_shipping_zone" "pl" {
  name = "PL"
  description = "Poland"
  location {
    country = "PL"
  }
}

resource "commercetools_shipping_zone_rate" "standard-pl" {
  shipping_method_id = commercetools_shipping_method.standard.id
  shipping_zone_id   = commercetools_shipping_zone.pl.id

  price {
    cent_amount   = 1390
    currency_code = "PLN"
  }

  free_above {
    cent_amount   = 50000
    currency_code = "PLN"
  }
}

resource "commercetools_customer_group" "standard" {
  name = "Standard Customer Group"
  key  = "standard-customer-group"
}

resource "commercetools_product_type" "simple-product" {
  name = "Simple product"
  description = "Simple product with base attributes"

  attribute {
    name = "weight"
    label = {
      en = "Weight"
      pl = "Waga"
    }
    required = false
    type {
      name = "number"
    }
  }
}