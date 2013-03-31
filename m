From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 31 Mar 2013 19:54:20 +0000
Subject: [PATCH 2/2] sh_eth: workaround for spurious ECI interrupt
Message-Id: <201303312354.20695.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

At least on Renesas R8A7778, EESR.ECI interrupt seems to fire regardless of its
mask in EESIPR register. I can 100% reproduce it with the following scenario:
target is booted with 'ip=on' option, and so IP-Config opens SoC Ether device
but doesn't get a proper reply and then succeeds with on-board SMC chip; then
I login and try to bring up the SoC Ether device with 'ifconfig', and I get
an ECI interrupt once request_irq() is called by sh_eth_open() (while interrupt
mask in EESIPR register is all 0), if that interrupt is accompanied by a pending
EESR.FRC (frame receive completion) interrupt, I get kernel oops in sh_eth_rx()
because sh_eth_ring_init() hasn't been called yet!

The solution I worked out is the following: in sh_eth_interrupt(), mask the
interrupt status from EESR register with the interrupt mask from EESIPR register
in order not to handle the disabled interrupts -- but forcing EESIPR.M_ECI bit
in this mask set because we always need to fully handle EESR.ECI interrupt in
sh_eth_error() in order to quench it (as it doesn't get cleared by just writing
1 to the this bit as all the other interrupts).

While at it, remove unneeded initializer for 'intr_status' variable and give it
*unsigned long* type, matching the type of sh_eth_read()'s result; fix comment.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Max Filippov <max.filippov@cogentembedded.com>

---
The patch is against the David Miller's 'net.git' repo, however I'm not sure if
it needs to be applied to it and not to 'net-next.git' (it should apply there
with line offsets) since R8A7778 support is not upstream yet.

 drivers/net/ethernet/renesas/sh_eth.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: net/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net/drivers/net/ethernet/renesas/sh_eth.c
@@ -1324,12 +1324,18 @@ static irqreturn_t sh_eth_interrupt(int 
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 	struct sh_eth_cpu_data *cd = mdp->cd;
 	irqreturn_t ret = IRQ_NONE;
-	u32 intr_status = 0;
+	unsigned long intr_status;
 
 	spin_lock(&mdp->lock);
 
-	/* Get interrpt stat */
+	/* Get interrupt status */
 	intr_status = sh_eth_read(ndev, EESR);
+	/* Mask it with the interrupt mask, forcing ECI interrupt to be always
+	 * enabled since it's the one that  comes thru regardless of the mask,
+	 * and we need to fully handle it in sh_eth_error() in order to quench
+	 * it as it doesn't get cleared by just writing 1 to the ECI bit...
+	 */
+	intr_status &= sh_eth_read(ndev, EESIPR) | DMAC_M_ECI;
 	/* Clear interrupt */
 	if (intr_status & (EESR_FRC | EESR_RMAF | EESR_RRF |
 			EESR_RTLF | EESR_RTSF | EESR_PRE | EESR_CERF |
