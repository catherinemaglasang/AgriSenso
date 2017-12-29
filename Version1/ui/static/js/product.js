var product = (function(){
    var updateProduct = function(){
    // TODO
    }

    var deleteProduct = function(){
        $.ajax({
            url: 'http://127.0.0.1:5000/products/' + product_id + '/',
            type:"DELETE",
            dataType: "json",
            success: function(resp) {
                if (resp.status  == 'ok') {
                    console.log(resp);
                    add_new_product();
                } else {
                    alert(resp.message);
                }
            },
            error: function (e) {
                alert("danger " + e.status);
                }
                //   beforeSend: function (xhrObj){
                // 	xhrObj.setRequestHeader("Authorization",
                // 		  "Basic " + btoa("ako:akolagini"));
                // }
        });
    }
    var addProduct = function() {
        $.ajax({
            url: 'http://127.0.0.1:5000/products/',
            type: "GET",
            dataType: "json",
            success: function (resp) {
                $("#products").html("");
                if (resp.status == 'ok') {
                    for (i = 0; i < resp.count; i++) {
                        product_id = resp.entries[i].product_id;
                        product_name = resp.entries[i].product_name;
                        description = resp.entries[i].description;
                        price = resp.entries[i].price;
                        date_added = resp.entries[i].date_added;
                        //console.log(resp);
                        $("#products").append(populate_row(product_id, product_name, description, price, date_added));
                    }
                } else {
                    $("#products").html("");
                    alert(resp.message);
                }
            },
            error: function (e) {
                alert("danger " + e.status);
            }
            //   beforeSend: function (xhrObj){
            // 	xhrObj.setRequestHeader("Authorization",
            // 		  "Basic " + btoa("ako:akolagini"));
            // }
        });
    };

    var populate_row = function(id, sku, supplier_id, title, description, category_id, unit_price, on_hand, reorder_product, is_active){
	    return 	'<tr>' +
				'<td>' + product_id + '</td>' +
				'<td>' + product_name + '</td>' +
				'<td>' + description + '</td>' +
				'<td>' + price + '</td>' +
				'<td>' + date_added + '</td>' +
				'<td><a onclick="delete_product('+id+')" class="btn btn-small btn-danger" href="javascript:void(0)">Delete</a></td>' +
				// '<td><a onclick="update_product('+id+')" class="btn btn-small btn-primary" href="#">Update</a></td>' +
			'</tr>';
    };

    return {
        addProduct: addProduct,
        removeProduct: deleteProduct,
        updateProduct: updateProduct
    };
}());