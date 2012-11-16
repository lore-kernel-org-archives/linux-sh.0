From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 16 Nov 2012 10:34:41 +0000
Subject: [PATCH 01/04] ARM: mach-shmobile: sh7372 INTC DT INTCA/INTCS typo fix
Message-Id: <20121116103441.4231.45469.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix the sh7372 INTC DT code for INTCA to use ARRAY_SIZE()
on intca_resources instead of intcs_resources.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to the devel/of branch of
 git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

 arch/arm/mach-shmobile/intc-sh7372.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2012-11-15 19:13:20.000000000 +0900
@@ -49,7 +49,7 @@ static int sh7372_intca_of_init(struct d
 		return -ENODEV;
 
 	ret = of_sh_intc_get_meminfo(np,
-				intca_resources, ARRAY_SIZE(intcs_resources));
+				intca_resources, ARRAY_SIZE(intca_resources));
 	if (ret)
 		goto error;
 
