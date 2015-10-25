From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Sun, 25 Oct 2015 10:09:32 +0000
Subject: [git pull] dmaengine: sh: usb-dmac: Runtime PM related fixes for v4.3
Message-Id: <1445767774-24001-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Vinod,

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git shdma-usb-dmac-for-v4.3

for you to fetch changes up to 6d4b4788c75c62fbc3c85d7a079376294665973d:

  dmaengine: sh: usb-dmac: Fix pm_runtime_{enable,disable}() imbalance (2015-10-25 10:58:18 +0100)

Summary:
  - dmaengine: sh: usb-dmac: Runtime PM related fixes

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (2):
      dmaengine: sh: usb-dmac: Fix crash on runtime suspend
      dmaengine: sh: usb-dmac: Fix pm_runtime_{enable,disable}() imbalance

 drivers/dma/sh/usb-dmac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
