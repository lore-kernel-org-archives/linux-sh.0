From: takasi-y@ops.dti.ne.jp
Date: Tue, 08 Oct 2013 05:34:03 +0000
Subject: [PATCH v2 3/3] ARM: shmobile: kzm9d: Use common clock framework
Message-Id: <20131008143403.c11f294c8a1701a2ab3bc5fd@ops.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
In-Reply-To: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use common clock framework version of clock
 drivers/clk/shmobile/clk-emev2.c
instead of sh-clkfwk version
 arch/arm/mach-shmobile/clock-emev2.c
when it is configured as a part of multi-platform.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
---
 arch/arm/mach-shmobile/board-kzm9d-reference.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
index 054d8d5..853003c 100644
--- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9d-reference.c
@@ -20,15 +20,14 @@
 
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/clk-provider.h>
 #include <mach/emev2.h>
 #include <mach/common.h>
 #include <asm/mach/arch.h>
 
 static void __init kzm9d_add_standard_devices(void)
 {
-	if (!IS_ENABLED(CONFIG_COMMON_CLK))
-		emev2_clock_init();
-
+	of_clk_init(NULL);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.8.1.5
