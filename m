From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2020 06:55:37 +0000
Subject: [PATCH 0/2] sh: Remove Cayman board support
Message-Id: <20200617065539.25805-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

Commit 37744feebc086908 ("sh: remove sh5 support") removed all core SH5
support, but forgot to remove board support for the SH5-based Hitachi
Cayman development board.

This patch (hopefully) completes the removal, by dropping Cayman board
support, and Cayman-specific handling in the i8042 driver.

Both patches can be applied independently.
The first patch is intended for the SH tree.
The second patch is intended for the input tree, but could be merged
through the SH tree, if acked.

Thanks!

Geert Uytterhoeven (2):
  sh: Remove SH5-based Cayman platform
  input: i8042 - Remove special Cayman handling

 arch/sh/Kconfig                     |   5 +-
 arch/sh/Makefile                    |   5 -
 arch/sh/boards/Kconfig              |   6 -
 arch/sh/boards/mach-cayman/Makefile |   5 -
 arch/sh/boards/mach-cayman/irq.c    | 148 -----------------------
 arch/sh/boards/mach-cayman/panic.c  |  46 -------
 arch/sh/boards/mach-cayman/setup.c  | 181 ----------------------------
 arch/sh/configs/cayman_defconfig    |  66 ----------
 arch/sh/drivers/pci/Makefile        |   1 -
 arch/sh/drivers/pci/fixups-cayman.c |  78 ------------
 arch/sh/tools/mach-types            |   1 -
 drivers/input/serio/i8042-io.h      |   2 -
 12 files changed, 2 insertions(+), 542 deletions(-)
 delete mode 100644 arch/sh/boards/mach-cayman/Makefile
 delete mode 100644 arch/sh/boards/mach-cayman/irq.c
 delete mode 100644 arch/sh/boards/mach-cayman/panic.c
 delete mode 100644 arch/sh/boards/mach-cayman/setup.c
 delete mode 100644 arch/sh/configs/cayman_defconfig
 delete mode 100644 arch/sh/drivers/pci/fixups-cayman.c

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
