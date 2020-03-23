module.exports.myEncode = data => {
  return data
    .split('')
    .map(char => String.fromCharCode(char.charCodeAt(0) + 4))
    .join('');
};

module.exports.myDecode = data => {
  return data
    .split('')
    .map(char => String.fromCharCode(char.charCodeAt(0) - 4))
    .join('');
};
