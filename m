From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 04 Feb 2010 06:58:28 +0000
Subject: [PATCH] usb: r8a66597-hcd: Fix up spinlock recursion in root hub polling.
Message-Id: <20100204065828.GB5574@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The current root hub polling code exhibits a spinlock recursion on the
private controller lock. r8a66597_root_hub_control() is called from
r8a66597_timer() which grabs the lock and disables IRQs. The following
chain emerges:

  r8a66597_timer() <-- lock taken
    r8a66597_root_hub_control()
      r8a66597_check_syssts()
        usb_hcd_poll_rh_status() <-- acquires the same lock
	/* insert death here */

The entire chain requires IRQs to be disabled, so we just unlock and
relock around the call to usb_hcd_poll_rh_status() while leaving the
IRQ state unchanged.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/usb/host/r8a66597-hcd.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 0ceec12..bee558a 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -1006,6 +1022,8 @@ static void start_root_hub_sampling(struct r8a66597 *r8a66597, int port,
 /* this function must be called with interrupt disabled */
 static void r8a66597_check_syssts(struct r8a66597 *r8a66597, int port,
 					u16 syssts)
+__releases(r8a66597->lock)
+__acquires(r8a66597->lock)
 {
 	if (syssts = SE0) {
 		r8a66597_write(r8a66597, ~ATTCH, get_intsts_reg(port));
@@ -1023,7 +1041,9 @@ static void r8a66597_check_syssts(struct r8a66597 *r8a66597, int port,
 			usb_hcd_resume_root_hub(r8a66597_to_hcd(r8a66597));
 	}
 
+	spin_unlock(&r8a66597->lock);
 	usb_hcd_poll_rh_status(r8a66597_to_hcd(r8a66597));
+	spin_lock(&r8a66597->lock);
 }
 
 /* this function must be called with interrupt disabled */
