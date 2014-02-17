From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 17 Feb 2014 06:35:10 +0000
Subject: [PATCH] ARM: shmobile: Remove __init from rcar_gen2_read_mode_pins()
Message-Id: <20140217063510.21892.52120.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove __init from rcar_gen2_read_mode_pins() to allow
it to be used after boot. For instance the R-Car Gen2
MD21 check is needed even in the case of CPU Hotplug.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-v3.14-rc2-20140213

 arch/arm/mach-shmobile/setup-rcar-gen2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c	2014-02-17 15:02:48.000000000 +0900
@@ -28,7 +28,7 @@
 
 #define MODEMR 0xe6160060
 
-u32 __init rcar_gen2_read_mode_pins(void)
+u32 rcar_gen2_read_mode_pins(void)
 {
 	void __iomem *modemr = ioremap_nocache(MODEMR, 4);
 	u32 mode;
