
document.addEventListener(
  "DOMContentLoaded", e => {//DOM読み込みが完了したら実行
    if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_fc8c41a99bbb93435da5afdc"); //ここに公開鍵を直書き
      let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得
      btn.addEventListener("click", e => { //ボタンが押されたときに作動
        e.preventDefault(); //ボタンを一旦無効
        console.log(e)
        let card = {//カード情報生成
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        }; //入力されたデータを取得
      
        Payjp.createToken(card, (status, response) => {//トークン生成
        
          if (status === 200) { //成功した場合
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
            $("#card_token").append(
            // $("#token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
           
            ); //取得したトークンを送信できる状態
          
            // document.inputForm.submit();
            $('#charge-form')[0].submit();
            alert("登録が完了しました"); 
          } else {
            alert("カード情報が正しくありません。"); 
          }
          // e.stopPropagation();
        });
      });
    }
  },
);




// var form = $("#card__form");
// Payjp.setPublicKey('pk_test_fc8c41a99bbb93435da5afdc');
// //まずはテスト鍵をセットする↑
// $("#submit_btn").on("click",function(e){
//   e.preventDefault();
// //↑ここでrailsの処理を止めることでjsの処理を行う
//   var card = {
//     number: $("#card_number").val(),
//     cvc: $("#card_cvc").val(),
//     exp_month: $("#card_month").val(),
//     exp_year: $("#card_year").val()
//   };
//  //↑Pay.jpに登録するデータを準備する
//   Payjp.createToken(card,function(status,response){
//  //↑先ほどのcard情報がトークンという暗号化したものとして返ってくる
//     form.find("input[type=submit]").prop("disabled", true);
//     if(status == 200){//←うまくいった場合200になるので
//       $("#card_number").removeAttr("name");
//       $("#card_cvc").removeAttr("name");
//       $("#card_month").removeAttr("name");
//       $("#card_year").removeAttr("name");
//      //↑このremoveAttr("name")はデータを保持しないように消している
//       var payjphtml = `<input type="hidden" name="payjpToken" value=${response.id}>`
//       form.append(payjphtml);
//       //↑これはdbにトークンを保存するのでjsで作ったトークンをセットしてる
//       document.inputForm.submit();
//      //↑そしてここでsubmit！！これでrailsのアクションにいく！もちろん上でトークンをセットしているのでparamsの中には{payjpToken="トークン"}という情報が入っている
//     }else{
//       alert("カード情報が正しくありません。");
//     }
//   });
// });





// $(function() {
//   $('#cardCreateForm').on('submit', function(e) {
//     e.preventDefault() 
//     // フォームをクリックした時の挙動
//     Payjp.setPublicKey('pk_test_fc8c41a99bbb93435da5afdc');

//     // 公開鍵をセット、payjpに許可をもらう
//     var card = {
//       number: document.getElementById("card_number").value,
//       exp_month: document.getElementById("exp_month").value,
//       exp_year: document.getElementById("exp_year").value,
//       cvc: document.getElementById("cvc").value
//     };
//     // フォームのIDを特定、card変数に代入する
//     if (card.number == "" || card.cvc == "") {
//       alert("入力もれがあります");
//       // 変数cardのnumberかcvcが空だった時にエラーをする
//     } else {
//       // トークンの生成、値を渡す
//       Payjp.createToken(card, function(status, response) {
//         if (status === 200 ) {
//           $("#card_number").removeAttr("name");
//           $("#cvc").removeAttr("name");
//           $("#exp_month").removeAttr("name");
//           $("#exp_year").removeAttr("name");
//           // Payjpから帰ってきたデータ(response.id)を、フォームに返す処理をappend
//           $("#card_token").append(
//             $('<input type="hidden" name="payjp-token">').val(response.id)
//           );
//           // submitすることで、Payjpから返してもらったデータをこの後controllerに送りcreateアクションを行っていく
//           $('#cardCreateForm').get(0).submit();
//           alert("登録に成功しました");
//         } else {
//           alert("カード情報が正しくありません");
//         }
//       });
//     }
//   });
// });
// 情報を元にトークンを作る













// $(function() {
//   $('#cardCreateForm').on('submit', function(e) {
//     e.preventDefault() 
//     // フォームをクリックした時の挙動
//     // var payjp = Payjp('pk_test_fc8c41a99bbb93435da5afdc');
//     Payjp.setPublicKey('pk_test_fc8c41a99bbb93435da5afdc');

//     // 公開鍵をセット、payjpに許可をもらう
//     var card = {
//       number: document.getElementById("card_number").value,
//       exp_month: document.getElementById("exp_month").value,
//       exp_year: document.getElementById("exp_year").value,
//       cvc: document.getElementById("cvc").value
//     };
//     // フォームのIDを特定、card変数に代入する
//     if (card.number == "" || card.cvc == "") {
//       alert("入力もれがあります");
//       // 変数cardのnumberかcvcが空だった時にエラーをする
//     } else {
//       Payjp.createToken(card, function(status, response) {
//         if (status === 200 ) {
//           $("#card_number").removeAttr("name");
//           $("#cvc").removeAttr("name");
//           $("#exp_month").removeAttr("name");
//           $("#exp_year").removeAttr("name");
//           $("#card_token").append(
//             $('<input type="hidden" name="payjp-token">').val(response.id)
//           );
//           $('#cardCreateForm').get(0).submit();
//           alert("登録に成功しました");
//         } else {
//           alert("カード情報が正しくありません");
//         }
//       });
//     }
//   });
// });
// // 情報を元にトークンを作る