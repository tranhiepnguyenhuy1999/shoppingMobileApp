const { body } = require('express-validator')

exports.createValidator = () => {
  return [
    body('name')
      .trim()
      .notEmpty()
      .withMessage('Tên không được để trống'),
  ]
}