From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 16 Apr 2014 06:03:49 +0000
Subject: [PATCH 6/8] ARM: shmobile: rcar-gen2: Cache Mode Monitor Register Value
Message-Id: <835d737d664650d7f164a5b688271a424db4434c.1397627619.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397627619.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397627619.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

The MD pins are sampled at reset time, hence the read value will always be
the same, and we can avoid the overhead of ioremapping the register on
every read.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 1060448..542c5a4 100644
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
1.8.5.2

