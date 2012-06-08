From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 08 Jun 2012 06:05:03 +0000
Subject: [PATCH 5/5] sh: SH7734: Remove unnecessary define
Message-Id: <1339135503-1997-5-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index 061d5db..32b15e7 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -567,7 +567,6 @@ void __init plat_early_device_setup(void)
 		ARRAY_SIZE(sh7734_early_devices));
 }
 
-#define GROUP 0
 enum {
 	UNUSED = 0,
 
-- 
1.7.10

