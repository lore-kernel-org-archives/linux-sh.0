From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 18 May 2018 11:06:49 +0000
Subject: [PATCH 0/2] Remove calls to empty arch_setup_pdev_archdata()
Message-Id: <1526641611-2769-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi,

Recently, a few calls to arch_setup_pdev_archdata() were added to the
ecovec and migor board files (copied from platform_device_register())?

However, SuperH doesn't implement arch_setup_pdev_archdata(), and falls
back to the default (empty) implementation.  As this code is
board-specific, the calls can just be removed.

Thanks!

Geert Uytterhoeven (2):
  sh: ecovec: Remove calls to empty arch_setup_pdev_archdata()
  sh: migor: Remove calls to empty arch_setup_pdev_archdata()

 arch/sh/boards/mach-ecovec24/setup.c | 2 --
 arch/sh/boards/mach-migor/setup.c    | 1 -
 2 files changed, 3 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
