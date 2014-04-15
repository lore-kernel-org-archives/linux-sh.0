From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:33:58 +0000
Subject: [PATCH v2 02/17] ARM: shmobile: r8a7740: Make r8a7740_meram_workaround() __init
Message-Id: <1397565253-22741-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It's called from eva_init() only, which is __init

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New

 arch/arm/mach-shmobile/setup-r8a7740.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index cba3a07a97c2..a177a7b3bdbd 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -765,7 +765,7 @@ static struct platform_device *r8a7740_late_devices[] __initdata = {
  *	"Media RAM (MERAM)" on r8a7740 documentation
  */
 #define MEBUFCNTR	0xFE950098
-void r8a7740_meram_workaround(void)
+void __init r8a7740_meram_workaround(void)
 {
 	void __iomem *reg;
 
-- 
1.7.9.5

