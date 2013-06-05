From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 05 Jun 2013 08:25:10 +0000
Subject: [PATCH 019/130] sh-pfc: r8a7779: use RCAR_GP_PIN() on _GP_GPIO() macro
Message-Id: <1370420821-28420-20-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index e1491a5..1590d6c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -80,7 +80,7 @@
 #define _GP_PORT_ALL(bank, pin, name, sfx)	name##_##sfx
 
 #define _GP_GPIO(bank, pin, _name, sfx)					\
-	[(bank * 32) + pin] = {						\
+	[RCAR_GP_PIN(bank, pin)] = {					\
 		.name = __stringify(_name),				\
 		.enum_id = _name##_DATA,				\
 	}
-- 
1.8.2.1

