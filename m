From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Feb 2015 08:57:09 +0000
Subject: Re: [PATCH v2] sh-pfc: add R8A7794 PFC support
Message-Id: <CAMuHMdX-U-JdWhsg9qiA8okKOjQxqLmusah3kcJbzSjzvhbmnA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5262485.fuAdzVmykl@wasted.cogentembedded.com>
	<1974835.KMEIIiPVsr@avalon>
In-Reply-To: <1974835.KMEIIiPVsr@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Sun, Feb 15, 2015 at 5:06 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- /dev/null
>> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
>> @@ -0,0 +1,3989 @@
>> +/*
>> + * r8a7794 processor support - PFC hardware block.
>> + *
>> + * Copyright (C) 2014 Renesas Electronics Corporation
>> + * Copyright (C) 2015 Renesas Solutions Corp.
>> + * Copyright (C) 2015 Cogent  Embedded, Inc., <source@cogentembedded.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2
>> + * as published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/platform_data/gpio-rcar.h>
>> +
>> +#include "core.h"
>> +#include "sh_pfc.h"
>> +
>> +#define CPU_ALL_PORT(fn, sfx)                                                \
>> +     PORT_GP_32(0, fn, sfx),                                         \
>> +     PORT_GP_32(1, fn, sfx),                                         \
>> +     PORT_GP_32(2, fn, sfx),                                         \
>> +     PORT_GP_32(3, fn, sfx),                                         \
>> +     PORT_GP_32(4, fn, sfx),                                         \
>> +     PORT_GP_32(5, fn, sfx),                                         \
>> +     PORT_GP_32(6, fn, sfx)
>
> If I'm not mistaken port GP1 has 26 pins only, GP5 28 pins and GP6 26 pins.

That's correct.

If that has to be reflected in the CPU_ALL_PORT() macro, a few existing pfc
drivers should be modified, too:
  - on r8a7790, port GP1 and GP2 have 30 pins only,
  - on r8a7791, port GP1 has 26 pins only.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
