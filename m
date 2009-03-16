From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 16 Mar 2009 05:14:14 +0000
Subject: [PATCH] sh-clkfwk  Safer resume from hibenration
Message-Id: <49BDE026.7020203@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090508020502010004060003"
List-Id: <linux-sh.vger.kernel.org>
References: <49BA1461.7070207@st.com>
In-Reply-To: <49BA1461.7070207@st.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------090508020502010004060003
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a possible problem in the resume from
hibenration. It temporaneally saves the clk->rate on the
stack to avoid any possible change during the clk->set_parent(..)
call

Regards
 Francesco

P.S.: Added empty line


--------------090508020502010004060003
Content-Type: text/x-patch;
 name="0001-sh-clkfwk-Safer-resume-from-hibenration.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-sh-clkfwk-Safer-resume-from-hibenration.patch"

From c4554c101842c0de279d222c1b45c309dfaaa181 Mon Sep 17 00:00:00 2001
From: Francesco Virlinzi <francesco.virlinzi@st.com>
Date: Mon, 16 Mar 2009 06:12:28 +0100
Subject: [PATCH] sh: clkfwk: Safer resume from hibenration

This patch fixes a possible problem in the resume from
hibenration. It temporaneally saves the clk->rate on the
stack to avoid any possible change during the clk->set_parent(..)
call

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 arch/sh/kernel/cpu/clock.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 3209a87..1dc8964 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -372,12 +372,14 @@ static int clks_sysdev_suspend(struct sys_device *dev, pm_message_t state)
 		if (prev_state.event == PM_EVENT_FREEZE) {
 			list_for_each_entry(clkp, &clock_list, node)
 				if (likely(clkp->ops)) {
+					unsigned long rate = clkp->rate;
+
 					if (likely(clkp->ops->set_parent))
 						clkp->ops->set_parent(clkp,
 							clkp->parent);
 					if (likely(clkp->ops->set_rate))
 						clkp->ops->set_rate(clkp,
-							clkp->rate, NO_CHANGE);
+							rate, NO_CHANGE);
 					else if (likely(clkp->ops->recalc))
 						clkp->ops->recalc(clkp);
 					}
-- 
1.5.6.6


--------------090508020502010004060003--
