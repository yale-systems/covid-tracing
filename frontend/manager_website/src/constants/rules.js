function required(value) { return !!value || 'Required' }

function phone(value) { return /[0-9]/.test(value) || 'Phone can only contain digits'}

function email(value) { return /.+@.+\..+/.test(value) || 'E-mail must be valid'}

function makeLength(max) {
    return ((value) => (value || '').length <= max || `Max ${max} characters`)
}

function nameChars(value) { return /[A-Za-zÀ-ÖØ-öø-ÿ'\-]+[A-Za-zÀ-ÖØ-öø-ÿ'\-]*/.test(value) || 'Names only contain alphabetic characters'}

function textarea(value) { return /^[<>{}]/.test(value) || '< > not allowed in text input' }

export default {
    required, phone, email, makeLength, nameChars, textarea
}