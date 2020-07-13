$(document).on('turbolinks:load',function(){

$("#new__items__form,#image-box__container").validate({
  rules: {
    "item[images_attributes][][url]":{
      required: true
    },
    "item[name]": {
      required: true
    },
    "item[introduce]": {
      required: true
    },
    "item[category_id]": {
      required: true
    },
    "item[condition_id]": {
      required: true
    },
    "item[delivery_id]": {
      required: true
    },
    "item[prefecture_id]":{
      required: true
    },
    "item[preparation_id]":{
      required: true
    },
    "item[price]":{
      required: true
    }

  },
  messages: {
    "item[images_attributes][][url]":{
      required: "画像がありません"
    },
    "item[name]": {
      required: "商品名を入力してください"
    },
    "item[introduce]": {
      required: "商品の説明を入力してください"
    },
    "item[category_id]": {
      required: "カテゴリーを選択してください"
    },
    "item[condition_id]": {
      required: "商品の状態を選択してください"
    },
    "item[delivery_id]": {
      required: "配送料の負担を選択してください"
    },
    "item[prefecture_id]":{
      required: "発送元の地域を選択してくだい"
    },
    "item[preparation_id]":{
      required: "発送までの日数を選択してください"
    },
    "item[price]":{
      required: "販売価格を入力してください"
    }
 
  },
  errorClass: "invalid", 
  errorElement: "p", 
  validClass: "valid", 
});

$(".new__all__text-field, #item_price, #img-file").blur(function(){
  $(this).valid();
});
});