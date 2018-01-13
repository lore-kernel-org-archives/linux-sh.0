From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 13 Jan 2018 17:22:01 +0000
Subject: [PATCH] sh_eth: dix dumping ARSTR
Message-Id: <20180113172207.201026516@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

ARSTR  is always located at the start of the TSU register region, thus
using add_reg()  instead of add_tsu_reg() in __sh_eth_get_regs() to dump it
causes EDMR or EDSR (depending on the register layout) to be dumped instead
of ARSTR.  Use the correct condition/macro there...

Fixes: 6b4b4fead342 ("sh_eth: Implement ethtool register dump operations")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: net/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net/drivers/net/ethernet/renesas/sh_eth.c
@@ -2089,8 +2089,8 @@ static size_t __sh_eth_get_regs(struct n
 		add_reg(CSMR);
 	if (cd->select_mii)
 		add_reg(RMII_MII);
-	add_reg(ARSTR);
 	if (cd->tsu) {
+		add_tsu_reg(ARSTR);
 		add_tsu_reg(TSU_CTRST);
 		add_tsu_reg(TSU_FWEN0);
 		add_tsu_reg(TSU_FWEN1);

