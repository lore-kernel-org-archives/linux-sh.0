From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 04 Dec 2009 14:52:53 +0000
Subject: [PATCH (sh-2.6.30.y) 11/13] sh: intc: Fixed resume from hibernation in the intc
Message-Id: <1259938375-27499-11-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes the resume from hibernation in the intc interrupt
controller when it manages 'redirect' irq

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 drivers/sh/intc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/sh/intc.c b/drivers/sh/intc.c
index 70c5d73..dc59427 100644
--- a/drivers/sh/intc.c
+++ b/drivers/sh/intc.c
@@ -774,6 +774,8 @@ static int intc_suspend(struct sys_device *dev, pm_message_t state)
 		if (d->state.event != PM_EVENT_FREEZE)
 			break;
 		for_each_irq_desc(irq, desc) {
+			if (desc->handle_irq = intc_redirect_irq)
+				continue;
 			if (desc->chip != &d->chip)
 				continue;
 			if (desc->status & IRQ_DISABLED)
-- 
1.6.2.5

