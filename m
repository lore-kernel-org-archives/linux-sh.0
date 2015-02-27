From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 27 Feb 2015 01:25:49 +0000
Subject: [PATCH] drivers: sh: Disable PM runtime for multi-platform r8a7740 with genpd
Message-Id: <a5cb514f1f689a48595370a368b568e2f551ddfd.1425000135.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1425000135.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1425000135.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>

From: Geert Uytterhoeven <geert+renesas@glider.be>

If the default PM domain using PM_CLK is used for PM runtime, the real PM
domain(s) cannot be registered from DT later.

Hence do not enable it when running a multi-platform kernel with genpd
support on an r8a7740. The R-Mobile PM domain driver will take care of
PM runtime management of the module clocks.

The default PM domain is still needed for:
  - platforms without genpd support,
  - the legacy (non-DT) case, where genpd may take over later, except
    for the C5 "always on" PM domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pm_runtime.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index f3ee439d..cd4c293 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -81,7 +81,9 @@ static int __init sh_pm_runtime_init(void)
 		if (!of_machine_is_compatible("renesas,emev2") &&
 		    !of_machine_is_compatible("renesas,r7s72100") &&
 		    !of_machine_is_compatible("renesas,r8a73a4") &&
+#ifndef CONFIG_PM_GENERIC_DOMAINS_OF
 		    !of_machine_is_compatible("renesas,r8a7740") &&
+#endif
 		    !of_machine_is_compatible("renesas,r8a7778") &&
 		    !of_machine_is_compatible("renesas,r8a7779") &&
 		    !of_machine_is_compatible("renesas,r8a7790") &&
-- 
2.1.4

