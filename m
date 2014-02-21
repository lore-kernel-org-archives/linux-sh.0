From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 21 Feb 2014 06:13:10 +0000
Subject: [PATCH 3/3] ARM: shmobile: Remove __init from rcar_gen2_read_mode_pins()
Message-Id: <db47204b32dd0d72454b4f841d0f7e33c44ee2b8.1392961497.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1392961497.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1392961497.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove __init from rcar_gen2_read_mode_pins() to allow
it to be used after boot. For instance the R-Car Gen2
MD21 check is needed even in the case of CPU Hotplug.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 69ccc6c..1060448 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -28,7 +28,7 @@
 
 #define MODEMR 0xe6160060
 
-u32 __init rcar_gen2_read_mode_pins(void)
+u32 rcar_gen2_read_mode_pins(void)
 {
 	void __iomem *modemr = ioremap_nocache(MODEMR, 4);
 	u32 mode;
-- 
1.8.5.2

