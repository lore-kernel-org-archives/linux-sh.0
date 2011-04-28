From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Apr 2011 01:06:38 +0000
Subject: Re: [PATCH] i2c: i2c-sh_mobile bus speed platform data
Message-Id: <BANLkTi=YbtWYKLdcEkv6TDRfm-BbXGXa4w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110421132254.3725.84300.sendpatchset@t400s>
	<20110427221357.GA12273@verge.net.au>
In-Reply-To: <20110427221357.GA12273@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Horman <horms@verge.net.au>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, lethal@linux-sh.org, ben-linux@fluff.org, khali@linux-fr.org

On Thu, Apr 28, 2011 at 7:14 AM, Simon Horman <horms@verge.net.au> wrote:
> Hi Magnus,
>
> On Thu, Apr 21, 2011 at 10:22:54PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add support to the i2c-sh_mobile driver for setting
>> the I2C bus speed using platform data.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>> =A0drivers/i2c/busses/i2c-sh_mobile.c | =A0 13 +++++++++++--
>> =A0include/linux/i2c-sh_mobile.h =A0 =A0 =A0| =A0 10 ++++++++++
>> =A02 files changed, 21 insertions(+), 2 deletions(-)
>>
>> --- 0013/drivers/i2c/busses/i2c-sh_mobile.c
>> +++ work/drivers/i2c/busses/i2c-sh_mobile.c =A0 2011-04-21 20:20:23.0000=
00000 +0900
>> @@ -32,6 +32,7 @@
>> =A0#include <linux/clk.h>
>> =A0#include <linux/io.h>
>> =A0#include <linux/slab.h>
>> +#include <linux/i2c-sh_mobile.h>
>>
>> =A0/* Transmit operation: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0*/
>> @@ -117,7 +118,7 @@ struct sh_mobile_i2c_data {
>> =A0 =A0 =A0 struct device *dev;
>> =A0 =A0 =A0 void __iomem *reg;
>> =A0 =A0 =A0 struct i2c_adapter adap;
>> -
>> + =A0 =A0 unsigned long bus_speed;
>> =A0 =A0 =A0 struct clk *clk;
>> =A0 =A0 =A0 u_int8_t icic;
>> =A0 =A0 =A0 u_int8_t iccl;
>> @@ -205,7 +206,7 @@ static void activate_ch(struct sh_mobile
>> =A0 =A0 =A0 =A0* We also round off the result.
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 num =3D i2c_clk * 5;
>> - =A0 =A0 denom =3D NORMAL_SPEED * 9;
>> + =A0 =A0 denom =3D pd->bus_speed * 9;
>
> I believe that on the sh73a0 and so far only the sh73a0
> denom needs to be doubled.

Uhm, I don't think this patch is specific to any SoC type. It may of
course be used on sh73a0 to adjust the denom value, but setting the
I2C bus speed is something that can be used on any SoC. So I'd say
that this is a fairly generic feature.

Thanks,

/ magnus
