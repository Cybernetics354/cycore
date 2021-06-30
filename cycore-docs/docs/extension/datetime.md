---
title: DateTimeExtension
---

`DateTimeExtension` Extension for `DateTime` data type.

## Utility
### tanggal()
**-> String**<br />
`bool shortMonth = true`<br />
Convert `DateTime` to `String` date, example: (2 Januari 2020) you can also use shortMonth by using `shortMonth` parameter.<br />
*non-nullable*

### compareDateTime()
**-> bool**<br />
`DateTime? compareTime`
`bool withYear = true`
`bool withMonth = true`
`bool withDay = true`
`bool withHour = false`
`bool withMinute = false`
`bool withSecond = false`
`bool withMillisecond = false` <br />
Compare if current datetime is same with given datetime, by default it use current time, there are several parameters, `compareTime` to define the specific datetime to compare with, and the other's is only to including that or not.<br />
*non-nullable*

### getTimeStamp()
**-> String**<br />
`bool withHourAndMinutes = true`
`bool separator = ", "`<br />
Convert datetime to timestamp format, useful for display date on UI, you can include the hour and minute with `withHourAndMinutes` parameter, and also change the separator with `separator` parameter.<br />
*non-nullable*

### getDifference()
**-> DateTimeDifference**<br />
`DateTime? compare`<br />
Convert `DateTime` to `DateTimeDifference`, by default comparing with `DateTime.now()`, or you can define datetime on `compare` parameter instead.<br />
*non-nullable*

<br />

#### Maintained By corecybernetics354@gmail.com