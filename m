From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 17:30:19 +0000
Subject: [PATCH 1/2] sh-clk: Improve a size determination in sh_clk_fsidiv_register()
Message-Id: <8eaa3790-ae29-72ce-9750-28f5c6e01e85@users.sourceforge.net>
List-Id: <linux-sh.vger.kernel.org>
References: <db01c452-5817-db62-bbde-c4c5cd232a3a@users.sourceforge.net>
In-Reply-To: <db01c452-5817-db62-bbde-c4c5cd232a3a@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 18:42:22 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/sh/clk/cpg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 7442bc130055..f23464bbeb7c 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -470,6 +470,5 @@ int __init sh_clk_fsidiv_register(struct clk *clks, int nr)
 	int i;
 
 	for (i = 0; i < nr; i++) {
-
-		map = kzalloc(sizeof(struct clk_mapping), GFP_KERNEL);
+		map = kzalloc(sizeof(*map), GFP_KERNEL);
 		if (!map) {
-- 
2.13.0

