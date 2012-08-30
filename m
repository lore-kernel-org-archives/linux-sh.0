From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 30 Aug 2012 01:58:01 +0000
Subject: [PATCH 1/2] ARM: shmobile: marzen: fixup smsc911x id for regulator
Message-Id: <87wr0hxhsp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

dummy_supplies for smsc911x are registered as "smsc911x".
smsc911x driver needs id = -1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-marzen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 00b1816..a34d13e 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -78,7 +78,7 @@ static struct smsc911x_platform_config smsc911x_platdata = {
 
 static struct platform_device eth_device = {
 	.name		= "smsc911x",
-	.id		= 0,
+	.id		= -1,
 	.dev  = {
 		.platform_data = &smsc911x_platdata,
 	},
-- 
1.7.9.5

