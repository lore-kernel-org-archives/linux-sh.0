From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 25 Aug 2015 07:57:56 +0000
Subject: [PATCH] net: compile renesas directory if NET_VENDOR_RENESAS is configured
Message-Id: <1440489476-26700-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

Currently the renesas ethernet driver directory is compiled if SH_ETH is
configured rather than NET_VENDOR_RENESAS. Although incorrect that was
quite harmless as until recently as SH_ETH configured the only driver in
the renesas directory. However, as of c156633f1353 ("Renesas Ethernet AVB
driver proper") the renesas directory includes another driver, configured
by RAVB, and it makes little sense for it to have a hidden dependency on
SH_ETH.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
[horms: rewrote changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/net/ethernet/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index f42177b11723..ddfc808110a1 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -65,7 +65,7 @@ obj-$(CONFIG_NET_VENDOR_PASEMI) += pasemi/
 obj-$(CONFIG_NET_VENDOR_QLOGIC) += qlogic/
 obj-$(CONFIG_NET_VENDOR_QUALCOMM) += qualcomm/
 obj-$(CONFIG_NET_VENDOR_REALTEK) += realtek/
-obj-$(CONFIG_SH_ETH) += renesas/
+obj-$(CONFIG_NET_VENDOR_RENESAS) += renesas/
 obj-$(CONFIG_NET_VENDOR_RDC) += rdc/
 obj-$(CONFIG_NET_VENDOR_ROCKER) += rocker/
 obj-$(CONFIG_NET_VENDOR_SAMSUNG) += samsung/
-- 
2.1.4

