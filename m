From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Sun, 06 Dec 2015 11:42:20 +0000
Subject: [PATCH net] ravb: Remove clear unhandled interrupt
Message-Id: <1449402140-24272-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

AVB-DMAC Reception Warning interrupt is not enabled, so it is not
necessary to clear the interrupt.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the master branch of David Miller's networking
tree.

 drivers/net/ethernet/renesas/ravb_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ed5da4d..b8fd5a5 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1471,7 +1471,6 @@ static int ravb_close(struct net_device *ndev)
 
 	/* Disable interrupts by clearing the interrupt masks. */
 	ravb_write(ndev, 0, RIC0);
-	ravb_write(ndev, 0, RIC1);
 	ravb_write(ndev, 0, RIC2);
 	ravb_write(ndev, 0, TIC);
 
-- 
1.9.1

