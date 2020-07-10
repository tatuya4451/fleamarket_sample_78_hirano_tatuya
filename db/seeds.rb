seller = Delivery.create(method: "送料込み(出品者負担)")
seller_1 = seller.children.create([{method: "未定"},{method: "らくらくメルカリ便"},{method: "ゆうゆうメルカリ便"},{method:"ゆうメール"},{method: "レターパック"},{method: "普通郵便(定形、定形外)"},{method: "クロネコヤマト"},{method: "ゆうパック"},{method: "クリックポスト"},{method: "ゆうパケット"}])

buyer = Delivery.create(method: "着払い(購入者負担)")
buyer_1 = buyer.children.create([{method: "未定"},{method:"クロネコヤマト"},{method: "ゆうパック"},{method: "ゆうメール"}])

