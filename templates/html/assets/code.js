$(document).ready(function() {
    document.getElementById("btn_submit").addEventListener("click", handleBtnSubmit);
});

function handleBtnSubmit() {
    let input = $("#input").val();
    $("#output").html(input);
}
