From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Aug 2018 09:05:41 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: fixup for 64-bit machines
Message-Id: <CAMuHMdVZq3rUTWwQPn9nUmmLw2hDo6L1ifPMPL8Q5dTES5A=ng@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8aa6d2cd-68f9-eae4-cba0-222c1511eb9d@cogentembedded.com>
In-Reply-To: <8aa6d2cd-68f9-eae4-cba0-222c1511eb9d@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, andrey.gusakov@cogentembedded.com, Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Sergei,

On Thu, Aug 30, 2018 at 9:19 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> When trying to use CMT for clockevents on R-Car gen3 SoCs, I noticed that
> the maximum delta (in ns) for the broadcast timer was diplayed as 1000 in
> /proc/timer_list.  It turned out that when calculating it, the driver did
> shift left 1 by 32 (causing what I think was undefined behaviour) getting
> 1 as a result. Using 1UL instead fixed the maximum delta and did even fix
> switching an active clocksource to a CMT channel (which caused the system
> to go non-interactive before).
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against the 'tip.git' repo's 'timers/core' branch.
>
> I am not sure whether the CMT driver was ever used on SH64; on R-Car gen3
> (ARM64) I'm only enabling this driver now, so not sure how urgent is this...
>
>  drivers/clocksource/sh_cmt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: tip/drivers/clocksource/sh_cmt.c
> =================================> --- tip.orig/drivers/clocksource/sh_cmt.c
> +++ tip/drivers/clocksource/sh_cmt.c
> @@ -891,7 +891,7 @@ static int sh_cmt_setup_channel(struct s
>         if (cmt->info->width = (sizeof(ch->max_match_value) * 8))
>                 ch->max_match_value = ~0;
>         else
> -               ch->max_match_value = (1 << cmt->info->width) - 1;
> +               ch->max_match_value = (1UL << cmt->info->width) - 1;
>
>         ch->match_value = ch->max_match_value;
>         raw_spin_lock_init(&ch->lock);

Shouldn't all those fields/variables be changed from "unsigned long" to "u32",
as they really should match the CMT's register sizes?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
