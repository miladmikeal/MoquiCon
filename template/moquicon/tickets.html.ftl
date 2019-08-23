<#assign inStock = false>
<#if (product.productTypeEnumId == "PtVirtual")!false>
    <#assign isVirtual = true >
<#else>
    <#assign isVirtual = false >
    <#if productAvailability.get(productId)!false><#assign inStock = true></#if>
</#if>
<div class="container mt-2">
    <a class="customer-link" href="/store">Home <i class="fas fa-angle-right"></i></a>
    <a class="customer-link">${product.productName}</a>
</div>
<div class="container container-text mt-1">
    <#if addedCorrect?? && addedCorrect == 'true'>
        <div class="alert alert-primary mt-3 mb-3" role="alert">
            <i class="far fa-check-square"></i> You added a ${product.productName} to your shopping cart.
            <a class="float-right" href="/moquicon/d#/checkout">Go to Checkout <i class="fas fa-arrow-right"></i></a>
        </div>
    </#if>
    <#--  <div class="row d-flex justify-content-center">
        <img id="spinner" class="product-spinner" src="/moquicon/assets/spinner.gif">
    </div>  -->
    <div class="row mt-2">
        <div class="col col-lg-4 col-sm-12 col-12">
            <p>
                <span class="product-title">${product.productName}</span>
            </p>
        </div>
        <div class="col col-lg-3">
            <form class="card cart-div" method="post" action="/moquicon/product/addToCart">
                <div>
                    <div class="form-group col">
                        <div class="cart-form-price">
                            <p>
                                <span class="price-text">${product.price}</span> 
                                <#if product.listPrice??>
                                    <span>
                                        <span class="product-listprice-text">was</span>
                                        <del>${product.listPrice}</del>
                                    </span>
                                </#if>
                            </p>
                        </div>
                        <hr class="product-hr" style="margin-top: -5px;">
                        <#--
                        <span class="product-description">On sale until midnight or until stocks last.</span>
                        <hr class="product-hr">
                        -->
                    </div>
                    <div class="form-group col">
                        <input type="hidden" value="${product.pseudoId}" name="productId" id="productId" />
                        <input type="hidden" value="${product.priceUomId}" name="currencyUomId" />
                        <input type="hidden" value="${ec.web.sessionToken}" name="moquiSessionToken"/>
                        <span class="product-description">Quantity</span>
                        <select class="form-control text-gdark" name="quantity" id="quantity">
                            <#if productQuantity.productQuantity??>
                                <#list 1..productQuantity.productQuantity as x>
                                    <option value="${x}">${x}</option>
                                </#list>
                            <#else>
                                <option value="0">0</option> 
                            </#if>
                        </select>
                    </div>
                    <#if isVirtual>
                        <div class="form-group col">
                            <#assign featureTypes = variantsList.listFeatures.keySet()>
                            <#assign arrayIds = [] />
                            <#list featureTypes![] as featureType>
                                ${featureType.description!}
                                <#assign variants = variantsList.listFeatures.get(featureType)>
                                <select class="form-control" id="variantProduct${featureType?index}" required>
                                    <option value="" disabled selected>
                                        Select an Option 
                                    </option>
                                    <#list variants![] as variant>
                                        <option value="${variant.abbrev!}">
                                            ${variant.description!} 
                                        </option>
                                    </#list>
                                </select>
                            </#list>
                        </div>
                    </#if>
                </div>
                <#if inStock>
                    <button onclick="onClickAddButton();" id="cartAdd" class="btn cart-form-btn col" type="submit" onclick="">
                        <i class="fa fa-shopping-cart"></i> Add to Cart
                    </button>
                <#else>
                    <h5 class="text-center">Out of Stock</h5>
                </#if>
            </form>
        </div>
    </div>
    <hr>
</div>

<script>
    var prodImageUrl = "/moquicon/content/productImage/";
    var $productImageLarge = document.getElementById("product-image-large");

    document.body.onload = function() {
        <#if isVirtual>
            var productAvailability = ${productAvailability?replace('=',':')};
            var variantIdList = [];
            <#list 0..variantsList.listFeatures.keySet()?size - 1  as x>
                $('#variantProduct${x}').on('change', function() {
                    var productVariantId = $('#productId').val();
                    variantIdList[${x}] = this.value;
                    if(typeof(variantIdList[1]) != 'undefined') {
                        productVariantId = productVariantId + '_' + variantIdList[1] + '_' + variantIdList[0];
                    } else {
                        productVariantId = productVariantId + '_' + variantIdList[0];
                    }
                });
            </#list>
        </#if> 
    }

    function onClickAddButton() {
        $('#spinner').show();
    }
</script>
