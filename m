From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Jun 2014 08:01:27 +0000
Subject: Re: [PATCH 00/08] ARM: shmobile: Suspend on non-SMP update for r8a7790
Message-Id: <CAMuHMdV9iAkrfOab4BOpjk=Dg-xbJTqidcai6GaLj+GmUgf0Pg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140605051505.18075.76727.sendpatchset@w520>
In-Reply-To: <20140605051505.18075.76727.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Jun 5, 2014 at 7:15 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> ARM: shmobile: Suspend on non-SMP update for r8a7790
>
> [PATCH 01/08] ARM: shmobile: Allow use of boot code for non-SMP case
> [PATCH 02/08] ARM: shmobile: Adjust APMU code to build for non-SMP
> [PATCH 03/08] ARM: shmobile: Move r8a7790 reset code to pm-r8a7790.c
> [PATCH 04/08] ARM: shmobile: Allow r8a7790 to build non-SMP APMU code
> [PATCH 05/08] ARM: shmobile: Use __init for APMU suspend init function
> [PATCH 06/08] ARM: shmobile: Setup APMU for suspend in non-SMP case
> [PATCH 07/08] ARM: shmobile: Hook up r8a7790 PM code for Multiplatform
> [PATCH 08/08] ARM: shmobile: Use shmobile_init_late on r8a7790 DT-only
>
> These patches update mach-shmobile and r8a7790 to allow build of
> early boot code and APMU power management code in case of CONFIG_SMP=n.

Thanks!

> The reason for this change is to allow use of Suspend-to-RAM for recent
> SoCs like r8a7790 with simplified kernel configuration such as when
> SMP is disabled. Power management code like CPUFreq, CPUIdle and
> Suspend-to-RAM should work regardless of what kind of CONFIG_SMP
> setting the user decides.

Perhaps the non-SMP-specific code can be factored out of headsmp.c and
platsmp.c into one or more separate files, and the "smp" dropped from the
function names, or is it too entangled with the SMP-specific code?

Things like (in [6/8]):

 void __init shmobile_smp_apmu_suspend_init(void)
 {
+#ifndef CONFIG_SMP
+       /* initialize APMU for non-SMP case */
+       shmobile_smp_apmu_prepare_cpus(1);
+#endif
        shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
 }
 #else

can look really confusing: shmobile_*SMP*_apmu_suspend_init() has a
!CONFIG_SMP section calling into shmobile_*SMP*_apmu_prepare_cpus()
(the latter is OK, due to the "1" parameter indicating there's only one CPU).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
