From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Date: Wed, 05 Jul 2017 20:44:50 +0000
Subject: Re: [PATCH v2 0/4] i2c: pca-platform: additional improvements
Message-Id: <6ff4113ecb49476081826306d7e7d9c9@svr-chch-ex1.atlnz.lc>
List-Id: <linux-sh.vger.kernel.org>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
 <CAHp75VfKhTkBZfuDdp=hkZMkXyBmMdYwrSNLmO-PyBz==NtrRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-i2c <linux-i2c@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/07/17 23:49, Andy Shevchenko wrote:
> On Wed, Jul 5, 2017 at 1:13 PM, Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
>> This series addresses some of the points identified by Andy. The series is
>> based on top of i2c/for-next. 2 of the patches from v1 have already been
>> applied so I've dropped them from this version.
>>
>> I have compile tested patch 1/1 but I don't have access to sh hardware
>> to actually test the changes on.
> 
> 
> Entire series looks good to me:
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Further improvement is to get timeout value via device properties API
> and get rid of legacy platform data completely. This can be done in
> further series.

Actually the timeout can probably go now. The two in-tree platforms that 
set it via platform_data set it to HZ which is (now) the default.

> 
>>
>> Chris Packham (4):
>>    sh: sh7785lcr: add GPIO lookup table for i2c controller reset
>>    i2c: pca-platform: unconditionally use devm_gpiod_get_optional
>>    i2c: pca-platform: use device_property_read_u32
>>    i2c: pca-platform: drop gpio from platform data
>>
>>   arch/blackfin/mach-bf561/boards/acvilon.c |  1 -
>>   arch/sh/boards/board-sh7785lcr.c          | 11 +++++++++-
>>   drivers/i2c/busses/i2c-pca-platform.c     | 34 +++++++++----------------------
>>   include/linux/i2c-pca-platform.h          |  3 ---
>>   4 files changed, 20 insertions(+), 29 deletions(-)
>>
>> --
>> 2.13.0
>>
> 
> 
> 

