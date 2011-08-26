From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Aug 2011 07:27:45 +0000
Subject: [PATCH] ARM: mach-shmobile: clock-sh73a0: tidyup CKSCR main clock selecter
Message-Id: <874o14pr82.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pmxozyxra.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pmxozyxra.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

MAINCKSEL is [29:28], not [27:24]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 7da8af6..84fd33c 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -365,7 +365,7 @@ void __init sh73a0_clock_init(void)
 	__raw_writel(0x108, SD2CKCR);
 
 	/* detect main clock parent */
-	switch ((__raw_readl(CKSCR) >> 24) & 0x03) {
+	switch ((__raw_readl(CKSCR) >> 28) & 0x03) {
 	case 0:
 		main_clk.parent = &sh73a0_extal1_clk;
 		break;
-- 
1.7.4.1

