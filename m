From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Oct 2013 10:50:23 +0000
Subject: [PATCH 0/3] rcar-hpbdma: fixup patches for double plane
Message-Id: <87k3hc189h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Max

These patches fixup R-Car HBPDMA driver
for double plane.

Max

Could you please review these patches ?
Especially last patch.
It checks DQSTS when double plane, but I'm not good at HPBDMA.

I tested these patches on my R-Car sound driver in local environment.
It doesn't work without these patches.

Kuninori Morimoto (3):
      rcar-hpbdma: add max transfer size
      rcar-hpbdma: initialise plane information when halted
      rcar-hpbdma: fixup channel busy check for double plane

 drivers/dma/sh/rcar-hpbdma.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


Best regards
---
Kuninori Morimoto
