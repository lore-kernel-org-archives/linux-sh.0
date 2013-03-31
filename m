From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 31 Mar 2013 19:50:07 +0000
Subject: [PATCH 1/2] sh_eth: fix handling of no LINK signal
Message-Id: <201303312350.08153.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

The code handling the absent LINK signal (or the absent PSR register -- which
reflects the state of this signal) is quite naive and has probably never really
worked.  It's probably enough to say that this code is executed only on the LINK
change interrupt (sic!) but even if we actually have the signal and choose to
ignore it (it might be connected to PHY's link/activity LED output as on the
Renesas BOCK-W board), sh_eth_adjust_link() on which this code relies to update
'mdp->link' gets executed later than the LINK change interrupt where it is
checked, and so RX/TX never get enabled via ECMR register.

So, ignore the LINK changed interrupt iff LINK signal is absent (or just chosen
not to be used) or PSR register is absent, and enable/disable RX/TX directly in
sh_eth_adjust_link() in this case. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the David Miller's 'net.git' repo.

 drivers/net/ethernet/renesas/sh_eth.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: net/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net/drivers/net/ethernet/renesas/sh_eth.c
@@ -1216,10 +1216,7 @@ static void sh_eth_error(struct net_devi
 		if (felic_stat & ECSR_LCHNG) {
 			/* Link Changed */
 			if (mdp->cd->no_psr || mdp->no_ether_link) {
-				if (mdp->link = PHY_DOWN)
-					link_stat = 0;
-				else
-					link_stat = PHY_ST_LINK;
+				goto ignore_link;
 			} else {
 				link_stat = (sh_eth_read(ndev, PSR));
 				if (mdp->ether_link_active_low)
@@ -1242,6 +1239,7 @@ static void sh_eth_error(struct net_devi
 		}
 	}
 
+ignore_link:
 	if (intr_status & EESR_TWB) {
 		/* Write buck end. unused write back interrupt */
 		if (intr_status & EESR_TABT)	/* Transmit Abort int */
@@ -1392,12 +1390,16 @@ static void sh_eth_adjust_link(struct ne
 				(sh_eth_read(ndev, ECMR) & ~ECMR_TXF), ECMR);
 			new_state = 1;
 			mdp->link = phydev->link;
+			if (mdp->cd->no_psr || mdp->no_ether_link)
+				sh_eth_rcv_snd_enable(ndev);
 		}
 	} else if (mdp->link) {
 		new_state = 1;
 		mdp->link = PHY_DOWN;
 		mdp->speed = 0;
 		mdp->duplex = -1;
+		if (mdp->cd->no_psr || mdp->no_ether_link)
+			sh_eth_rcv_snd_disable(ndev);
 	}
 
 	if (new_state && netif_msg_link(mdp))
