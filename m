From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 09 Jan 2013 00:52:21 +0000
Subject: [PATCH v2 01/29] pinctrl: fix comment mistake
Message-Id: <1357692769-1432-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

This variable pertains to pinctrl handles not muxes
specifically.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 5cdee86..59f5a96 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -700,7 +700,7 @@ static struct pinctrl *create_pinctrl(struct device *dev)
 		}
 	}
 
-	/* Add the pinmux to the global list */
+	/* Add the pinctrl handle to the global list */
 	list_add_tail(&p->node, &pinctrl_list);
 
 	return p;
-- 
1.7.8.6

