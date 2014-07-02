From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Jul 2014 14:33:31 +0000
Subject: [PATCH] MAINTAINERS: Add entry for the Renesas pin controller driver
Message-Id: <1404311611-10902-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

I'm actively maintaining the driver, let's document that.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 702ca10..158dc48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6925,6 +6925,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/pinctrl/pinctrl-at91.c
 
+PIN CONTROLLER - RENESAS
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+L:	linux-sh@vger.kernel.org
+S:	Maintained
+F:	drivers/pinctrl/sh-pfc/
+
 PIN CONTROLLER - SAMSUNG
 M:	Tomasz Figa <t.figa@samsung.com>
 M:	Thomas Abraham <thomas.abraham@linaro.org>
-- 
1.8.5.5

