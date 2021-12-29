const { body } = require('express-validator')

exports.createValidator = () => {
  return [
    body('products')
      .notEmpty()
      .withMessage('Danh sách sản phẩm không được rồng')
      .isArray()
      .withMessage('Danh sách sản phẩm phải là mảng'),
    body('products.*.product_id')
      .isInt()
      .withMessage('Id sản phẩm phải là một số')
      .notEmpty()
      .withMessage('Id sản phẩm không hợp lệ'),
    body('products.*.quantity')
      .isInt({ min: 1 })
      .withMessage('Số lượng không được bỏ trống')
      .notEmpty()
      .withMessage('Số lượng ít nhất là 1'),
    body('total_price')
      .notEmpty()
      .withMessage('Số tiền không được bỏ trống')
      .isInt({ min: 0 })
      .withMessage('Số tiền phải là số tự nhiên'),
  ]
}
