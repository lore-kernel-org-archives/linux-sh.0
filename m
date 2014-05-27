From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 May 2014 08:04:16 +0000
Subject: Re: [PATCH v3] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <CAMuHMdUO+avQtRQ2zwqiCZwtnGubC3M-7+VHR4NXjft4P4FDnw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1400781734-19002-1-git-send-email-geert+renesas@glider.be>
	<CANqRtoQk1=ZVJAqio4Oo-2NSO2qVo=xM0sUCDL_sMz1+zyOLPQ@mail.gmail.com>
In-Reply-To: <CANqRtoQk1=ZVJAqio4Oo-2NSO2qVo=xM0sUCDL_sMz1+zyOLPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Mike Turquette <mturquette@linaro.org>, SH-Linux <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hi Magnus,

On Tue, May 27, 2014 at 3:02 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Fri, May 23, 2014 at 3:02 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>
>> The MSTP[SC]R registers have clock stop bits, not clock enable bits. The
>> bit value should thus be inverted in the is_enabled() operation.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> ---
>> v3:
>>   - This depends on commit 3c90c55dcde745bed81f6447f24ba96bda43d984
>>     ("drivers: sh: compile drivers/sh/pm_runtime.c if
>>     ARCH_SHMOBILE_MULTI"), which has entered mainline in v3.15-rc6.
>
> Thanks for resubmitting this fix. Do you intend to get this included
> in v3.15 (seems unlikely) or is your target v3.16?

3.16 is OK. The only ill effect is that some clocks may be enabled,
while they're
not needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
