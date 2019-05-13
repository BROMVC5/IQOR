$("[input-check]").keypress(function (e) { // override keypress of " or ' or /
    if (e.which == 13 || e.which == 34 || e.which == 39 || e.which == 92) { // This code follow this code unicode-table.com/en/#0022
        return false;
    }
})

    .bind("paste", function (e) {// forbid paste
        e.preventDefault();
    })