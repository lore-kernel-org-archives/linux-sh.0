From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 19 May 2015 16:29:48 +0000
Subject: [PATCH] i2c: check for proper length of the reg property
Message-Id: <1432052988-6187-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

int is vague, let's simply use the type of the variable in question.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 987c124432c501..c517fc9d222c8f 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1272,7 +1272,7 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	}
 
 	addr = of_get_property(node, "reg", &len);
-	if (!addr || (len < sizeof(int))) {
+	if (!addr || (len < sizeof(*addr))) {
 		dev_err(&adap->dev, "of_i2c: invalid reg on %s\n",
 			node->full_name);
 		return ERR_PTR(-EINVAL);
-- 
2.1.4

