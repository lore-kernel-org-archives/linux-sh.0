From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Jan 2018 09:01:18 +0000
Subject: Re: [PATCH v4 3/9] v4l: platform: Add Renesas CEU driver
Message-Id: <CAMuHMdVCa=mXBLjUpqUgg90=Yqj0_r0cmB5UsOYJvdxw3HSsmw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1515515131-13760-1-git-send-email-jacopo+renesas@jmondi.org>
 <1515515131-13760-4-git-send-email-jacopo+renesas@jmondi.org> <4595365.GB5AfDQQ8V@avalon>
In-Reply-To: <4595365.GB5AfDQQ8V@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, Magnus Damm <magnus.damm@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Laurent,

On Fri, Jan 12, 2018 at 12:12 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday, 9 January 2018 18:25:25 EET Jacopo Mondi wrote:
>> Add driver for Renesas Capture Engine Unit (CEU).
>>
>> The CEU interface supports capturing 'data' (YUV422) and 'images'
>> (NV[12|21|16|61]).
>>
>> This driver aims to replace the soc_camera-based sh_mobile_ceu one.
>>
>> Tested with ov7670 camera sensor, providing YUYV_2X8 data on Renesas RZ
>> platform GR-Peach.
>>
>> Tested with ov7725 camera sensor on SH4 platform Migo-R.
>>
>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> ---
>>  drivers/media/platform/Kconfig       |    9 +
>>  drivers/media/platform/Makefile      |    1 +
>>  drivers/media/platform/renesas-ceu.c | 1648
>> ++++++++++++++++++++++++++++++++++ 3 files changed, 1658 insertions(+)
>>  create mode 100644 drivers/media/platform/renesas-ceu.c
>
> [snip]
>
>> diff --git a/drivers/media/platform/renesas-ceu.c
>> b/drivers/media/platform/renesas-ceu.c new file mode 100644
>> index 0000000..d261704
>> --- /dev/null
>> +++ b/drivers/media/platform/renesas-ceu.c
>> @@ -0,0 +1,1648 @@
>> +// SPDX-License-Identifier: GPL-2.0
>
> It was recently brought to my attention that SPDX headers should use either
> GPL-2.0-only or GPL-2.0-or-later, no the ambiguous GPL-2.0. Could you please
> update all patches in this series ?

IMHO it's a bit premature to do that.
As long as Documentation/process/license-rules.rst isn't updated, I wouldn't
follow this change.

See also https://www.spinics.net/lists/linux-xfs/msg14536.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
