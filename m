From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 11 Nov 2008 03:19:11 +0000
Subject: [PATCH] fix sci type for SH7723
Message-Id: <4918F9AF.6040507@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch changes sci type of SH7723 from PORT_SCI to PORT_SCIFA.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index a7412ce..6d9e697 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -119,17 +119,17 @@ static struct plat_sci_port sci_platform_data[] = {
 	},{
 		.mapbase	= 0xa4e30000,
 		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCI,
+		.type		= PORT_SCIFA,
 		.irqs		= { 56, 56, 56, 56 },
 	},{
 		.mapbase	= 0xa4e40000,
 		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCI,
+		.type		= PORT_SCIFA,
 		.irqs		= { 88, 88, 88, 88 },
 	},{
 		.mapbase	= 0xa4e50000,
 		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCI,
+		.type		= PORT_SCIFA,
 		.irqs		= { 109, 109, 109, 109 },
 	}, {
 		.flags = 0,
-- 
1.5.5

