// Numbers
// 包含了 Int, Double, Decimal, NumberFormat
import Foundation
// https://developer.apple.com/documentation/foundation/numbers_data_and_basic_values
// Number

/*
 # Int
 // 1. Int 之间类型转换
 let x = 100
 let y = Int8(x)
 // y == 100
 // let z = Int8( x * 10 )
 // Error: Not enough bits to represent the given value
 // 2. 能否顺序转换
 let x2 = Int8(exactly: 100) // 能够转换：x2 == 100
 let y2 = Int8(exactly: 1_000) // 无法转换： y2 == nil
 // 3. 总是转换，无视溢出
 let x3 = Int8(clamping: 500) // 127
 let y4 = UInt(clamping: -500) // 0
 // 4. 通过位来转换
 // 从高位转为低位时，只有对应低位被使用
 let p:Int16 = -500 // 11111110_00001100
 let q = Int8(truncatingIfNeeded: p) // 00001100 == 12
 // 从低精度转高精度时，高位被符号位填充
 let u:Int8 = 21 // 00010101
 let v = Int16(truncatingIfNeeded: u) // 00000000_00010101
 
 let w:Int8 = -21 // 11101011
 let w2 = UInt16(truncatingIfNeeded: w) // 11111111_11101011 = 65515
 // * 字符串转数字
 let x5 = Int("123")
 // 如果字符串格式错误，或者无法使用 10 进制表示，则结果为 nil
 Int("  100") // 包括空格
 Int("21-50") // 格式错误
 Int("ff6600") // 超出范围
 Int("10000000000000000000000000") // 超出范围
 // 字符串精度转换，同样，如果格式错误，或者无法转换，结果都为 nil
 let x6 = Int("-123", radix:8) // -83
 let y6 = Int("+123", radix:8) // 83
 let z6 = Int("07b", radix:16) // 123
 // =============== 随机数
 // 指定范围随机
 Int.random(in: 1..<100)
 Int.random(in: 1...100)
 // 指定种子以生成随机数 random(in:using:)
 // ## Integer Operators
 // + - * / %
 // 赋值运算符 += *= /= %=
 // 位运算符 &+, &-, &*, &+=, &-=, &*=
 // 位操作符 &, &=, |, |=, ^, ^=, ~
 // 位移 <<, <<=, >>, >>=, &<<, &<<=, &>>, &>>=
 // 反转值 - +
 // 比较运算符
 // 范围运算符 ..<, ...
 // ## 执行运算时，检测是否产生溢出
 let x7 = Int.max - 2 // 9223372036854775805
 let (y7, over) = x7.addingReportingOverflow(12/2)
 y7 // -9223372036854775805
 over // true
 // ======== 双宽度计算
 let x8:UInt8 = 100 // 01100100
 let y8:UInt8 = 20 //  00010100
 let result8 = x8.multipliedFullWidth(by: y8) // 2000 本来是超过 UInt8 范围
 // 100 * 20 = 2000 = 0111 1101 0000
 // high:7, low:208
 // 7 = 0b0111, 208 = 0b11010000
 // ## Finding the Sign（符号） and Magnitude（值）
 let x9 = -200
 x9.magnitude // UInt 绝对值
 x9.signum() // -1 负数，0 其它，1 正数
 
 // 常量
 Int.min //
 Int.max // 9223372036854775807
 Int.isSigned // true 是否为有符号类型
 
 // ## Working with Byte Order
 
 y8.byteSwapped // 20 = 0b00010100
 
 // ## Working with Binary Representation
 y8.bitWidth // 8
 y8.words // UInt8.Words
 y8.nonzeroBitCount // 2
 y8.leadingZeroBitCount // 3
 y8.trailingZeroBitCount // 2
 
 // ## Encoding and Decoding Values
 */

/*
 # Double
 
 var a:Double = 5
 let result = a.addingProduct(2, 3) // 11 = 5 + 2 * 3 , a is still 5
 a.addProduct(2, 2) // a is 9
 
 // 平方根
 var x1:Double = 9
 x1.squareRoot() // 3, x1 的值不会变
 x1.formSquareRoot() // 同时修改 x1 的值
 
 // 余数
 var x2:Double = 99
 x2.remainder(dividingBy: 5) // -1 ,计算公式为 x == y * q + r，其中 q 取最近 x / y，因此 99 = 5 * 20 + -1
 var q = ( x2 / 5).rounded(.toNearestOrEven) // q = 20
 x2 // 99
 x2.formRemainder(dividingBy: 5) // -1
 x2 // -1
 
 x2 = 99
 x2.truncatingRemainder(dividingBy: 5) // 4 计算公式 x == y * q + r
 q = ( x2 / 5).rounded(.towardZero) // 计算方式不同 q = 19
 
 // 取反
 var x3 = 99
 x3.negate() // -99 会修改原值
 x3.negate() // 99
 
 // 4舍5入
 // 可以指定规则，像上面的余数一样
 (5.2).rounded() // 5
 (5.5).rounded() // 6
 (-5.2).rounded() // -5
 (-5.5).rounded() // -6
 
 // ## 比较
 let x4 = 15.0
 x4.isEqual(to: 15.0) // true
 x4.isEqual(to: .nan) // false
 x4 == 15.0 // true
 Double.nan.isEqual(to: .nan) // false
 // 其它的比较运行方法有 isLess, isLessThanOrEqualTo,
 // isTotallyOrdered
 var numbers = [2.5, 21.35, .nan, -9.5]
 numbers.sort { !$1.isTotallyOrdered(belowOrEqualTo: $0)}
 // numbers == [-9.5, 2.5, 3.0, 21.25, NaN]
 
 // minimum, minimumMagnitude, maximum, maximumMagnitude
 Double.minimum(10.0, -25.0) // -25
 Double.minimum(10.0, .nan) // 10
 Double.minimum(.nan, -25.0) // -25
 Double.minimum(.nan, .nan) // nan
 
 Double.minimumMagnitude(10.0, -25.0) // 10
 Double.minimumMagnitude(10.0, .nan) // 10
 Double.minimumMagnitude(.nan, -25.0) // -25
 Double.minimumMagnitude(.nan, .nan) // nan
 
 // 符号与值
 (-25.0).magnitude // 25
 // 不要使用下面的这个方法来检测一个数是正负
 // x.sign == .minus 与 x < 0 不等价
 (-25.0).sign // .minus, .plus
 (-0.0).sign // minus
 (Double.nan).sign // plus
 
 // 查询 —— 好像都没有啥用处
 var x5 = -5.3
 x5.ulp // 8.881784197001252e-16 The unit in the last place of this value. ????
 x5.significand // 浮点数的有效位数 1.325
 x5.exponent // 2 浮点数的指数
 x5.nextUp // -5.299999999999999 小于此值的最大值
 x5.nextDown // -5.300000000000001 大于此值的最小值
 x5.binade // -4 相同的符号，最接近的指数
 
 // 常量
 Double.pi // 3.14159265358979
 Double.infinity
 let x6 = Double.greatestFiniteMagnitude
 let y6 = x6 * 2
 
 // 状态查询
 // isZero, isFinite, isInfinite, isNan, isSignalingNan
 // isNormal, isSubnormal, isCanonical
 */
