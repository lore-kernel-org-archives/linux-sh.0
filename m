From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Mar 2014 18:44:49 +0000
Subject: [PATCH 1/2] ARM: shmobile: rcar-gen2: Cache Mode Monitor Register Value
Message-Id: <1394649890-23485-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

The MD pins are sampled at reset time, hence the read value will always be
the same, and we can avoid the overhead of ioremapping the register on
every read.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 10604480f325..542c5a47173f 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -30,12 +30,16 @@
 
 u32 rcar_gen2_read_mode_pins(void)
 {
-	void __iomem *modemr = ioremap_nocache(MODEMR, 4);
-	u32 mode;
-
-	BUG_ON(!modemr);
-	mode = ioread32(modemr);
-	iounmap(modemr);
+	static u32 mode;
+	static bool mode_valid;
+
+	if (!mode_valid) {
+		void __iomem *modemr = ioremap_nocache(MODEMR, 4);
+		BUG_ON(!modemr);
+		mode = ioread32(modemr);
+		iounmap(modemr);
+		mode_valid = true;
+	}
 
 	return mode;
 }
-- 
1.7.9.5

