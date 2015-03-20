From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 20 Mar 2015 01:07:20 +0000
Subject: [PATCH 1/3] ARM: shmobile: r8a7790: Correct SYSCIER value
Message-Id: <ee72f6adfdd95b53432eb60b6944c6fe2790dd13.1426812951.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1426812951.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1426812951.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Set the SYSCIER as per the values indicated in the documentation.
The value previously used appears to been copied from the r8a7779
implementation but on closer inspection is not correct for the r8a7790.

Fixes: a48f165509c1 ("ARM: shmobile: r8a7790 SYSC setup code")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-r8a7790.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7790.c b/arch/arm/mach-shmobile/pm-r8a7790.c
index 80e8d95..23b61f1 100644
--- a/arch/arm/mach-shmobile/pm-r8a7790.c
+++ b/arch/arm/mach-shmobile/pm-r8a7790.c
@@ -38,7 +38,7 @@ static void __init r8a7790_sysc_init(void)
 	void __iomem *base = rcar_sysc_init(0xe6180000);
 
 	/* enable all interrupt sources, but do not use interrupt handler */
-	iowrite32(0x0131000e, base + SYSCIER);
+	iowrite32(0x013111ef, base + SYSCIER);
 	iowrite32(0, base + SYSCIMR);
 }
 
-- 
2.1.4

