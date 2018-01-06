From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 06 Jan 2018 21:26:47 +0000
Subject: [PATCH] sh_eth: fix TXALCR1 offsets
Message-Id: <20180106212652.818833413@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The  TXALCR1 offsets are incorrect in the register offset tables, most
probably due to copy&paste error.  Luckily, the driver never uses this
register. :-)

Fixes: 4a55530f38e4 ("net: sh_eth: modify the definitions of register")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: net/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net/drivers/net/ethernet/renesas/sh_eth.c
@@ -147,7 +147,7 @@ static const u16 sh_eth_offset_gigabit[S
 	[FWNLCR0]	= 0x0090,
 	[FWALCR0]	= 0x0094,
 	[TXNLCR1]	= 0x00a0,
-	[TXALCR1]	= 0x00a0,
+	[TXALCR1]	= 0x00a4,
 	[RXNLCR1]	= 0x00a8,
 	[RXALCR1]	= 0x00ac,
 	[FWNLCR1]	= 0x00b0,
@@ -399,7 +399,7 @@ static const u16 sh_eth_offset_fast_sh3_
 	[FWNLCR0]	= 0x0090,
 	[FWALCR0]	= 0x0094,
 	[TXNLCR1]	= 0x00a0,
-	[TXALCR1]	= 0x00a0,
+	[TXALCR1]	= 0x00a4,
 	[RXNLCR1]	= 0x00a8,
 	[RXALCR1]	= 0x00ac,
 	[FWNLCR1]	= 0x00b0,

