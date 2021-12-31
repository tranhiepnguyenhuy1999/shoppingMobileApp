const bcrypt = require('bcryptjs')
const jwt = require('jsonwebtoken')
const { PrismaClient } = require('@prisma/client')
const ContractService = require('../service/ContractService');
const prisma = new PrismaClient()

const login = async (req, res, next) => {
    const body = req.body
    const user = await prisma.user.findUnique({
        where: {
            email: body.email
        },
    });
    if (!user) {
        return res.json({ code: 100, message: "Email không tồn tại", data: null })
    }

    const valid = await bcrypt.compare(body.password, user.password);
    if (!valid) {
        return res.json({ code: 101, message: "Sai mật khẩu", data: null })
    }

    var option = process.env.APP_EXPIRED
        ? { expiresIn: process.env.APP_EXPIRED }
        : {};
    const token = jwt.sign(
        { id: user.id },
        process.env.APP_SECRET,
        option
    );

    return res.json({ code: 0, message: "Thành công", data: { token } })

}

const register = async (req, res, next) => {
    const body = req.body
    let user = await prisma.user.findUnique({
        where: {
            email: body.email
        },
    });

    if (user) {
        return res.json({ code: 102, message: "Email đã  tồn tại", data: null })
    }

    let cmsUser = await prisma.user.create({
        data: {
            name: body.name,
            phone: body.phone,
            email: body.email,
            password: bcrypt.hashSync(body.password, 10),
        },
    });
    let {contract, coinbase } = ContractService.getContract()
    contract.methods.createUser(
        cmsUser.id,
        cmsUser.name,
        cmsUser.phone,
        cmsUser.email,
        new Date().getTime()
    ).send({
        from: coinbase,
        gas: 235680
    })
        .on('receipt', async function (receipt) {
            console.log(receipt)
            cmsUser = await prisma.user.update({
                where: {
                    id: cmsUser.id
                },
                data: {
                    hash: receipt.transactionHash
                }
            })
            return res.json({ code: 0, message: "Thành công", data: cmsUser })
        })
        .on('error', function (error, receipt) {
            console.log(error)

            return res.json({ code: 90, message: "Có lỗi với hợp đồng thông minh", data: null })
        });
}


module.exports = { login, register }
