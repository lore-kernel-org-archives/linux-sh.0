From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Mar 2011 09:05:44 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: modify LCDC clock divider value
Message-Id: <w3pmxldhoyf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1v9weglx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1v9weglx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ap4evb WVGA LCDC panel expect 33.3MHz for dot-clock,
but current dot-clock was 50.0MHz.
This patch modify clock divider value.

Signed-off-by: Makoto Ueda <makoto.ueda.ub@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 3cf0951..81d6536 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1303,7 +1303,7 @@ static void __init ap4evb_init(void)
 
 	lcdc_info.clock_source			= LCDC_CLK_BUS;
 	lcdc_info.ch[0].interface_type		= RGB18;
-	lcdc_info.ch[0].clock_divider		= 2;
+	lcdc_info.ch[0].clock_divider		= 3;
 	lcdc_info.ch[0].flags			= 0;
 	lcdc_info.ch[0].lcd_size_cfg.width	= 152;
 	lcdc_info.ch[0].lcd_size_cfg.height	= 91;
-- 
1.7.1

