From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 17 Nov 2014 13:53:08 +0000
Subject: [PATCH 4/4] ARM: shmobile: r8a7740: Remove mapping of L2 cache controller registers
Message-Id: <1416232388-2611-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1416232388-2611-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1416232388-2611-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Now all r8a7740-based platforms have been migrated to the generic l2c OF
initialization, it's no longer needed to map the L2 cache controller
registers from .map_io().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index f4a2997f55c0c4a4..e872b8ea99badbce 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -50,18 +50,6 @@ static struct map_desc r8a7740_io_desc[] __initdata = {
 		.length		= 160 << 20,
 		.type		= MT_DEVICE_NONSHARED
 	},
-#ifdef CONFIG_CACHE_L2X0
-	/*
-	 * for l2x0_init()
-	 * 0xf0100000-0xf0101000 -> 0xf0002000-0xf0003000
-	 */
-	{
-		.virtual	= 0xf0002000,
-		.pfn		= __phys_to_pfn(0xf0100000),
-		.length		= PAGE_SIZE,
-		.type		= MT_DEVICE_NONSHARED
-	},
-#endif
 };
 
 void __init r8a7740_map_io(void)
-- 
1.9.1

