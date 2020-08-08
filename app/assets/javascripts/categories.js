$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    let html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  
  //選択してください付与
    let select = `<option value=0 >選択してください</option>`;
  //子カテゴリの取得に失敗するのは

  //親カテゴリー選択によるイベント
  $(document).on("change","#parent_category", function() {
    //選択された親カテゴリーの名前取得 → コントローラーに送る
    let parentCategory =  $("#parent_category").val();
    console.log(parentCategory)
    if (parentCategory != "") {
      $.ajax( {
        type: 'GET',
        url: '/items/get_category_children',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children) {
        $("#children_category").empty();
        $("#children_category").append(select);
        $("#grandchildren_category").empty();
        $("#grandchildren_category").append(select);
        $('.size_box').val('');
        $('#size_box').css('display', 'none');
        let insertHTML = '';
        children.forEach(function(child) {
          insertHTML += appendOption(child);
        });
        $("#children_category").append(insertHTML);
      })
      .fail(function() {
        alert('error：子カテゴリーの取得に失敗');
        $("#children_category").empty();
        $("#children_category").append(select);
        $("#grandchildren_category").empty();
        $("#grandchildren_category").append(select);
      })
    }else{
      $("#children_category").empty();
      $("#children_category").append(select);
      $("#grandchildren_category").empty();
      $("#grandchildren_category").append(select);
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });

  //子カテゴリー選択によるイベント発火
  $(document).on('change', '#children_category', function() {
    //選択された子カテゴリーidを取得
    let childId = $('#children_category option:selected').data('category');
    //子カテゴリーが初期値でない場合
    if (childId != ""){
      $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        datatype: 'json'
      })
      .done(function(grandchildren) {
        if (grandchildren.length != 0) {
          $("#grandchildren_category").empty();
          $("#grandchildren_category").append(select);
          $('.size_box').val('');
          $('#size_box').css('display', 'none');
          let insertHTML = '';
          grandchildren.forEach(function(grandchild) {
            insertHTML += appendOption(grandchild);
          });
          $("#grandchildren_category").append(insertHTML);
        }
      })
      .fail(function() {
        alert('error:孫カテゴリーの取得に失敗');
        $("#grandchildren_category").empty();
        $("#grandchildren_category").append(select);
      })
    }else{
      $("#grandchildren_category").empty();
      $("#grandchildren_category").append(select);
      $('.size_box').val('');
      $('#size_box').css('display', 'none');      
    }
  });

  //子カテゴリークリックによるイベント発火
  $(document).on('click', '#children_category', function() {
    //選択された親カテゴリーの名前取得 → コントローラーに送る
    let parentCategory =  $("#parent_category").val();
    console.log(parentCategory)
    if (parentCategory != "") {
      $.ajax( {
        type: 'GET',
        url: '/items/get_category_children',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children) {
        $("#children_category").empty();
        $("#children_category").append(select);
        $("#grandchildren_category").empty();
        $("#grandchildren_category").append(select);
        $('.size_box').val('');
        $('#size_box').css('display', 'none');
        let insertHTML = '';
        children.forEach(function(child) {
          insertHTML += appendOption(child);
        });
        $("#children_category").append(insertHTML);
      })
      .fail(function() {
        alert('error：子カテゴリーの取得に失敗');
        $("#children_category").empty();
        $("#children_category").append(select);
        $("#grandchildren_category").empty();
        $("#grandchildren_category").append(select);
      })
    }else{
      $("#children_category").empty();
      $("#children_category").append(select);
      $("#grandchildren_category").empty();
      $("#grandchildren_category").append(select);
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });
  
  //孫カテゴリー選択によるイベント発火
  $(document).on('change', '#grandchildren_category', function() {
    let grandchildId = $('#grandchildren_category option:selected').data('category');
    if (grandchildId != "") {
      $('.size_box').val('');
      $('#size_box').css('display', 'block');
    } else {
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });
});
