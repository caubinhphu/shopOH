const Joi = require('@hapi/joi'); // validate body form

module.exports.loginValidation = data => {
  // create schema obj validate
  let schema = Joi.object({
    account: Joi.string()
      .pattern(/^\w{6,24}$/)
      .required(),
    password: Joi.string()
      .min(4)
      .required()
  });
  // validate => get error
  return schema.validate(data);
};

module.exports.registerValidation = data => {
  // create schema obj validate
  let schema = Joi.object({
    account: Joi.string()
      .pattern(/^\w{6,24}$/)
      .required(),
    password: Joi.string()
      .min(6)
      .required(),
    password2: Joi.ref('password')
  });
  // validate => get error
  return schema.validate(data);
};
