From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 23:00:22 +0000
Subject: [PATCH v4 77/88] ARM: shmobile: sh73a0: Remove USB function GPIOs
Message-Id: <1363215633-4264-78-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/sh73a0.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 218e6b7..d488e2b 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -94,8 +94,7 @@ enum {
 	GPIO_PORT305, GPIO_PORT306, GPIO_PORT307, GPIO_PORT308, GPIO_PORT309,
 
 	/* Table 25-1 (Function 0-7) */
-	GPIO_FN_VBUS_0 = 310,
-	GPIO_FN_GPI0,
+	GPIO_FN_GPI0 = 310,
 	GPIO_FN_GPI1,
 	GPIO_FN_GPI2,
 	GPIO_FN_GPI3,
-- 
1.8.1.5

