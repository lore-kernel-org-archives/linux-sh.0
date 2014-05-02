From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 02 May 2014 03:49:41 +0000
Subject: Re: [PATCH v4 00/15] Renesas CMT, MTU2 and TMU platform cleanups
Message-Id: <CAMuHMdVZ=D9qnLN-1FvjttFRNLRYphCxeVvS3cnHQZ+8b4E0tw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398163856-7379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398163856-7379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 2, 2014 at 3:40 AM, Simon Horman <horms@verge.net.au> wrote:
>> I've attached a debugging patch to this e-mail. Could you please boot the
>> BockW board with that patch applied before (working) and after (broken)
>> applying "ARM: shmobile: r8a7778: Switch to new style TMU device" and provide
>> me with the two boot logs ?
>
> Sure, please see the attached logs.

Relevant part of the difference:

 sh_tmu sh_tmu.0: MSTP clock 16 @ffc80030
-sh_tmu sh_tmu.0: phys base 0xffd80008 virt base d0964008 size 12
+sh_tmu sh_tmu.0: phys base 0xffd80000 virt base d0964000 size 48
 sh_tmu sh_tmu.0: ch0: base d0964008
 sh_tmu sh_tmu.0: ch0: used for clock events
 sh_tmu sh_tmu.0: ch0: used for periodic clock events
 sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
-sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
+sh_tmu sh_tmu.0: ch0: writing TSTR @d0964004
 sh_tmu sh_tmu.0: ch0: clock rate is 16666666
 sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
+sh_tmu sh_tmu.0: ch0: writing TSTR @d0964004
 sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
+sh_tmu sh_tmu.0: ch0: writing TSTR @d0964004
 sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
-sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
-sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
-sh_tmu sh_tmu.0: ch0: reading TSTR @d0964004
-sh_tmu sh_tmu.0: ch0: requesting IRQ 64 for clock event device

irq64 (good)

-sh_tmu sh_tmu.1: MSTP clock 15 @ffc80030
-sh_tmu sh_tmu.1: phys base 0xffd80014 virt base d0966014 size 12
-sh_tmu sh_tmu.1: ch1: base d0966014
-sh_tmu sh_tmu.1: ch1: failed to get irq
+sh_tmu sh_tmu.0: ch0: writing TSTR @d0964004
+sh_tmu sh_tmu.0: ch0: requesting IRQ 96 for clock event device

irq96 (bad)

+sh_tmu sh_tmu.0: ch1: base d0964014
+sh_tmu sh_tmu.0: ch1: used as clock source
+sh_tmu sh_tmu.0: ch1: reading TSTR @d0964004
+sh_tmu sh_tmu.0: ch1: writing TSTR @d0964004
+sh_tmu sh_tmu.0: ch1: clock rate is 16666666
+sh_tmu sh_tmu.0: ch1: reading TSTR @d0964004
+sh_tmu sh_tmu.0: ch1: writing TSTR @d0964004
+Switched to clocksource sh-tmu.0

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
