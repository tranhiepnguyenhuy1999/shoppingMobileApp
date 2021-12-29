const express = require('express')
const router = express.Router()
const { loginValidator, registerValidator } = require('../../validators/credentials.validator')
const productValidator = require('../../validators/product.validator')
const orderValidator = require('../../validators/order.validator')
const categoryValidator = require('../../validators/category.validator')
const { checkValidation } = require('../../validators/checkValidationErr')
const credentialsController = require('../../controller/credentials.controller')
const productController = require('../../controller/product.controller')
const orderController = require('../../controller/order.controller')
const categoryController = require('../../controller/category.controller')

router.post('/register', registerValidator(), checkValidation,
    (req, res, next) => {
        credentialsController.register(req, res, next)
    })

router.post('/login', loginValidator(), checkValidation,
    (req, res, next) => {
        credentialsController.login(req, res, next)
    })

// router.use('/app',
//     (req, res, next) => {
//         if (!req.user) {
//             return res.json({ code: 1, message: "Bạn chưa đăng nhập!", data: null })
//         }
//         next()
//     })

router.get('/app/product',
    (req, res, next) => {
        productController.list(req, res, next)
    })

router.get('/app/product/:id',
    (req, res, next) => {
        productController.detail(req, res, next)
    })

router.post('/app/product', productValidator.createValidator(), checkValidation,
    (req, res, next) => {
        productController.create(req, res, next)
    })

router.put('/app/product/:id', productValidator.updateValidator(), checkValidation,
    (req, res, next) => {
        productController.update(req, res, next)
    })

router.delete('/app/product/:id',
    (req, res, next) => {
        productController.remove(req, res, next)
    })

router.get('/app/order',
    (req, res, next) => {
        orderController.list(req, res, next)
    })

router.get('/app/order/:id',
    (req, res, next) => {
        orderController.detail(req, res, next)
    })

router.post('/app/order', orderValidator.createValidator(), checkValidation,
    (req, res, next) => {
        orderController.create(req, res, next)
    })

router.get('/app/category',
    (req, res, next) => {
        categoryController.list(req, res, next)
    })

router.post('/app/category', categoryValidator.createValidator(), checkValidation,
    (req, res, next) => {
        categoryController.create(req, res, next)
    })

module.exports = router
