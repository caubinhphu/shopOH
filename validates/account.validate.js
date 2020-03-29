const Joi = require('@hapi/joi'); // validate body form

module.exports.profileValidate = data => {
  let schema = Joi.object({
    username: Joi.string()
      .pattern(/^[^<>/`~!@#$%^&*(){}[\]\-=;:'"|?+_\\]+$/)
      .max(100)
      .allow(''),
    gender: Joi.string().pattern(/(0|1|2)/),
    birthday: Joi.date()
      .min('1-1-1900')
      .max('now')
      .allow(''),
    phone: Joi.string()
      .pattern(/^\d+$/)
      .pattern(
        /^(086|09[6|7|8]|03[2|3|4|5|6|7|8|9]|089|09[0|3]|07[0|6|7|8|9]|088|09[1|4]|08[1|2|3|4|5]|092|056|058|099|059)/
      )
      .length(10)
      .allow('')
  });

  return schema.validate(data);
};

module.exports.changePassValidate = data => {
  let schema = Joi.object({
    oldPassword: Joi.string().required(),
    newPassword: Joi.string()
      .min(6)
      .required(),
    newPassword2: Joi.ref('newPassword')
  });

  return schema.validate(data);
};

module.exports.addressValidate = data => {
  let schema = Joi.object({
    name: Joi.string()
      .pattern(/^[^<>/`~!@#$%^&*(){}[\]\-=;:'"|?+_\\]+$/)
      .max(100)
      .min(1)
      .required(),
    phone: Joi.string()
      .pattern(/^\d+$/)
      .pattern(
        /^(086|09[6|7|8]|03[2|3|4|5|6|7|8|9]|089|09[0|3]|07[0|6|7|8|9]|088|09[1|4]|08[1|2|3|4|5]|092|056|058|099|059)/
      )
      .length(10)
      .required(),
    tinh: Joi.string()
      .pattern(/^[^<>/`~!@#$%^&*(){}[\]=;:"|?+_\\]+$/)
      .required(),
    huyen: Joi.string()
      .pattern(/^[^<>/`~!@#$%^&*(){}[\]=;:"|?+_\\]+$/)
      .required(),
    xa: Joi.string()
      .pattern(/^[^<>/`~!@#$%^&*(){}[\]=;:"|?+_\\]+$/)
      .required(),
    homenum: Joi.string()
      .pattern(/^[^<>/`~!@#$%^&*(){}[\]=;:"|?+_\\]+$/)
      .required()
  });

  return schema.validate(data);
};
