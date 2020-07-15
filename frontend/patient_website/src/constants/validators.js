function isName(value) {
    if (!value) return true
    let search = /[^a-zA-Z' \-]/;

    let res = value.match(search)
    if (res != null) return false
    return true
}

function isPhone(value) {
    if (!value) return true
    let res = value.match(/([^0-9() \-])/)
    if (res != null) return false
    return true
}
export { isName, isPhone }