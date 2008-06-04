From: "Yusuke.Goda" <goda.yusuke@renesas.com>
Date: Wed, 04 Jun 2008 10:22:59 +0000
Subject: [PATCH] sh: Add SH7723 SCIF support
Message-Id: <48466D03.2040406@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yusuke Goda <goda.yusuke@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 566ce79..5559a11 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -16,6 +16,21 @@

 static struct plat_sci_port sci_platform_data[] = {
 	{
+		.mapbase        = 0xffe00000,
+		.flags          = UPF_BOOT_AUTOCONF,
+		.type           = PORT_SCIF,
+		.irqs           = { 80, 80, 80, 80 },
+	},{
+		.mapbase        = 0xffe10000,
+		.flags          = UPF_BOOT_AUTOCONF,
+		.type           = PORT_SCIF,
+		.irqs           = { 81, 81, 81, 81 },
+	},{
+		.mapbase        = 0xffe20000,
+		.flags          = UPF_BOOT_AUTOCONF,
+		.type           = PORT_SCIF,
+		.irqs           = { 82, 82, 82, 82 },
+	},{
 		.mapbase	= 0xa4e30000,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.type		= PORT_SCI,
-- 
1.5.4.5

