From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 03 Sep 2013 07:24:35 +0000
Subject: Re: [RFC 04/10] i2c: rcar: modify I2C driver
Message-Id: <CAO3366weE0a6eNS9D-07rxZkvLmc0732Nwqqof5ak_aXEe8pBA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377866264-21110-5-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1377866264-21110-5-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 2, 2013 at 3:22 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 30 August 2013 14:37:38 Ulrich Hecht wrote:
>> --- a/include/linux/i2c/i2c-rcar.h
>> +++ b/include/linux/i2c/i2c-rcar.h
>> @@ -5,6 +5,10 @@
>>
>>  struct i2c_rcar_platform_data {
>>       u32 bus_speed;
>> +     u32 flags;
>> +#define I2C_RCAR_FLAGS_ICCCR_MASK    (0xF << 0)
>> +#define I2C_RCAR_FLAGS_ICCCR_IS_2BIT (0 << 0) /* default */
>> +#define I2C_RCAR_FLAGS_ICCCR_IS_3BIT (1 << 0)
>
> That looks like an IP core property to me, not a platform property. Shouldn't
> it be added to a platform_device_id table in the driver instead of being
> passed through platform data ?

Dung has already posted a new version of this patch that solves this
differently, but I haven't had time to integrate it yet:

http://www.spinics.net/lists/kernel/msg1595839.html

CU
Uli
