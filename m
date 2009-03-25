From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 25 Mar 2009 08:54:23 +0000
Subject: [PATCH] sh7786: remove buggy definition from pinmux_data[]
Message-Id: <u1vskdc5w.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
This patch is for linux-next

 arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
index 373b344..54ca664 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
@@ -377,7 +377,6 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(PJ1_DATA, PJ1_IN, PJ1_OUT, PJ1_IN_PU),
 
 	/* PA FN */
-	PINMUX_MARK_BEGIN,
 	PINMUX_DATA(CDE_MARK,		P1MSEL2_0, PA7_FN),
 	PINMUX_DATA(DISP_MARK,		P1MSEL2_0, PA6_FN),
 	PINMUX_DATA(DR5_MARK,		P1MSEL2_0, PA5_FN),
-- 
1.5.6.3

