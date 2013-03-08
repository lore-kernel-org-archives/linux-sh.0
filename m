From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 08 Mar 2013 08:20:17 +0000
Subject: [PATCH 1/4] clocksource: sh_cmt: Set initcall level to subsys
Message-Id: <1362730820-25417-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1362730820-25417-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1362730820-25417-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The reason for this is to ensure that CMT is probed earlier
than with its previous initcall level, module init.

This came up as a problem with using kzm9g-reference which does
not make use of early timers or devices. In that scenario initialisation
of SDHI and MMCIF both stall on msleep() calls due to the absence
of a initialised clock source.

Boot tested on: armadillo800eva, mackerel and kzm9g

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/sh_cmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 488c14c..1a7743a 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -791,7 +791,7 @@ static void __exit sh_cmt_exit(void)
 }
 
 early_platform_init("earlytimer", &sh_cmt_device_driver);
-module_init(sh_cmt_init);
+subsys_initcall(sh_cmt_init);
 module_exit(sh_cmt_exit);
 
 MODULE_AUTHOR("Magnus Damm");
-- 
1.7.10.4

