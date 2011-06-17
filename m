From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 Jun 2011 08:19:43 +0000
Subject: [RFC][PATCH 0/5 v3] dmaengine: Add USB-DMAC support
Message-Id: <w3p8vt0q38g.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

Cc Magnus, Guennadi, Simon

These are v3 of USB-DMAC support prototype for SH7372

Kuninori Morimoto (6)
         dmaengine: shdma: add chcr_write/read function
         dmaengine: shdma: add chcr_ie_bit
         dmaengine: shdma: add dmaor_is_32bit flag
         dmaengine: shdma: add is_usbdmac flag
         ARM: mach-shmobile: sh7372: Add USB-DMAC support
         ARM: mach-shmobile: mackerel: Add USB-DMA ID


Best regards
---
Kuninori Morimoto
