From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 15 Sep 2009 00:21:34 +0000
Subject: [PATCH 1/2 v2] sh: add kycr2_delay for sh_keysc
Message-Id: <ubpldhxbl.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

After KYCR2 is set, udelay  might become necessary
when the connected KEY is few.
This patch add kycr2_delay for this problem.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
v1 -> v2

add if (pdata->kycr2_delay)

 arch/sh/include/asm/sh_keysc.h    |    1 +
 drivers/input/keyboard/sh_keysc.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/sh_keysc.h b/arch/sh/include/asm/sh_keysc.h
index b5a4dd5..4a65b1e 100644
--- a/arch/sh/include/asm/sh_keysc.h
+++ b/arch/sh/include/asm/sh_keysc.h
@@ -7,6 +7,7 @@ struct sh_keysc_info {
 	enum { SH_KEYSC_MODE_1, SH_KEYSC_MODE_2, SH_KEYSC_MODE_3 } mode;
 	int scan_timing; /* 0 -> 7, see KYCR1, SCN[2:0] */
 	int delay;
+	int kycr2_delay;
 	int keycodes[SH_KEYSC_MAXKEYS];
 };
 
diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index cea70e6..68fd502 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -80,6 +80,9 @@ static irqreturn_t sh_keysc_isr(int irq, void *dev_id)
 		iowrite16(KYCR2_IRQ_LEVEL | (keyin_set << 8),
 			  priv->iomem_base + KYCR2_OFFS);
 
+		if (pdata->kycr2_delay)
+			udelay(pdata->kycr2_delay);
+
 		keys ^= ~0;
 		keys &= (1 << (sh_keysc_mode[pdata->mode].keyin *
 			       sh_keysc_mode[pdata->mode].keyout)) - 1;
-- 
1.6.0.4

