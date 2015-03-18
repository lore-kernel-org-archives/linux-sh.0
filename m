From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 18 Mar 2015 19:46:57 +0000
Subject: [PATCH/RFC 5/5] drivers: sh: Disable PM runtime for multi-platform R-Car Gen2 with genpd
Message-Id: <1426708017-28885-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Now we have an R-Car Gen2 CPG Clock Domain driver using the generic PM
domain to take care of PM runtime management of the module clocks, we no
longer need the legacy default PM domain hack, which also prevents
registering the real PM domain.

Hence do not enable it when running a multi-platform kernel with genpd
support on an R-Car Gen2 SoC.

The default PM domain is still needed:
  - for platforms without genpd support,
  - for the legacy (non-DT) case, where genpd may take over later,
  - if genpd is not enabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/sh/pm_runtime.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index fe8875f0d7be1155..97d5738f21ae8f04 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -83,15 +83,15 @@ static int __init sh_pm_runtime_init(void)
 #ifndef CONFIG_PM_GENERIC_DOMAINS_OF
 		    !of_machine_is_compatible("renesas,r8a73a4") &&
 		    !of_machine_is_compatible("renesas,r8a7740") &&
-		    !of_machine_is_compatible("renesas,sh73a0") &&
-#endif
-		    !of_machine_is_compatible("renesas,r8a7778") &&
-		    !of_machine_is_compatible("renesas,r8a7779") &&
 		    !of_machine_is_compatible("renesas,r8a7790") &&
 		    !of_machine_is_compatible("renesas,r8a7791") &&
 		    !of_machine_is_compatible("renesas,r8a7792") &&
 		    !of_machine_is_compatible("renesas,r8a7793") &&
-		    !of_machine_is_compatible("renesas,r8a7794"))
+		    !of_machine_is_compatible("renesas,r8a7794") &&
+		    !of_machine_is_compatible("renesas,sh73a0") &&
+#endif
+		    !of_machine_is_compatible("renesas,r8a7778") &&
+		    !of_machine_is_compatible("renesas,r8a7779"))
 			return 0;
 	}
 
-- 
1.9.1

