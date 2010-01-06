From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Jan 2010 04:57:09 +0000
Subject: Re: [PATCH] MMC: hardware abstraction for CNF area
Message-Id: <aec7e5c31001052057u68deaab2y1d63a2e881ef94a3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100105050914.32264.762.sendpatchset@rxone.opensource.se>
	 <20100106002158.GM4274@sortiz.org>
In-Reply-To: <20100106002158.GM4274@sortiz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, ian@mnementh.co.uk, linux-sh@vger.kernel.org

Hi Samuel,

On Wed, Jan 6, 2010 at 9:21 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> On Tue, Jan 05, 2010 at 02:09:14PM +0900, Magnus Damm wrote:
>> From: Ian Molton <ian@mnementh.co.uk>
>>
>> This patch abstracts out the CNF area code from tmio_mmc which
>> is not present in all hardware that can use this driver. This
>> is required so that we can support non-toshiba based hardware.
>>
>> ASIC3 support by Philipp Zabel
>>
>> [ Magnus Damm: extracted patch from git.mnementh.co.uk, tried
>> =A0 to apply on top of current linux-2.6 but got rejects due to
>> =A0 -mm patch 14f1b75b1d31673d7ab6ac6d2f8fe7f23c705229, solved
>> =A0 conflict by hand, regenerated patch and posted to lkml ]
> Thanks for taking care of that.

No worries!

> I wish I could take this patch straight away, but I have some objections,=
 see
> below:
>
>> + =A0 =A0 .suspend =A0 =A0 =A0 =3D asic3_mmc_disable,
>> + =A0 =A0 .resume =A0 =A0 =A0 =A0=3D asic3_mmc_enable,
> Why are we moving from enable/disable to resume/suspend ?
> It makes sense from a naming point of view, but that should be in a separ=
ate
> patch.

I agree.

>> +static const struct resource t7l66xb_mmc_resources[];
> Could we simply move the t7l66xb_mmc_resources[] definition here instead ?

Yep, makes sense.

>> --- /dev/null
>> +++ work/drivers/mfd/tmio_core.c =A0 =A0 =A02010-01-05 13:27:31.00000000=
0 +0900
>> @@ -0,0 +1,62 @@
>> +/*
>> + * Toshiba TC6393XB SoC support
> Bogus comment.

Yes.

>> + * Copyright(c) 2009 Ian Molton <spyro@f2s.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/mfd/tmio.h>
>> +
>> +static int shift;
> That I dont like. Carry the shift as a function argument, because there i=
s no
> reason to have a static variable here.

Yeah, this part of the code is pretty darn ugly. Will fix.

> In fact, we could even move this code to tmio_mmc.c and export the symbols
> from there. The tmio_mmc code know the bus shift, doesnt it ?

The purpose of this patch is to make tmio_mmc work with a single I/O
memory window. So this code was intentionally moved out of tmio_mmc. I
don't care so much though, my original patch kept support for two
windows in tmio_mmc but Ian preferred to make the tmio_mmc driver work
with a single window only. Perhaps Ian has something to say?

I'll just pass the shift as a function argument for now.

>> --- 0001/drivers/mmc/host/tmio_mmc.c
>> +++ work/drivers/mmc/host/tmio_mmc.c =A02010-01-05 13:28:07.000000000 +0=
900
>> @@ -46,7 +46,9 @@ static void tmio_mmc_set_clock(struct tm
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk |=3D 0x100;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 sd_config_write8(host, CNF_SD_CLK_MODE, clk >> 22);
>> + =A0 =A0 if (host->set_no_clk_div)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->set_no_clk_div(host->pdev, (clk>>22) & 1=
);
>> +
> You either need a backup path or make the set_no_clk_div() implementation
> mandatory. IOW, we should at least call tmio_core_mmc_clk_div() if
> set_no_clk_div() is not defined. Or then if you assume that all tmio driv=
ers
> must implement those hooks, then return if it's not there. I would prefer=
 the
> former option though as that would allow me to split this patch into what=
 I
> see as .33 material (tmio_mmc.[ch], tmio_core.c [that I would rather see =
moved
> to tmio_mmc.c], and tmio.h)

The hardware driven by the SuperH SDHI driver lacks support for the
second memory window, so ->set_no_clk_div() is set to NULL in that
case. And falling back on tmio_core_mmc_clk_div() will only work on
hardware with two memory windows, so that idea will break SuperH SDHI.
It may be a good idea with dummy nop functions to avoid the if case,
but none of these functions are called in any hot path so from my
point of view it's ok as is.

I agree that a lot of code in a single patch is far from optimal. Feel
free to break out the patch in any way you'd like. My original patches
were broken out, but for some reason this all-in-one approach was
chosen.

I don't have access to any hardware except SuperH SDHI boards, but I'm
pretty sure Ian and Phillip has tested this patch on whatever hardware
they have available. So it may make sense to keep the code as is to
avoid breakage.

>> @@ -475,8 +478,8 @@ static int tmio_mmc_suspend(struct platf
>> =A0 =A0 =A0 ret =3D mmc_suspend_host(mmc, state);
>>
>> =A0 =A0 =A0 /* Tell MFD core it can disable us now.*/
>> - =A0 =A0 if (!ret && cell->disable)
>> - =A0 =A0 =A0 =A0 =A0 =A0 cell->disable(dev);
>> + =A0 =A0 if (!ret && cell->suspend)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cell->suspend(dev);
> That sort of change doesnt belong to that patch, unless I'm missing somet=
hing.

