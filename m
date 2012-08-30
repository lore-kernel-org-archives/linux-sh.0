From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 30 Aug 2012 01:58:15 +0000
Subject: [PATCH 2/2] ARM: shmobile: marzen: fixup regulator id for smsc911x
Message-Id: <87vcg1xhsb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

regulator id = 0 is used for sh_mobile_sdhi.
smsc911x's regulator can use id = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-marzen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index a34d13e..319e4fc 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -269,7 +269,7 @@ static void __init marzen_init(void)
 {
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
-	regulator_register_fixed(0, dummy_supplies,
+	regulator_register_fixed(1, dummy_supplies,
 				ARRAY_SIZE(dummy_supplies));
 
 	r8a7779_pinmux_init();
-- 
1.7.9.5

