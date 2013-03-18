From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 18 Mar 2013 11:47:34 +0000
Subject: [PATCH 42/43] ARM: shmobile: R8A7779: use gic_iid() in SATA IRQ resource
Message-Id: <1363607255-6385-43-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Commit "ARM: shmobile: r8a7779: use gic_iid macro" switched R8A7779 platform
devices to using gic_iid() macro instead of gic_spi() but commit "ARM: mach-
shmobile: r8a7779: add SATA support" added another use of gic_spi(). Convert
the SATA IRQ resource to using gic_iid().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 10031fe..042df35 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -331,7 +331,7 @@ static struct resource sata_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= gic_spi(100),
+		.start	= gic_iid(0x84),
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
1.7.10.4

