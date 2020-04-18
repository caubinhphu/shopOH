const xlsx = require('xlsx');

let wb = xlsx.readFile('test.xlsx', {
  cellDates: true,
});

let ws = wb.Sheets['Sheet1'];

let json = xlsx.utils.sheet_to_json(ws);
// console.log(json);

let data = json.map((record) => {
  delete record['name'];
  record['name'] = 'Xuân Hòa\nSông Cầu\nPhú Yên';
  return record;
});

let newWb = xlsx.utils.book_new();
let newWs = xlsx.utils.json_to_sheet(data);

xlsx.utils.book_append_sheet(newWb, newWs, 'Data');
xlsx.writeFile(newWb, 'output.xlsx', {
  cellDates: true,
});