I agree.

>> + =A0 =A0 /* Callbacks for clock / power control */
>> + =A0 =A0 void (*set_pwr)(struct platform_device *host, int state);
>> + =A0 =A0 void (*set_no_clk_div)(struct platform_device *host, int state=
);
> The name is a bit misleading, imo. Wouldn't set_clk_div() be more appropr=
iate?

Yep, will go with ->set_clk_div().

>> +#define CNF_CMD =A0 =A0 0x04
>> +#define CNF_CTL_BASE =A0 0x10
>> +#define CNF_INT_PIN =A00x3d
>> +#define CNF_STOP_CLK_CTL 0x40
>> +#define CNF_GCLK_CTL 0x41
>> +#define CNF_SD_CLK_MODE 0x42
>> +#define CNF_PIN_STATUS 0x44
>> +#define CNF_PWR_CTL_1 0x48
>> +#define CNF_PWR_CTL_2 0x49
>> +#define CNF_PWR_CTL_3 0x4a
>> +#define CNF_CARD_DETECT_MODE 0x4c
>> +#define CNF_SD_SLOT 0x50
>> +#define CNF_EXT_GCLK_CTL_1 0xf0
>> +#define CNF_EXT_GCLK_CTL_2 0xf1
>> +#define CNF_EXT_GCLK_CTL_3 0xf9
>> +#define CNF_SD_LED_EN_1 0xfa
>> +#define CNF_SD_LED_EN_2 0xfe
>> +
>> +#define =A0 SDCREN 0x2 =A0 /* Enable access to MMC CTL regs. (flag in C=
OMMAND_REG)*/
>> +
>> +#define sd_config_write8(base, shift, reg, val) \
>> + =A0 =A0 tmio_iowrite8((val), (base) + ((reg) << (shift)))
>> +#define sd_config_write16(base, shift, reg, val) \
>> + =A0 =A0 tmio_iowrite16((val), (base) + ((reg) << (shift)))
>> +#define sd_config_write32(base, shift, reg, val) \
>> + =A0 =A0 do { \
>> + =A0 =A0 tmio_iowrite16((val), (base) + ((reg) << (shift))); \
>> + =A0 =A0 tmio_iowrite16((val) >> 16, (base) + ((reg + 2) << (shift))); \
>> + =A0 =A0 } while (0)
> By implementing the tmio_core API in tmio_mmc.c, you wouldnt need to rede=
fine
> those.

Right, but we want to code to be broken out of tmio_mmc so putting it
back does not make sense.

Thanks a lot for your help. I'll submit a patch on top of this one
with fixes. Feel free to apply it on top or roll it in.

Cheers,

/ magnus
