From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 26 Nov 2013 01:45:34 +0000
Subject: [PATCH 2/2] sh-pfc: Fix PINMUX_GPIO macro
Message-Id: <1385430334-12141-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Commit 7cbb0e55e27e ("sh-pfc: Don't duplicate argument to PINMUX_GPIO
macro") erronesouly modified the PINMUX_GPIO macro in a way that
resulted in all pins being named "name". Fix the macro to name the pins
correctly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 8a494e5..463ef21 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -254,7 +254,7 @@ struct sh_pfc_soc_info {
 #define PINMUX_GPIO(_pin)						\
 	[GPIO_##_pin] = {						\
 		.pin = (u16)-1,						\
-		.name = __stringify(name),				\
+		.name = __stringify(GPIO_##_pin),			\
 		.enum_id = _pin##_DATA,					\
 	}
 
-- 
1.8.3.2

