const { validationResult } = require('express-validator')

exports.checkValidation = function (req, res, next) {
  const errors = validationResult(req)
  if (!errors.isEmpty())
    return res.json({ code: 99, message: "Thông tin bạn nhập không hợp lệ", data: { errors: errors.array() } })
  next()
}
