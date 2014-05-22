From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 May 2014 18:00:03 +0000
Subject: [PATCH v4 0/3] drivers: sh: Misc updates
Message-Id: <1400781606-18601-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Simon,

Now commit 3c90c55dcde745bed81f6447f24ba96bda43d984 ("drivers: sh:
compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI") has landed in
mainline in v3.15-rc6, I'm resubmitting a few updates for drivers/sh,
like you asked me before:

  - [1/3] drivers: sh: pm_runtime does not need idle callback
  - [2/3] drivers: sh: pm_runtime implementation needs to suspend
  - [3/3] drivers: sh: Restrict INTC_USERIMASK to SH4A

Thanks for applying!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
