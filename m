From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 06 Mar 2013 12:52:33 +0000
Subject: [PATCH v3 12/29] sh-pfc: Make struct pinmux_gpio enum_id field const
Message-Id: <1362574370-17889-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This ensures that the field is not modified, which is a prerequisite for
the rest of the PFC refactoring work.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index e150395..6ed7ab9 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -36,7 +36,7 @@ enum {
 #define PINMUX_FLAG_DREG            (0x3f << PINMUX_FLAG_DREG_SHIFT)
 
 struct pinmux_gpio {
-	pinmux_enum_t enum_id;
+	const pinmux_enum_t enum_id;
 	pinmux_flag_t flags;
 	const char *name;
 };
-- 
1.8.1.5

