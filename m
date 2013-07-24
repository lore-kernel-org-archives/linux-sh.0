From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 24 Jul 2013 06:12:41 +0000
Subject: [PATCH resend] shdma: fixup sh_dmae_get_partial() calculation error
Message-Id: <87bo5sv63u.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373422152-29976-1-git-send-email-horms+renesas@verge.net.au>
	<20130716012041.GA942@verge.net.au>
	<20130723023907.GC14983@quad.lixom.net>
	<20130723041220.GA22253@verge.net.au>
	<87zjtddgtg.wl%kuninori.morimoto.gx@renesas.com>
	<20130724034009.GA18355@verge.net.au>
	<87d2q8v6fs.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2q8v6fs.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olof Johansson <olof@lixom.net>
Cc: Simon Horman <simon@horms.net>, Linux-SH <linux-sh@vger.kernel.org>, Guennadi <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org

sh_desc->hw.tcr is controlling real data size,
and, register TCR is controlling data transfer count
which was xmit_shifted value of hw.tcr.
Current sh_dmae_get_partial() is calculating in different unit.
This patch fixes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Guennadi

Could you please check this patch, and give it your Acked-by ?

 drivers/dma/sh/shdma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/shdma.c b/drivers/dma/sh/shdma.c
index b70709b..d670b8b 100644
--- a/drivers/dma/sh/shdma.c
+++ b/drivers/dma/sh/shdma.c
@@ -388,8 +388,8 @@ static size_t sh_dmae_get_partial(struct shdma_chan *schan,
 						    shdma_chan);
 	struct sh_dmae_desc *sh_desc = container_of(sdesc,
 					struct sh_dmae_desc, shdma_desc);
-	return (sh_desc->hw.tcr - sh_dmae_readl(sh_chan, TCR)) <<
-		sh_chan->xmit_shift;
+	return sh_desc->hw.tcr -
+		(sh_dmae_readl(sh_chan, TCR) << sh_chan->xmit_shift);
 }
 
 /* Called from error IRQ or NMI */
-- 
1.7.9.5

