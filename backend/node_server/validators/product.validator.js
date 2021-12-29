const { body } = require('express-validator')

exports.createValidator = () => {
  return [
    body('title')
      .trim()
      .notEmpty()
      .withMessage('Tiêu đề  không hợp lệ'),
    body('price')
      .notEmpty()
      .isInt({ gt: 0, lt: 1000000000 })
      .withMessage('Giá tiền không hợp lệ'),
    body('size')
      .notEmpty()
      .isInt()
      .withMessage('Size không hợp lệ'),
    body('description')
      .notEmpty()
      .withMessage('Mô tả không hợp lệ'),
    body('image')
      .notEmpty()
      .isURL()
      .withMessage('Hình ảnh phải là url'),
    body('color')
      .notEmpty()
      .withMessage('Màu Không hợp lệ'),
    body('address')
      .notEmpty()
      .withMessage('Địa chỉ Không hợp lệ'),
  ]
}

exports.updateValidator = () => {
  return [
    body('price')
      .isInt({ gt: 0, lt: 1000000000 })
      .withMessage('Giá tiền không hợp lệ'),
    body('size')
      .isInt()
      .withMessage('Size không hợp lệ'),
    body('image')
      .isURL()
      .withMessage('Hình ảnh phải là url'),
    body('address')
      .notEmpty()
      .withMessage('Địa chỉ Không hợp lệ'),
  ]
}