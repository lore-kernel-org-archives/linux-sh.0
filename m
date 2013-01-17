From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 17 Jan 2013 09:45:54 +0000
Subject: [PATCH 1/4] i2c: i2c-sh_mobile.c: cosmetic: trivially simplify 2 functions
Message-Id: <1358415957-8371-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1358415957-8371-1-git-send-email-g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

Reduce 2 boolean functions from "if (condition) return 1; return 0;" to
"return condition;"

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/i2c/busses/i2c-sh_mobile.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 9411c1b..3b08b4e 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -349,20 +349,14 @@ static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 	return ret;
 }
 
-static int sh_mobile_i2c_is_first_byte(struct sh_mobile_i2c_data *pd)
+static bool sh_mobile_i2c_is_first_byte(struct sh_mobile_i2c_data *pd)
 {
-	if (pd->pos = -1)
-		return 1;
-
-	return 0;
+	return pd->pos = -1;
 }
 
-static int sh_mobile_i2c_is_last_byte(struct sh_mobile_i2c_data *pd)
+static bool sh_mobile_i2c_is_last_byte(struct sh_mobile_i2c_data *pd)
 {
-	if (pd->pos = (pd->msg->len - 1))
-		return 1;
-
-	return 0;
+	return pd->pos = pd->msg->len - 1;
 }
 
 static void sh_mobile_i2c_get_data(struct sh_mobile_i2c_data *pd,
-- 
1.7.2.5

