From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 May 2014 06:47:29 +0000
Subject: Re: [PATCH v2 12/17] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <CAMuHMdU3itD-xfTfF==9ODvziF-EzdwLqEuh7-n=qhu3jA+JbQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397565253-22741-13-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1397565253-22741-13-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, May 13, 2014 at 12:20 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 15 April 2014 14:34:08 Geert Uytterhoeven wrote:
>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>
>> The MSTP[SC]R registers have clock stop bits, not clock enable bits. The
>> bit value should thus be inverted in the is_enabled() operation.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> ---
>> This depends on the actual fixes, so either we need Mike's ack, or this has
>> to wait until the fixes have landed in mainline.
>
> What's the status of this patch ? Do you still carry it in your tree and plan
> to push it upstream at some point ?

Yes, I still have it locally.

It depends on "[PATCH v4] drivers: sh: compile drivers/sh/pm_runtime.c
if ARCH_SHMOBILE_MULTI", so we have to wait until that one hits
mainline.

I think the only ill effects of not having it is that some clocks may not be
disabled properly?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
