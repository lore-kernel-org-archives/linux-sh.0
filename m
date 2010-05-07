From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 07 May 2010 09:19:08 +0000
Subject: [PATCH] sh: fix the id of scif in SH7757
Message-Id: <4BE3DB0C.3020006@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Because the value of CONFIG_SERIAL_SH_SCI_NR_UARTS is 3.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 444aca9..93b7aa4 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -26,7 +26,7 @@ static struct plat_sci_port scif2_platform_data = {

 static struct platform_device scif2_device = {
 	.name		= "sh-sci",
-	.id		= 2,
+	.id		= 0,
 	.dev		= {
 		.platform_data	= &scif2_platform_data,
 	},
@@ -41,7 +41,7 @@ static struct plat_sci_port scif3_platform_data = {

 static struct platform_device scif3_device = {
 	.name		= "sh-sci",
-	.id		= 3,
+	.id		= 1,
 	.dev		= {
 		.platform_data	= &scif3_platform_data,
 	},
@@ -56,7 +56,7 @@ static struct plat_sci_port scif4_platform_data = {

 static struct platform_device scif4_device = {
 	.name		= "sh-sci",
-	.id		= 4,
+	.id		= 2,
 	.dev		= {
 		.platform_data	= &scif4_platform_data,
 	},
-- 
1.5.5
