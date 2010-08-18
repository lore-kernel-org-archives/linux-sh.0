From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Aug 2010 03:37:19 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: modify FSI2 ID
Message-Id: <w3p1v9weglx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 8afdb1d..1b95f12 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -559,7 +559,7 @@ static struct resource fsi_resources[] = {
 
 static struct platform_device fsi_device = {
 	.name		= "sh_fsi2",
-	.id		= 0,
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(fsi_resources),
 	.resource	= fsi_resources,
 	.dev	= {
-- 
1.7.0.4

