// document.addEventListener(
//   "DOMContentLoaded", e => {
//     if (document.getElementById("token_submit") != null) { 
//       Payjp.setPublicKey("pk_test_fc8c41a99bbb93435da5afdc");
//       let btn = document.getElementById("token_submit"); 
//       btn.addEventListener("click", e => {
//         e.preventDefault();
//         let card = {
//           number: document.getElementById("card_number").value,
//           cvc: document.getElementById("cvc").value,
//           exp_month: document.getElementById("exp_month").value,
//           exp_year: document.getElementById("exp_year").value
//         }; 
//         Payjp.createToken(card, (status, response) => {
//           if (status === 200) {
//             $("#card_number").removeAttr("name");
//             $("#cvc").removeAttr("name");
//             $("#exp_month").removeAttr("name");
//             $("#exp_year").removeAttr("name"); 
//             $("#card_token").append(
//               $('<input type="hidden" name="payjp-token">').val(response.id)
//             ); 
//             document.inputForm.submit();
//             alert("登録が完了しました"); 
//           } else {
//             alert("カード情報が正しくありません。");
//           }
//         });
//       });
//     }
//   },
//   false
// );




$(function() {
  $('#cardCreateForm').on('submit', function(e) {
    e.preventDefault() 
    // フォームをクリックした時の挙動
    Payjp.setPublicKey('pk_test_fc8c41a99bbb93435da5afdc');

    // 公開鍵をセット、payjpに許可をもらう
    var card = {
      number: document.getElementById("card_number").value,
      exp_month: document.getElementById("exp_month").value,
      exp_year: document.getElementById("exp_year").value,
      cvc: document.getElementById("cvc").value
    };
    // フォームのIDを特定、card変数に代入する
    if (card.number == "" || card.cvc == "") {
      alert("入力もれがあります");
      // 変数cardのnumberかcvcが空だった時にエラーをする
    } else {
      // トークンの生成、値を渡す
      Payjp.createToken(card, function(status, response) {
        if (status === 200 ) {
          $("#card_number").removeAttr("name");
          $("#cvc").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name");
          // Payjpから帰ってきたデータ(response.id)を、フォームに返す処理をappend
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          );
          // submitすることで、Payjpから返してもらったデータをこの後controllerに送りcreateアクションを行っていく
          $('#cardCreateForm').get(0).submit();
          alert("登録に成功しました");
        } else {
          alert("カード情報が正しくありません");
        }
      });
    }
  });
});
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