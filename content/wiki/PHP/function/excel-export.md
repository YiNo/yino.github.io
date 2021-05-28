## excel 导出

```php
$PHPExcel       = new PHPExcel(); //实例化PHPExcel类，类似于在桌面上新建一个Excel表格
$PHPSheet       = $PHPExcel->getActiveSheet(); //获得当前活动sheet的操作对象

$PHPSheet->setTitle('卡号'); //给当前活动sheet设置名称

$PHPSheet->setCellValue('A1','订单号')
->setCellValue('B1','手机号')
->setCellValue('C1','是否靓号')
->setCellValue('D1','是否虚拟号')
->setCellValue('E1','卡号等级');


$order  =   D('order')->select();
foreach ($order as $key => $val){

}

$PHPSheet->setCellValue('A2','张三')->setCellValue('B2','50');
//给当前活动sheet填充数据，数据填充是按顺序一行一行填充的，假如想给A1留空，可以直接setCellValue(‘A1’,’’);
//$PHPSheet->setCellValue('A2','张三')->setCellValue('B2','50');

$PHPWriter = PHPExcel_IOFactory::createWriter($PHPExcel,'Excel2007');//按照指定格式生成Excel文件，‘Excel2007’表示生成2007版本的xlsx，‘Excel5’表示生成2003版本Excel文件

header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');//告诉浏览器输出07Excel文件
//header('Content-Type:application/vnd.ms-excel');//告诉浏览器将要输出Excel03版本文件
header('Content-Disposition: attachment;filename="card_import_template.xlsx"');//告诉浏览器输出浏览器名称
header('Cache-Control: max-age=0');//禁止缓存
$PHPWriter->save("php://output");
```