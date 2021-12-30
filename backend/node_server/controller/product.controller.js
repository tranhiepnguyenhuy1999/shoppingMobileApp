const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

const list = async (req, res, next) => {
    const args = req.query
    const orderBy = args.order_by ? args.order_by : 'created_at'
    const orderType = args.order_type ? args.order_type : 'desc'

    const products = await prisma.product.findMany({
        where: {
            AND: [
                {
                    OR: [
                        { title: { contains: args.keyword } },
                        { description: { contains: args.keyword } },
                    ]
                },
                {
                    size: args.size,
                    category_id: args.category_id,
                },
            ]
        },
        skip: args.skip ? args.skip : 0,
        take: args.take ? args.take : 10,
        orderBy: {
            [orderBy]: orderType
        }
    })

    return res.json({ code: 0, message: "Thành công", data: { products } })

}

const create = async (req, res, next) => {
    if (!req.user) {
        return res.json({ code: 1, message: "Bạn chưa đăng nhập!", data: null })
    }
    const body = req.body

    const category = await prisma.category.findUnique({
        where: {
            id: body.category_id
        }
    })

    if (!category) {
        return res.json({ code: 201, message: "Danh mục không tồn tại", data: null })
    }

    let product = await prisma.product.create({
        data: {
            title: body.title,
            price: body.price,
            size: body.size,
            description: body.description,
            image: body.image,
            color: body.color,
            address: body.address,
            category_id: category.id
        },
    });
    product.hash = "string"
    return res.json({ code: 0, message: "Thành công", data: { product } })

}

const update = async (req, res, next) => {
    if (!req.user) {
        return res.json({ code: 1, message: "Bạn chưa đăng nhập!", data: null })
    }
    const body = req.body

    if (body.category_id) {
        const category = await prisma.category.findUnique({
            where: {
                id: body.category_id
            }
        })

        if (!category) {
            return res.json({ code: 201, message: "Danh mục không tồn tại", data: null })
        }
    }

    let product = await prisma.product.findUnique({
        where: {
            id: parseInt(req.params.id)
        },
    });

    if (!product) {
        return res.json({ code: 200, message: "Sản phẩm không tồn tại", data: null })
    }

    product = await prisma.product.update({
        where: {
            id: product.id
        },
        data: {
            title: body.title,
            price: body.price,
            size: body.size,
            description: body.description,
            image: body.image,
            color: body.color,
            address: body.address,
            category_id: body.category_id,
        },
    })
    product.hash = "string"

    return res.json({ code: 0, message: "Thành công", data: { product } })
}

const detail = async (req, res, next) => {
    if (!req.user) {
        return res.json({ code: 1, message: "Bạn chưa đăng nhập!", data: null })
    }
    let product = await prisma.product.findUnique({
        where: {
            id: parseInt(req.params.id)
        },
    });

    if (!product) {
        return res.json({ code: 200, message: "Sản phẩm không tồn tại", data: null })
    }

    product.hash = "string"
    return res.json({ code: 0, message: "Thành công", data: { product } })
}

const remove = async (req, res, next) => {
    if (!req.user) {
        return res.json({ code: 1, message: "Bạn chưa đăng nhập!", data: null })
    }
    let product = await prisma.product.findUnique({
        where: {
            id: parseInt(req.params.id)
        },
    });

    if (!product) {
        return res.json({ code: 200, message: "Sản phẩm không tồn tại", data: null })
    }
    product = await prisma.product.delete({
        where: {
            id: product.id
        },
    })

    hash = "string"
    return res.json({ code: 0, message: "Thành công", data: { hash } })
}


module.exports = { list, detail, create, update, remove }
