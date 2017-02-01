From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 01 Feb 2017 23:09:14 +0000
Subject: [PATCH] sh: make use of for_each_node_by_type()
Message-Id: <20170201230914.GA33322@dtor-ws>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Instead of open-coding the loop, let's use canned macro.

Also make sure we are not leaking last OF node reference.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/sh/boards/of-generic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 1fb6d5714bae..fc318386d7b0 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -56,15 +56,15 @@ const struct of_cpu_method __cpu_method_of_table_sentinel
 
 static void sh_of_smp_probe(void)
 {
-	struct device_node *np = 0;
-	const char *method = 0;
+	struct device_node *np;
+	const char *method = NULL;
 	const struct of_cpu_method *m = __cpu_method_of_table;
 
 	pr_info("SH generic board support: scanning for cpus\n");
 
 	init_cpu_possible(cpumask_of(0));
 
-	while ((np = of_find_node_by_type(np, "cpu"))) {
+	for_each_node_by_type(np, "cpu") {
 		const __be32 *cell = of_get_property(np, "reg", NULL);
 		u64 id = -1;
 		if (cell) id = of_read_number(cell, of_n_addr_cells(np));
@@ -80,6 +80,7 @@ static void sh_of_smp_probe(void)
 	if (!method) {
 		np = of_find_node_by_name(NULL, "cpus");
 		of_property_read_string(np, "enable-method", &method);
+		of_node_put(np);
 	}
 
 	pr_info("CPU enable method: %s\n", method);
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
