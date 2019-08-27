
<#if productAvailability.get(productId)!false>
    <#assign inStock = true>
<#else>
    <#assign inStock = false>
</#if>

<#if (product.productTypeEnumId == "PtVirtual")!false>
    <#assign isVirtual = true >
<#else>
    <#assign isVirtual = false >
</#if>

<div class="container mt-2">
    <a class="customer-link" href="/moquicon">Home <i class="fas fa-angle-right"></i></a>
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
        <div class="col col-lg-6 col-sm-12 col-md-12">
            <p>
                <span class="product-title">${product.productName}</span>
            </p>
        </div>
        <div class="col col-lg-6 col-sm-12 col-md-12">
            <form class="card cart-div" method="post" action="/moquicon/tickets/addToCart">
                <div>
                    <div class="form-group col">
                        <input type="hidden" value="${product.pseudoId}" name="productId" id="productId"/>
                        <input type="hidden" value="${product.priceUomId}" name="currencyUomId"/>
                        <input type="hidden" value="${ec.web.sessionToken}" name="moquiSessionToken"/>
                        <span class="product-description">Quantity</span>
                        <select class="form-control text-gdark" name="quantity" id="quantity">
                            <option value="1">1</option>
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
                <#--  <#if inStock>
                    <button onclick="onClickAddButton();" id="cartAdd" class="btn cart-form-btn col" type="submit" onclick="">
                        <i class="fa fa-shopping-cart"></i> Add to Cart
                    </button>
                <#else>
                    <h5 class="text-center">Out of Stock</h5>
                </#if>  -->
                <button onclick="onClickAddButton();" id="cartAdd" class="btn cart-form-btn col" type="submit">
                    <i class="fa fa-shopping-cart"></i> Add to Cart
                </button>
            </form>
        </div>
    </div>
    <br>
    <br>
    <br>
    <hr>
</div>

<script>
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

    function onClickAddButton() {
        $('#spinner').show();
    }
</script>
