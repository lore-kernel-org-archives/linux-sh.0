From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 06 Jun 2014 12:44:35 +0000
Subject: [PATCH 4/4] drivers: sh: Enable PM runtime for new R-Car Gen2 SoCs
Message-Id: <2f35fb3c8a6018a0a5fe4a7fb0948b853c157256.1402058435.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1402058435.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1402058435.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>

From: Geert Uytterhoeven <geert+renesas@glider.be>

The PM runtime code should also be enabled for:
  - r8a7792 (R-Car V2H)
  - r8a7793 (R-Car M2-N)
  - r8a7794 (R-Car E2)

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pm_runtime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 25eafbe..72f6381 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -88,6 +88,9 @@ static int __init sh_pm_runtime_init(void)
 		    !of_machine_is_compatible("renesas,r8a7779") &&
 		    !of_machine_is_compatible("renesas,r8a7790") &&
 		    !of_machine_is_compatible("renesas,r8a7791") &&
+		    !of_machine_is_compatible("renesas,r8a7792") &&
+		    !of_machine_is_compatible("renesas,r8a7793") &&
+		    !of_machine_is_compatible("renesas,r8a7794") &&
 		    !of_machine_is_compatible("renesas,sh7372") &&
 		    !of_machine_is_compatible("renesas,sh73a0"))
 			return 0;
-- 
1.8.4

