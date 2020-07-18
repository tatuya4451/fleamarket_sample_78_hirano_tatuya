                    // ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー過去の記述ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
              
              // $(document).on('turbolinks:load',function(){
              //   var dataBox = new DataTransfer();
              //   var file_field = document.querySelector('input[type=file]')
              //   $('#edit-img-file').change(function(){
              //     var files = $('input[type="file"]').prop('files')[0];
                  
              //     $.each(this.files, function(i, file){
              //       var fileReader = new FileReader();

              //       dataBox.items.add(file)
              //       file_field.files = dataBox.files

              //       var num = $('.edit-item-image').length + 1 + i
              //       fileReader.readAsDataURL(file);
              //       if (num == 4){
              //         $('#edit-image-box__container').css('display', 'none')   
              //       }
              //       fileReader.onloadend = function() {
              //         var src = fileReader.result
              //         var html= `<div class='edit-edit-item-image' data-image="${file.name}">
              //                     <div class=' edit-item-image__content'>
              //                       <div class='edit-item-image__content--icon'>
              //                         <img src=${src} width="155" height="146" object-fit="initial">
              //                       </div>
              //                     </div>
              //                     <div class='edit-item-image__operetion'>
              //                       <div class='edit-item-image__operetion--delete'>削除</div>
              //                     </div>
              //                   </div>`
              //         $('#edit-image-box__container').before(html);
              //       };
              //       $('#edit-image-box__container').attr('class', `item-num-${num}`)

              // /* <div class="input-area" id="input-area">
              // <input type="file" id="edit-img-file" name="item[images_attributes][1][url]">
              // <input name="item[images_attributes][1][_destroy]" type="hidden" value="0"><input class="hidden-destroy" type="checkbox" value="1" name="item[images_attributes][1][_destroy]" id="item_images_attributes_1__destroy">
              // </div> */

              //     });
              //   });
              //     // 削除チェックボックス 連携
              //   $(document).on("click", '.edit-item-image__operetion--delete', function(){
              //     const delete_toindex = $(this).parent.find('.edit-item-image__operetion--delete').data('index');
              //     const target_checkbox = $(`input[data-index="${delete_toindex}"]`).hidden-destroy
              //     if (target_checkbox) target_checkbox.prop('checked', true);
              //     $(this).parent().remove();
              //     $(`img[data-index="${delete_toindex}"]`).remove();

              //     var target_image = $(this).parent().parent()
              //     var target_name = $(target_image).data('image')

              //     if(file_field.files.length==1){
              //       $('input[type=file]').val(null)
              //       dataBox.clearData();
              //     }else{
              //       $.each(file_field.files, function(i,input){
              //         if(input.name==target_name){
              //           dataBox.items.remove(i) ;
              //         }
              //       })
              //       file_field.files = dataBox.files;
              //     }
              //     target_image.remove()
              //     var num = $('.edit-item-image').length;
              //     $('#edit-image-box__container').show();
              //     $('#edit-image-box__container').attr('class', `item-num-${num}`)
              //   })
                

                


              //   $(window).on("load","edits" function() {
              //     var classCount = $('.edit-item-image').length;
              //     if (classCount == 4) {
              //       $('.label-content').hide();
              //     }else{ 
              //       $('.label-content').show();
              //     }
              //   })

              //   $(document).on('click' , function() {
              //     var classCount = $('.edit-item-image').length;
              //     console.log(classCount);
              //     if (classCount == 4) {
              //       $('.label-content').hide();
              //     }else{ 
              //       $('.label-content').show();
              //     }
              //   })

              //   $('.edits').mouseover(function() {
              //     var classCount = $('.edit-item-image').length;
              //     if (classCount == 4) {
              //       $('.label-content').hide();
              //     }else{ 
              //       $('.label-content').show();
              //     }
              //   })

              //   $(function(){
              //     let last_image_id = $('.input-area:last').data("input-area")
              //     .done(function(image){
              //       $('.label-content').click(function(){
              //         // $('edit-img-file:last')

              //       })
              //     })
              //   })
              // });


                              

              $(document).on('turbolinks:load', function(){
                $(function(){
              
                  //プレビューのhtmlを定義
                  function buildHTML(count) {
                    var html = `<div class="preview-box" id="preview-box__${count}">
                                  <div class="upper-box">
                                    <img src="" alt="preview">
                                  </div>
                                  <div class="lower-box">
                                    <div class="delete-box" id="delete_btn_${count}">
                                      <span>削除</span>
                                    </div>
                                  </div>
                                </div>`
                    return html;
                  }
              
              
                  if (window.location.href.match(/\/items\/\d+\/edit/)){
                    //登録済み画像のプレビュー表示欄の要素を取得する
                    // var prevContent = $('.label-content').prev();
                    // labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
                    // $('.label-content').css('width', labelWidth);
                    //プレビューにidを追加
                    $('.preview-box').each(function(index, box){
                      $(box).attr('id', `preview-box__${index}`);
                    })
                    //削除ボタンにidを追加
                    $('.delete-box').each(function(index, box){
                      $(box).attr('id', `delete_btn_${index}`);
                    })
                    var count = $('.preview-box').length;
                    //プレビューが5あるときは、投稿ボックスを消しておく
                    if (count == 4) {
                      $('.label-content').hide();
                    }
                  }
                  //=============================================================================
              
                  // ラベルのwidth操作
                  function setLabel() {
                    //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
                    // var prevContent = $('.label-content').prev();
                    // labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
                    // $('.label-content').css('width', labelWidth);
                  }
              
                  // プレビューの追加
                  $(document).on('change', '.hidden-field', function() {
                    setLabel();
                    //hidden-fieldのidの数値のみ取得
                    var id = $(this).attr('id').replace(/[^0-9]/g, '');
                    //labelボックスのidとforを更新
                    $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
                    //選択したfileのオブジェクトを取得
                    var file = this.files[0];
                    var reader = new FileReader();
                    //readAsDataURLで指定したFileオブジェクトを読み込む
                    reader.readAsDataURL(file);
                    //読み込み時に発火するイベント
                    reader.onload = function() {
                      var image = this.result;
                      //プレビューが元々なかった場合はhtmlを追加
                      if ($(`#preview-box__${id}`).length == 0) {
                        var count = $('.preview-box').length;
                        var html = buildHTML(id);
                        //ラベルの直前のプレビュー群にプレビューを追加
                        var prevContent = $('.label-content').prev();
                        $(prevContent).append(html);
                      }
                      //イメージを追加
                      $(`#preview-box__${id} img`).attr('src', `${image}`);
                      var count = $('.preview-box').length;
                      //プレビューが5個あったらラベルを隠す 
                      if (count == 4) { 
                        $('.label-content').hide();
                      }
              
                      //プレビュー削除したフィールドにdestroy用のチェックボックスがあった場合、チェックを外す=============
                      if ($(`#item_images_attributes_${id}__destroy`)){
                        $(`#item_images_attributes_${id}__destroy`).prop('checked',false);
                      } 
                      //=============================================================================
              
                      //ラベルのwidth操作
                      setLabel();
                      //ラベルのidとforの値を変更
                      if(count < 4){
                        $('.label-box').attr({id: `label-box--${count}`,for: `item_images_attributes_${count}_image`});
                      }
                    }
                  });
              
                  // 画像の削除
                  $(document).on('click','.delete-box', function() {
                    console.log("クリックされました")
                    var count = $('.preview-box').length;
                    setLabel(count);
                    var id = $(this).attr('id').replace(/[^0-9]/g, '');
                    $(`#preview-box__${id}`).remove();
              
                    //新規登録時と編集時の場合分け==========================================================
              
                    //新規投稿時
                    //削除用チェックボックスの有無で判定
                    if ($(`#item_images_attributes_${id}__destroy`).length == 0) {
                      //フォームの中身を削除 
                      $(`#item_images_attributes_${id}_image`).val("");
                      var count = $('.preview-box').length;
                      //4個めが消されたらラベルを表示
                      if (count == 4) {
                        $('.label-content').show();
                      }
                      setLabel(count);
                      if(id < 4){
                        $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
              
                      }
                    } else {
                      //投稿編集時
                      $(`#item_images_attributes_${id}__destroy`).prop('checked',true);
                      //4個めが消されたらラベルを表示
                      if (count == 4) {
                        $('.label-content').show();
                      }
              
                      //ラベルのwidth操作
                      setLabel();
                      //ラベルのidとforの値を変更
                      //削除したプレビューのidによって、ラベルのidを変更する
                      if(id < 4){
                        $('.label-box').attr({id: `label-box--${id}`,for: `item_images_attributes_${id}_image`});
                      }
                    }
                  });
                });
              });
              