const jwt = require('jsonwebtoken')
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()


function getTokenPayload(token) {
  return jwt.verify(token, process.env.APP_SECRET);
}

async function getUserInfoFromToken(rawToken) {
  if (rawToken) {
    try {
      const token = rawToken.replace('Bearer ', '');
      if (!token) {
        throw new Error('No token found');
      }
      const { id } = getTokenPayload(token);

      const user = await prisma.user.findUnique({
        where: {
          id: id,
        },
      });

      return user;
    } catch (error) {
      console.log(error)
      return null;
    }
  } else {
    return null;
  }
}
module.exports = {
  getUserInfoFromToken
};