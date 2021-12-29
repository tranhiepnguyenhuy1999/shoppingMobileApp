exports.responseSuccess = (message, status = 200, data = null, error = null) => {
    return {
        status: true,
        data: data,
        msg: message,
        errors: error,
        code: status
    }
}
exports.responseError = (message, status = 400, data = null, error = null) => {
    return {
        status: false,
        data: data,
        msg: message,
        errors: error,
        code: status
    }
}