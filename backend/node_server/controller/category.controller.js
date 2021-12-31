const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

const list = async (req, res, next) => {
    const args = req.query
    const orderBy = args.order_by ? args.order_by : 'created_at'
    const orderType = args.order_type ? args.order_type : 'desc'

    const categories = await prisma.category.findMany({
        skip: args.skip ? args.skip : 0,
        take: args.take ? args.take : 10,
        orderBy: {
            [orderBy]: orderType
        }
    })

    return res.json({ code: 0, message: "Thành công", data: { categories } })

}

const create = async (req, res, next) => {
    if (!req.user) {
        return res.json({ code: 1, message: "Bạn chưa đăng nhập!", data: null })
    }
    const body = req.body

    let category = await prisma.category.create({
        data: {
            name: body.name
        },
    });
    return res.json({ code: 0, message: "Thành công", data: { category } })

}


module.exports = { list, create }
