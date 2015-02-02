From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 02 Feb 2015 04:25:10 +0000
Subject: [PATCH 0/3 v3][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi all

These are v3 of rcar-audmapp driver as [RFC].
We can reduce Audio DMAC peri peri DT entry 220 -> 22 node by these patches.

Actually, sound driver side needs update for this rcar-audmapp update,
but it doesn't include these patches at this point.
These are focuing about rcar-audmapp only at this point.

Main change on this version is that audmapp driver assumes DTS has reg-names

Kuninori Morimoto (3):
      dmaengine: rcar-audmapp: calculate chcr via src/dst addr
      ARM: shmobile: r8a7790: add SSIU/DTCP/MLM/SCU reg for Audio DMAC peri peri
      ARM: shmobile: r8a7790: enables Audio DMAC peri peri entry on DTSI

 arch/arm/boot/dts/r8a7790.dtsi |   26 ++++++-
 drivers/dma/sh/rcar-audmapp.c  |  164 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 175 insertions(+), 15 deletions(-)

Best regards
---
Kuninori Morimoto
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
