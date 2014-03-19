From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Mar 2014 19:06:45 +0000
Subject: [PATCH 0/5] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patchset enables the PM runtime code in drivers/sh/pm_runtime.c when
running a multi-platform ARM kernel including support for shmobile.
Before this code was only enabled for legacy shmobile kernels, leading to
disabled clocks in multiplatform kernels, depending on implicit reset state
or on the bootloader.

  [1/5] drivers: sh: pm_runtime does not need idle callback
  [2/5] sh: intc: Restrict INTC_USERIMASK to SH4A
  [3/5] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
  [4/5] ARM: shmobile: Call sh_pm_runtime_init() from platform code on all
        SoCs
  [5/5] drivers: sh: Remove automatic sh_pm_runtime_init() if
        ARCH_SHMOBILE_LEGACY

Patches 1 and 3 were authored by Ben Dooks, with some changes made by me
(for patch 3). Patch 4 was based on a patch by Ben for r8a7790.

After this it should be safe to revert the various commits to "Work around
core clock issues". Note that this is just a port of the existing
sh(mobile)-specifc PM runtime code from legacy to multi-platform, so
expect more work to fix the core issues.

This was tested on Koelsch, both legacy and multi-platform.

Many thanks to Ben Dooks, Laurent Pinchart, and Magnus Damm for the
valuable input, investigations, and discussions.

Thanks for your comments, and test results on other boards/SoCs (esp.
SoCs supporting power domains, like sh7372, r8a7740, and r8a7779)!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
