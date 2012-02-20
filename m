From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 20 Feb 2012 08:26:50 +0000
Subject: [PATCH] sh: modify a resource of sh_eth_giga1_resources in board-sh7757lcr
Message-Id: <4F4203CA.3040303@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The latest sh_eth driver needs a resource of TSU in the channel 1,
if the controller has TSU registers. So, this patch adds the resource.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/boards/board-sh7757lcr.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 0838154..dd8ced3 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -169,6 +169,11 @@ static struct resource sh_eth_giga1_resources[] = {
 		.end    = 0xfee00fff,
 		.flags  = IORESOURCE_MEM,
 	}, {
+		/* TSU */
+		.start  = 0xfee01800,
+		.end    = 0xfee01fff,
+		.flags  = IORESOURCE_MEM,
+	}, {
 		.start  = 316,
 		.end    = 316,
 		.flags  = IORESOURCE_IRQ,
-- 
1.7.1
