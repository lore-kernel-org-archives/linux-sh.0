From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 28 May 2015 15:15:57 +0000
Subject: [PATCH v4 4/4] ARM: shmobile: gose: enable R-Car Gen2 regulator quirk
Message-Id: <1432826157-6414-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Regulator setup seems identical to Koelsch.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
index 384e6e9..62437b5 100644
--- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
@@ -123,7 +123,8 @@ static int __init rcar_gen2_regulator_quirk(void)
 	u32 mon;
 
 	if (!of_machine_is_compatible("renesas,koelsch") &&
-	    !of_machine_is_compatible("renesas,lager"))
+	    !of_machine_is_compatible("renesas,lager") &&
+	    !of_machine_is_compatible("renesas,gose"))
 		return -ENODEV;
 
 	irqc = ioremap(IRQC_BASE, PAGE_SIZE);
-- 
2.3.5

