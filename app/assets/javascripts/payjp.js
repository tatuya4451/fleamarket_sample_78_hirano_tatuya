$(function(){
  // payjp.jsの初期化
  
  Payjp.setPublicKey('pk_test_89de1046715f962e6dfd6f71');
  
  // ボタンのイベントハンドリング
  const btn = document.getElementById('token');
  $(btn).on('click', function(e){
    e.preventDefault();
    // カード情報生成
    const card = {
      number: document.getElementById('card_number').value,
      cvc: document.getElementById('cvv').value,
      exp_month: document.getElementById('exp_month').value,
      exp_year: document.getElementById('exp_year').value
    };
    
    // トークン生成
    Payjp.createToken(card, (status, response) => {
      if (status === 200){
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");//データを自サーバに保存しないようにname属性を削除
        var token = response.id;
        $("#charge-form").append($('<input type="hidden" name="card_token" class="payjp-token" />').val(token));
        $("#charge-form").get(0).submit();
      }else{
        alert("Error");
      }
    });
  });
})


