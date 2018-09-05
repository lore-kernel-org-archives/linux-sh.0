From: Rob Herring <robh@kernel.org>
Date: Wed, 05 Sep 2018 19:37:32 +0000
Subject: [PATCH 15/21] SH: use for_each_of_cpu_node iterator
Message-Id: <20180905193738.19325-16-robh@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names in
preference to the deprecated (for FDT) device_type = "cpu".

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/sh/boards/of-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 26789ad28193..cde370cad4ae 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -64,7 +64,7 @@ static void sh_of_smp_probe(void)

 	init_cpu_possible(cpumask_of(0));

-	for_each_node_by_type(np, "cpu") {
+	for_each_of_cpu_node(np) {
 		const __be32 *cell = of_get_property(np, "reg", NULL);
 		u64 id = -1;
 		if (cell) id = of_read_number(cell, of_n_addr_cells(np));
--
2.17.1
