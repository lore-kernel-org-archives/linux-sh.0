From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Dec 2013 02:07:20 +0000
Subject: [PATCH 24/26] ARM: shmobile: armadillo: fixup FSI address size
Message-Id: <4a4783a30c92a5ee1752d33af3bea2bf79f64197.1387763524.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

FSI address size is 0x400, not 0x8400

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 2 +-
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
1.8.4

