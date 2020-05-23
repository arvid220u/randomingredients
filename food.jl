using DataFrames
using CSV

products = CSV.read("instacart-market-basket-analysis/products.csv");
departments = CSV.read("instacart-market-basket-analysis/departments.csv");
aisles = CSV.read("instacart-market-basket-analysis/aisles.csv");

function get_department_id(category_string) 
    return departments[departments.department .== category_string, :department_id][1]
end
function get_products_in_department(department) 
    products[products.department_id .== get_department_id(department), :]
end

excluded_departments = ["frozen", 
    "pets", "personal care", "meat seafood", "household", "babies"];

included_products = products[
    indexin(products.department_id, 
        [get_department_id(x) for x in excluded_departments]) .== nothing, 
    :];

function get_random_product(products)
    maxvalue = size(products)[1]
    return products[rand(1:maxvalue), :]
end

function get_random_products(products, N)
    return DataFrame([get_random_product(products) for i in 1:N])
end

essential_departments = ["produce", 
    "dry goods pasta", "dairy eggs", "canned goods"]

essential_products = products[
    indexin(products.department_id, 
        [get_department_id(x) for x in essential_departments]) .!= nothing, 
    :];

only_produce = ["produce"]

produce_products = products[
    indexin(products.department_id, 
        [get_department_id(x) for x in only_produce]) .!= nothing, 
    :];

println("Congratulations on yet another day of doing the #randomcookingchallenge!")
println("")

println("""RULES:
    1. You get two options. Choose one.
    2. Each option has 7 ingredients. You need to include at least 5 of them.
    3. You may add other ingredients as you see fit, but the resulting dish
       needs to be based around the random ingredients.""")
println("")

println("Good luck!")
println("")

@show get_random_products(produce_products, 7)

println("")

@show get_random_products(produce_products, 7)