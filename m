From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Aug 2014 13:26:18 +0000
Subject: [PATCH 1/5] ARM: shmobile: mackerel: Make domain_devices[] static __initdata
Message-Id: <1409318782-28133-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Make the domain_devices[] array static and __initdata, to reduce kernel
size:
  - Making it static gets rid of the code to copy the data to the stack,
  - Marking it __initdata allows more init memory to be freed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-mackerel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b7c4261492b0..ca5d34b92aa7 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1421,7 +1421,7 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 #define USCCR1		IOMEM(0xE6058144)
 static void __init mackerel_init(void)
 {
-	struct pm_domain_device domain_devices[] = {
+	static struct pm_domain_device domain_devices[] __initdata = {
 		{ "A4LC", &lcdc_device, },
 		{ "A4LC", &hdmi_lcdc_device, },
 		{ "A4LC", &meram_device, },
-- 
1.7.9.5

