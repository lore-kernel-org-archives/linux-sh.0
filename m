From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 Jul 2014 09:46:47 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Lager: Correct I2C bus for VDD MPU regulator
Message-Id: <CANqRtoQKhp=rvrukpD=K5SiXgXzycayorcpSkxgVd4+Kj2eKxw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53B5F327.5040301@renesas.com>
In-Reply-To: <53B5F327.5040301@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram, Khiem-san, everyone,

On Thu, Jul 10, 2014 at 11:40 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> Wolfram, can you give us your opinion about this patch? Does it
>> improve our I2C software support on Lager?
>
> Yes, it does. Khiem-san is right, IIC3 is dedicated to DVFS, so it
> should be activated. From that point of view:
>
> Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>

Good - thanks for confirming!

> However, I sadly missed commit e489c2a9bc82713167d9f721ca764f4b0d37e543
> ("ARM: shmobile: lager: enable i2c devices") which enables i2c cores for
> all busses. I do like the iic cores better because of SMBUS_QUICK
> support and DMA capability (although not yet supported). i2c cores have
> slave support as an advantage, yet they can be switched in when that is
> actually needed (still needs to be implemented, too). So, it might make
> sense to switch all busses to iic, I'd say.

Yes, I agree about your observation. If you have time, can you cook up
a patch to improve the situation?

Best,

/ magnus
