From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 07 Mar 2012 00:14:15 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: fixup fsi2_ak4643_info typo
Message-Id: <871up5p8rv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This is for linus/master

 arch/arm/mach-shmobile/board-ap4evb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index eeb4d96..b4718b0 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -794,7 +794,7 @@ static struct fsi_ak4642_info fsi2_ak4643_info = {
 static struct platform_device fsi_ak4643_device = {
 	.name	= "fsi-ak4642-audio",
 	.dev	= {
-		.platform_data	= &fsi_info,
+		.platform_data	= &fsi2_ak4643_info,
 	},
 };
 
-- 
1.7.5.4

