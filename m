From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 17 Jun 2011 02:30:56 +0000
Subject: [PATCH] sh: Fix build by forgetting comma
Message-Id: <1308277856-16708-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4/setup-sh7750.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index c10db5b..98cc0c7 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -38,7 +38,7 @@ static struct platform_device rtc_device = {
 
 static struct plat_sci_port sci_platform_data = {
 	.mapbase	= 0xffe00000,
-	.port_reg	= 0xffe0001C
+	.port_reg	= 0xffe0001C,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.scscr		= SCSCR_TE | SCSCR_RE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
-- 
1.7.5.4

