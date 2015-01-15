From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 15 Jan 2015 10:52:19 +0000
Subject: [PATCH] sh_eth: Fix addition of .trscer_err_mask to wrong SoC data
Message-Id: <1421319139-22655-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

commit b284fbe3b3ef9cf8 ("sh_eth: Fix access to TRSCER register") wanted
to add a .trscer_err_mask value to the R-Car Gen2 family-specific data
structure (r8a779x_data), but it was accidentally added to the
SH7724-specific data structure (sh7724_data).

Presumably this happened due to a patch conflict with commit
d407bc0203539031 ("sh-eth: Set fdr_value of R-Car SoCs"), which added
another field at the same position.

Move the field setting to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: b284fbe3b3ef9cf8 ("sh_eth: Fix access to TRSCER register")
---
Commit b284fbe3b3ef9cf8 is in Linus' tree.

 drivers/net/ethernet/renesas/sh_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 37583a9d88534346..8d227d919e194847 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -498,6 +498,8 @@ static struct sh_eth_cpu_data r8a779x_data = {
 			  EESR_ECI,
 	.fdr_value	= 0x00000f0f,
 
+	.trscer_err_mask = DESC_I_RINT8,
+
 	.apr		= 1,
 	.mpr		= 1,
 	.tpauser	= 1,
@@ -538,8 +540,6 @@ static struct sh_eth_cpu_data sh7724_data = {
 			  EESR_RDE | EESR_RFRMER | EESR_TFE | EESR_TDE |
 			  EESR_ECI,
 
-	.trscer_err_mask = DESC_I_RINT8,
-
 	.apr		= 1,
 	.mpr		= 1,
 	.tpauser	= 1,
-- 
1.9.1

