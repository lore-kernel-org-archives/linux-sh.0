From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Mar 2015 05:29:01 +0000
Subject: [PATCH 0/1] ARM: configs: remove all CONFIG_RCAR_AUDMAC_PP from ARM defconfigs
Message-Id: <871tkleesi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Olof, Kevin, Arnd

This patch removes CONFIG_RCAR_AUDMAC_PP from arch/arm/configs,
because rcar_audmac_periperi is no longer DMAEngine driver.

DMAEngine maintainer Vinod accepted about rcar_audmac_periperi removal patch on

	git://git.infradead.org/users/vkoul/slave-dma.git :: topic/sh

	3cd44dcd35a6618df88c51561290dc02fb35b8e2
	(dmaengine: remove Renesas Audio DMAC peri peri)

And, this patch was posted to him in v1/v2 patch-set.
But, he couldn't apply it, because of base branch (?)
According to Simon (= SH-ARM maintainer) this patch should be taken
ARM maintainer.
http://thread.gmane.org/gmane.linux.ports.sh.devel/44657/focusD857

I can say that this removal CONFIG_RCAR_AUDMAC_PP patch has no relationship
to DMAEngine branch, because no SoC/platform is using it.
(more detail, defconfig has it, but, there is no DT settings in upstream)
So, I think you don't need to care about Vinod's branch

