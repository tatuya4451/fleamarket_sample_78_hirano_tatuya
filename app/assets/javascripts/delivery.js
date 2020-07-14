$(document).on('turbolinks:load',function(){
  function appendOption(delivery){
    var html = `<option value="${delivery.id}" data-category="${delivery.id}">${delivery.method}</option>`;
    return html;
  }
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='listing-select-wrap__added' id= 'children_wrap'>
                        <div class='listing-select-wrap__box new__all-box'>
                          <select class="listing-select-wrap__box--select new__all__text-field" id="child_delivery"name="item[delivery_id]" >
                            <option value="選択してください" data-category="選択してください">選択してください</option>  
                            ${insertHTML}
                          </select>  
                        </div>
                      </div>`;
    $('.listing-item-detail__delivery').append(childSelectHtml);
  }

  $('#parent_delivery').on('change', function(){
    var parentDelivery = document.getElementById('parent_delivery').value; 
    if (parentDelivery != "選択してください"){
      $.ajax({
        url: 'get_delivery_children',
        type: 'GET',
        data: { parent_id: parentDelivery },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrap').remove(); 
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
      if (parentDelivery = "選択してください"){
        $('#children_wrap').remove(); 
      };
    };
  });
});