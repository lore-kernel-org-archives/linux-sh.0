From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 07 Dec 2015 21:41:43 +0000
Subject: [PATCH 3/3] sh_eth: get rid of bb_{set|clr|read}()
Message-Id: <2620242.OINoAeziLK@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1582774.FcjyuztLtc@wasted.cogentembedded.com>
In-Reply-To: <1582774.FcjyuztLtc@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

After the MDIO bitbang code consolidation, there's no need anymore for
bb_{set|clr}() as well as bb_read() -- just expand them inline, thus
saving more LoCs...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |   27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -1015,35 +1015,20 @@ struct bb_info {
 	void *addr;
 };
 
-/* PHY bit set */
-static void bb_set(void *addr, u32 msk)
-{
-	iowrite32(ioread32(addr) | msk, addr);
-}
-
-/* PHY bit clear */
-static void bb_clr(void *addr, u32 msk)
-{
-	iowrite32((ioread32(addr) & ~msk), addr);
-}
-
-/* PHY bit read */
-static int bb_read(void *addr, u32 msk)
-{
-	return (ioread32(addr) & msk) != 0;
-}
-
 static void sh_mdio_ctrl(struct mdiobb_ctrl *ctrl, u32 mask, int set)
 {
 	struct bb_info *bitbang = container_of(ctrl, struct bb_info, ctrl);
+	u32 pir;
 
 	if (bitbang->set_gate)
 		bitbang->set_gate(bitbang->addr);
 
+	pir = ioread32(bitbang->addr);
 	if (set)
-		bb_set(bitbang->addr, mask);
+		pir |=  mask;
 	else
-		bb_clr(bitbang->addr, mask);
+		pir &= ~mask;
+	iowrite32(pir, bitbang->addr);
 }
 
 /* Data I/O pin control */
@@ -1066,7 +1051,7 @@ static int sh_get_mdio(struct mdiobb_ctr
 	if (bitbang->set_gate)
 		bitbang->set_gate(bitbang->addr);
 
-	return bb_read(bitbang->addr, PIR_MDI);
+	return (ioread32(bitbang->addr) & PIR_MDI) != 0;
 }
 
 /* MDC pin control */

