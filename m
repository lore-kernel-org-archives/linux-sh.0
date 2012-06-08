From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 08 Jun 2012 06:05:01 +0000
Subject: [PATCH 3/5] sh: SH7734: Fix INTC_VECT of SCIF0 and SCIF1
Message-Id: <1339135503-1997-3-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As for INTC_VECT of SCIF0 and SCIF1, 0x8C0 and 0x8E0 are right.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index 6d168f4..658ca6c 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -674,8 +674,8 @@ static struct intc_vect vectors[] __initdata = {
 	INTC_VECT(LBSCATA, 0x840),
 	INTC_VECT(I2C0, 0x860),
 	INTC_VECT(RCAN0, 0x880),
-	INTC_VECT(SCIF0, 0x8A0),
-	INTC_VECT(SCIF1, 0x8C0),
+	INTC_VECT(SCIF0, 0x8C0),
+	INTC_VECT(SCIF1, 0x8E0),
 	INTC_VECT(SCIF2, 0x900),
 	INTC_VECT(SCIF3, 0x920),
 	INTC_VECT(SCIF4, 0x940),
-- 
1.7.10

