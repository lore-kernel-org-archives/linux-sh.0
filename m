From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 03 Dec 2013 08:07:03 +0000
Subject: [PATCH] ARM: shmobile: armadillo: fixup FSI address size
Message-Id: <87a9gitl2a.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvtnsxr9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvtnsxr9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

FSI address size is 0x400, not 0x8400

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 958e3cb..d9e28c7a 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -958,7 +958,7 @@ static struct resource fsi_resources[] = {
 	[0] = {
 		.name	= "FSI",
 		.start	= 0xfe1f0000,
-		.end	= 0xfe1f8400 - 1,
+		.end	= 0xfe1f0400 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-- 
1.7.9.5

