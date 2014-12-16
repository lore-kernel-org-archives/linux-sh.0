From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Dec 2014 12:40:47 +0000
Subject: Re: [PATCH] clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <CAMuHMdUzys9pbEjUybyDP-3=uemLZuP5WgXeyONxGmADUJJL4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141216094854.22639.69181.sendpatchset@w520>
	<54901420.50403@linaro.org>
	<1418731028.WfBPmyK53y@avalon>
	<CANqRtoTpSadrrpeBxA-ym4MZBfhY_BEyTPr_sfau8dZGCKttOQ@mail.gmail.com>
In-Reply-To: <CANqRtoTpSadrrpeBxA-ym4MZBfhY_BEyTPr_sfau8dZGCKttOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

Hi Magnus,

On Tue, Dec 16, 2014 at 12:46 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> Could you please confirm that you've tested both CONFIG_PREEMPT_NONE and
>> CONFIG_PREEMPT with and without the ARM TWD times, and that you've booted to
>> userspace and tested timer broadcast on all CPUs ?
>
> No I have not. I've booted to user space in initramfs with DT-based
> TWD on Multiplatform for r8a7779. Without this fix (and other r8a7779
> TWD bits) I see a lot of breakage. For instance, TWD and SMP boot is
> broken on r8a7779 - both legacy and non-legacy. I have not gotten to
> sh73a0 yet, but I assume it is busted too.

FWIW, I applied this patch, and booted the result successfully and without
any user-visible changes on:
  - koelsch
  - armadillo-multiplatform
  - kzm9g-legacy
  - kzm9g-multiplatform

Armadillo-legacy is broken, and probably won't come back (cfr.
https://lkml.org/lkml/2014/12/2/339).

Kzm9g-reference still hangs at "Calibrating local timer..." (it did work
at some point in the past).

Note that my local tree is based on renesas-drivers-2014-12-08-v3.18,
renesas-devel-20141212-v3.18, and yesterday's upstream, with CCF,
PM domain, TWD, and lots of WIP patches from the kitchen sink applied.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
