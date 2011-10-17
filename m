From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 17 Oct 2011 09:01:19 +0000
Subject: [PATCH] sh: pfc: get_config_reg() shift clean up
Message-Id: <20111017090119.21999.90526.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Clean up the f_width shift code in get_config_reg().

Reported-by: Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/pfc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0005/drivers/sh/pfc.c
+++ work/drivers/sh/pfc.c	2011-10-14 20:11:19.000000000 +0900
@@ -217,7 +217,7 @@ static int get_config_reg(struct pinmux_
 
 		if (!r_width)
 			break;
-		for (n = 0; n < (r_width / f_width) * 1 << f_width; n++) {
+		for (n = 0; n < (r_width / f_width) * (1 << f_width); n++) {
 			if (config_reg->enum_ids[n] = enum_id) {
 				*crp = config_reg;
 				*indexp = n;
