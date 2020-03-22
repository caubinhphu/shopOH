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
      .pattern(/^\d{9,12}$/)
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
