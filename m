From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 14 Nov 2014 16:07:06 +0000
Subject: [PATCH 2/3] ARM: shmobile: sh7372: Spelling/grammar s/entity map/identity mapping/
Message-Id: <1415981227-13580-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-sh7372.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 68fbae51279d7108..458a2cfad4173ca7 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -43,7 +43,7 @@
 #include "sh7372.h"
 
 static struct map_desc sh7372_io_desc[] __initdata = {
-	/* create a 1:1 entity map for 0xe6xxxxxx
+	/* create a 1:1 identity mapping for 0xe6xxxxxx
 	 * used by CPGA, INTC and PFC.
 	 */
 	{
-- 
1.9.1

