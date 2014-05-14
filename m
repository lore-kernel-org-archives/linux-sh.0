From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 14 May 2014 14:51:20 +0000
Subject: [PATCH v3 2/4] ARM: shmobile: armadillo800eva reference: Spelling s/ED/LED/
Message-Id: <1400079082-6340-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

And add missing spaces before opening parentheses

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New
---
 .../board-armadillo800eva-reference.c              |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 57d246eb8813..f9d724e02195 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -53,11 +53,11 @@
  * CON22	Serial
  * CON23	LAN
  * CON24	USB3
- * LED1		Camera LED(Yellow)
+ * LED1		Camera LED (Yellow)
  * LED2		Power LED (Green)
- * ED3-LED6	User LED(Yellow)
- * LED7		LAN link LED(Green)
- * LED8		LAN activity LED(Yellow)
+ * LED3-LED6	User LED (Yellow)
+ * LED7		LAN link LED (Green)
+ * LED8		LAN activity LED (Yellow)
  */
 
 /*
-- 
1.7.9.5

