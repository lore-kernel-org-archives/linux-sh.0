From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 05 Jun 2013 21:11:17 +0000
Subject: [PATCH v4 2/8] sh_eth: use EDSR_ENALL to set EDSR
Message-Id: <201306060111.17880.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201306060106.51082.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306060106.51082.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Use now always available EDSR_ENALL instead of the bare number to set EDSR.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
[Sergei: added the changelog, reworded the subject, changing the prefix.]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 4:
- added the changelog;
- reworded the subject, changing the prefix.

 drivers/net/ethernet/renesas/sh_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -523,7 +523,7 @@ static int sh_eth_reset(struct net_devic
 	int ret = 0;
 
 	if (sh_eth_is_gether(mdp)) {
-		sh_eth_write(ndev, 0x03, EDSR);
+		sh_eth_write(ndev, EDSR_ENALL, EDSR);
 		sh_eth_write(ndev, sh_eth_read(ndev, EDMR) | EDMR_SRST_GETHER,
 				EDMR);
 
