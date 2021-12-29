const { body } = require('express-validator')

exports.loginValidator = () => {
  return [
    body('email')
      .trim()
      .isEmail()
      .withMessage('Email không hợp lệ')
      .escape(),
      body('password')
      .trim()
      .isLength({ min: 5, max: 16 })
      .withMessage('Phải có độ dài từ 5 đến 16 ký tự')
      .escape()
  ]
}

exports.registerValidator = () => {
  return [
    body('email')
      .trim()
      .isEmail()
      .withMessage('Email không hợp lệ')
      .escape(),
      body('password')
      .trim()
      .isLength({ min: 5, max: 16 })
      .withMessage('Phải có độ dài từ 5 đến 16 ký tự')
      .escape(),
      body('name')
      .trim()
      .notEmpty()
      .withMessage('Tên không được để trống')
      .escape(),
      body('phone')
      .trim()
      .matches(/((0|\+84)+([0-9]{9}))$/, 'g')
      .withMessage('Số điện thoại không hợp lệ')
      .escape(),
  ]
}