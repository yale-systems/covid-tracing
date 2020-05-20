export function isName(value) {
    if (!value) return true
    var search = /[^a-zA-Z ]/;

    var res = value.match(search)
    if (res != null) return false
    return true
}