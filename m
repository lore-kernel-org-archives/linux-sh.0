From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Aug 2014 13:26:19 +0000
Subject: [PATCH 2/5] ARM: shmobile: sh7372: Make domain_devices[] static __initdata
Message-Id: <1409318782-28133-3-git-send-email-geert+renesas@glider.be>
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
 arch/arm/mach-shmobile/setup-sh7372.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index ea63fbe2538c..d646c8d12423 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -928,7 +928,7 @@ static struct platform_device *sh7372_late_devices[] __initdata = {
 
 void __init sh7372_add_standard_devices(void)
 {
-	struct pm_domain_device domain_devices[] = {
+	static struct pm_domain_device domain_devices[] __initdata = {
 		{ "A3RV", &vpu_device, },
 		{ "A4MP", &spu0_device, },
 		{ "A4MP", &spu1_device, },
-- 
1.7.9.5

