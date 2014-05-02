From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 02 May 2014 17:10:58 +0000
Subject: Re: [PATCH v4 00/15] Renesas CMT, MTU2 and TMU platform cleanups
Message-Id: <2729086.8bkruH6OHa@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1398163856-7379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398163856-7379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 02 May 2014 05:49:41 Geert Uytterhoeven wrote:
> On Fri, May 2, 2014 at 3:40 AM, Simon Horman <horms@verge.net.au> wrote:
> >> I've attached a debugging patch to this e-mail. Could you please boot the
> >> BockW board with that patch applied before (working) and after (broken)
> >> applying "ARM: shmobile: r8a7778: Switch to new style TMU device" and
> >> provide me with the two boot logs ?
> > 
> > Sure, please see the attached logs.
> 
> Relevant part of the difference:
> 
>  sh_tmu sh_tmu.0: MSTP clock 16 @ffc80030
> -sh_tmu sh_tmu.0: phys base 0xffd80008 virt base d0964008 size 12
> +sh_tmu sh_tmu.0: phys base 0xffd80000 virt base d0964000 size 48
>  sh_tmu sh_tmu.0: ch0: base d0964008
>  sh_tmu sh_tmu.0: ch0: used for clock events
>  sh_tmu sh_tmu.0: ch0: used for periodic clock events
>  sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
> -sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
> +sh_tmu sh_tmu.0: ch0: writing TSTR @d0964004
>  sh_tmu sh_tmu.0: ch0: clock rate is 16666666
>  sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
> +sh_tmu sh_tmu.0: ch0: writing TSTR @d0964004
>  sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
> +sh_tmu sh_tmu.0: ch0: writing TSTR @d0964004
>  sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
> -sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
> -sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
> -sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
> -sh_tmu sh_tmu.0: ch0: requesting IRQ 64 for clock event device
> 
> irq64 (good)
> 
> -sh_tmu sh_tmu.1: MSTP clock 15 @ffc80030
> -sh_tmu sh_tmu.1: phys base 0xffd80014 virt base d0966014 size 12
> -sh_tmu sh_tmu.1: ch1: base d0966014
> -sh_tmu sh_tmu.1: ch1: failed to get irq
> +sh_tmu sh_tmu.0: ch0: writing TSTR @d0964004
> +sh_tmu sh_tmu.0: ch0: requesting IRQ 96 for clock event device
> 
> irq96 (bad)

Indeed.

My bad. *sigh*

Simon, I've sent v5 of 12/15. This should fix the BockW boot issue. I assume 
you won't have time to apply the series before leaving for holidays (of 
course, if you can, I won't complain :-)). Do you think there will still be 
time to get it in v3.16 when you'll return ?

> +sh_tmu sh_tmu.0: ch1: base d0964014
> +sh_tmu sh_tmu.0: ch1: used as clock source
> +sh_tmu sh_tmu.0: ch1: reading TSTR @d0964004
> +sh_tmu sh_tmu.0: ch1: writing TSTR @d0964004
> +sh_tmu sh_tmu.0: ch1: clock rate is 16666666
> +sh_tmu sh_tmu.0: ch1: reading TSTR @d0964004
> +sh_tmu sh_tmu.0: ch1: writing TSTR @d0964004
> +Switched to clocksource sh-tmu.0

-- 
Regards,

Laurent Pinchart

