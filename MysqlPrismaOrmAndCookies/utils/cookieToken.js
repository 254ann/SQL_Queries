const getJwtToken = require('../helpers/getJwtToken')

const cookieToken = (event, res) =>{
    const token = getJwtToken(event.id);
    const options ={
        expires: new Date(
            Date.now() + 3*24*60*60*1000
        ),
        httpOnly: true
    }
    
    res.status(200).cookie('token', token, options).json({
        success:true,
        token,
        event
    })
}

module.exports = cookieToken;