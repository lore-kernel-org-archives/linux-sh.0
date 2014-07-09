From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 09 Jul 2014 00:59:07 +0000
Subject: [PATCH] dma: rcar-audmapp: add NULL terminater on audmapp_of_match
Message-Id: <87simbuz3a.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53bc1736.wQxo84tuhA7/j+O2%fengguang.wu@intel.com>
	<alpine.DEB.2.02.1407082242560.2069@localhost6.localdomain6>
In-Reply-To: <alpine.DEB.2.02.1407082242560.2069@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-SH <linux-sh@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Vinod Koul <vinod.koul@intel.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, Simon Horman <horms+renesas@verge.net.au>, Linux-Kernel <linux-kernel@vger.kernel.org>, sboyd@codeaurora.org, kbuild@01.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch solve this issue

drivers/dma/sh/rcar-audmapp.c:357:41-42: audmapp_of_match is not NULL terminated at line 357

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/dma/sh/rcar-audmapp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sh/rcar-audmapp.c b/drivers/dma/sh/rcar-audmapp.c
index 0774c36..dabbf0a 100644
--- a/drivers/dma/sh/rcar-audmapp.c
+++ b/drivers/dma/sh/rcar-audmapp.c
@@ -355,6 +355,7 @@ static int audmapp_remove(struct platform_device *pdev)
 
 static const struct of_device_id audmapp_of_match[] = {
 	{ .compatible = "renesas,rcar-audmapp", },
+	{},
 };
 
 static struct platform_driver audmapp_driver = {
-- 
1.7.9.5

