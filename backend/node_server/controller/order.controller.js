const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()
const ContractService = require('../service/ContractService');

const list = async (req, res, next) => {
    if (!req.user) {
        return res.json({ code: 1, message: "Bạn chưa đăng nhập!", data: null })
    }
    const args = req.query
    const orderBy = args.order_by ? args.order_by : 'created_at'
    const orderType = args.order_type ? args.order_type : 'desc'

    const orders = await prisma.order.findMany({
        where: {
            status: args.status,
            user_id: req.user.id
        },
        skip: args.skip ? args.skip : 0,
        take: args.take ? args.take : 10,
        orderBy: {
            [orderBy]: orderType
        },
        include: {
            details: {
                include: {
                    product: true
                }
            }
        }
    })

    return res.json({ code: 0, message: "Thành công", data: { orders } })

}

const detail = async (req, res, next) => {
    if (!req.user) {
        return res.json({ code: 1, message: "Bạn chưa đăng nhập!", data: null })
    }
    let order = await prisma.order.findUnique({
        where: {
            id: parseInt(req.params.id)
        },
        include: {
            details: {
                include: {
                    product: true
                }
            }
        }
    });

    if (!order) {
        return res.json({ code: 300, message: "Đơn hàng không tồn tại", data: null })
    }

    if (order.user_id != req.user.id) {
        return res.json({ code: 301, message: "Đơn hàng không phải của bạn tồn tại", data: null })
    }

    return res.json({ code: 0, message: "Thành công", data: { order } })
}

const create = async (req, res, next) => {
    if (!req.user) {
        return res.json({ code: 1, message: "Bạn chưa đăng nhập!", data: null })
    }
    const body = req.body
    let details = []
    let totalPrice = 0
    for (const e of body.products) {
        product = await prisma.product.findUnique({
            where: {
                id: e.product_id
            }
        })

        if (!product) {
            return res.json({ code: 302, message: "Sản phẩm không tồn tại", data: { product_id: e.product_id } })
        }
        details.push({
            product_id: product.id,
            quantity: e.quantity,
            unit_price: product.price
        })
        totalPrice += e.quantity * product.price
    }

    if (totalPrice != body.total_price) {
        return res.json({ code: 303, message: "Số tiền phải trả không đúng", data: { pay_price: totalPrice } })
    }
    let coupon = null
    if (body.code) {
        coupon = await prisma.coupon.findUnique({
            where: {
                code: body.code
            }
        })

        return res.json({ code: 304, message: "Mã giảm giá không tồn tại", })

    }

    let order = await prisma.order.create({
        data: {
            user_id: req.user.id,
            total_price: totalPrice,
            pay_price: totalPrice,
            coupon_code_id: coupon ? coupon.id : null,
            address: body.address,
            name: body.name,
            phone: body.phone,
            details: {
                createMany: {
                    data: details
                }
            }
        },
        include: {
            details: true
        }
    });
    let { contract, coinbase } = ContractService.getContract();

    contract.methods.addOrder(
        order.id,
        order.user_id,
        order.total_price,
        order.address,
        JSON.stringify(order.details),
        order.name,
        order.phone,
        new Date().getTime()
    ).send({
        from: coinbase,
        gas: 235680
    })
        .on('receipt', async function (receipt) {
            console.log(receipt)
            order = await prisma.order.update({
                where: {
                    id: order.id
                },
                data: {
                    hash: receipt.transactionHash
                }
            })
            return res.json({ code: 0, message: "Thành công", data: { order } })
        })
        .on('error', function (error, receipt) {
            console.log(error)

            return res.json({ code: 90, message: "Có lỗi với hợp đồng thông minh", data: null })
        });
}

module.exports = { list, create, detail }
