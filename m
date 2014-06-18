From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 08:58:41 +0000
Subject: [PATCH 0/3] dma: rcar-audmapp: add DT support
Message-Id: <87tx7iy4ot.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org


Hi Vinod

These patches add DT support to Renesas Audio DMAC peri peri driver.

Kuninori Morimoto (3):
      dma: rcar-audmapp: enable .set_slave
      dma: rcar-audmapp: don't keep audmapp_slave_config for each channeles
      dma: rcar-audmapp: add DT support

 .../devicetree/bindings/dma/rcar-audmapp.txt       |   30 ++++++
 drivers/dma/sh/rcar-audmapp.c                      |  113 ++++++++++++++------
 2 files changed, 113 insertions(+), 30 deletions(-)
