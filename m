From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Oct 2013 00:03:54 +0000
Subject: Re: [PATCH 0/3] rcar-hpbdma: fixup patches for double plane
Message-Id: <87hacf1m3h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3hc189h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3hc189h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are v2 of R-Car HBPDMA fixup patches
for double plane.

Kuninori Morimoto (3):
      rcar-hpbdma: add max transfer size
      rcar-hpbdma: initialise plane information when halted
      rcar-hpbdma: fixup channel busy check for double plane

 drivers/dma/sh/rcar-hpbdma.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Best regards
---
Kuninori Morimoto
