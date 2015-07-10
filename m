From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jul 2015 11:59:10 +0000
Subject: [PATCH/RFC 0/3] dmaengine: shdma: Miscellaneous changes
Message-Id: <1436529553-30571-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi,

This is an RFC series containing miscellaneous changes to the various SH
and (ARM) shmobile DMA engine drivers.  This series is not meant to be
applied yet, but I'd like to receive some comments. I will
split/rework/resubmit/... later.

Due to lack of hardware/support/... this didn't receive real testing.

Thanks for your feedback!

Geert Uytterhoeven (3):
  dmaengine: shdmac: Use generic residue handling
  dmaengine: shdmac: Add missing DMA_MEM_TO_MEM direction
  dmaengine: sudmac: Add missing address widths and directions

 drivers/dma/sh/rcar-dmac.c   |  3 ++-
 drivers/dma/sh/rcar-hpbdma.c | 13 +++++++------
 drivers/dma/sh/shdma-base.c  | 12 ++++++++----
 drivers/dma/sh/shdmac.c      | 17 ++++++++---------
 drivers/dma/sh/sudmac.c      | 15 ++++++++++-----
 include/linux/shdma-base.h   |  4 ++--
 6 files changed, 37 insertions(+), 27 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
