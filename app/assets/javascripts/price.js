$(function(){
  $('#item_price').on('keyup', function(){
    let price = $(this).val();
    let salesFee = price * 0.1
    let mfSalesFee = Math.floor(salesFee)
    let salesProfit = price * 0.9
    let mcSalesProfit = Math.ceil(salesProfit)
  $('#SalesFee').text(mfSalesFee);
  $('#SalesProfit').text(mcSalesProfit);
  })
})