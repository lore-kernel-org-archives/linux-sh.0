From: Stephen Boyd <sboyd@codeaurora.org>
Date: Thu, 27 Feb 2014 00:50:29 +0000
Subject: Re: [PATCH] clk: shmobile: rcar-gen2: Use kick bit to allow Z clock frequency change
Message-Id: <530E8BD5.4000903@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <530C9D2A.8030409@baylibre.com>
In-Reply-To: <530C9D2A.8030409@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 02/26/14 15:43, Mike Turquette wrote:
> Quoting Laurent Pinchart (2014-02-26 13:53:03)
>> Hi Mike,
>>
>> On Wednesday 26 February 2014 12:54:55 Mike Turquette wrote:
>>> Quoting Laurent Pinchart (2014-02-25 09:48:38)
>>>> On Tuesday 25 February 2014 18:07:54 Benoit Cousson wrote:
>>>>> On 25/02/2014 17:01, Laurent Pinchart wrote:
>>>>>> On Tuesday 25 February 2014 14:39:54 Benoit Cousson wrote:
>>>>>>> +  /*
>>>>>>> +   * Set KICK bit in FRQCRB to update hardware setting and
>>>>>>> +   * wait for completion.
>>>>>>> +   */
>>>>>>> +  kick = clk_readl(zclk->kick_reg);
>>>>>>> +  kick |= CPG_FRQCRB_KICK;
>>>>>>> +  clk_writel(kick, zclk->kick_reg);
>>>>>> Does CCF guarantee that two set_rate calls for different clocks will
>>>>>> not occur concurrently ? If so a brief comment would be nice.
>>>>>> Otherwise we need a lock around this.
>>>>> So far, this is the only user of the register. That's why there is no
>>>>> lock. It is explained in the changelog. But if you want I can re-use the
>>>>> same comment here.
>>>> A comment would be nice, yes. You can make it shorter than the commit
>>>> message.
>>> CCF holds a global mutex during a call to clk_set_rate. So clk_prepare,
>>> clk_unprepare, clk_set_parent or a competing clk_set_rate will not touch
>>> this register during the critical section.
>>>
>>> However it is possible to reenter the framework, but usually you control
>>> that code flow.
>>>
>>> The main two reasons to introduce your own more granular register-level
>>> locking are:
>>>
>>> 1) clk_enable & clk_disable hold a separate global spinlock (not the
>>> global mutex), so if this register is used for set_rate operations AND
>>> enable/disable operations then you'll need a spinlock.
>>>
>>> 2) Other stuff outside of the clk framework touches this register
>>> (sounds like it is not the case here).
>> Thanks a lot for the explanation. I've cooked up a small documentation patch 
>> to avoid the need to repeat this over and over, I'll send it separately.
>>
>> Looking at the implementation I found something that looked like a locking bug 
>> in the Qualcomm clock drivers at first sight.
>>
>> clk-rpg.c calls __clk_is_enabled() from within its configure_bank() function. 
>> That function ends up being called from within the .set_rate, .set_parent and 
>> .set_rate_and_parent operations. This leads to __clk_is_enabled() being called 
>> without the enable spinlock held.
>>
>> Now, clk-rpg.c provides an .is_enabled handler (clk_is_enabled_regmap) so 
>> we're at least not accessing the clock enable_count counter without the proper 
>> lock being held. I don't know whether clk_is_enabled_regmap() will handle 
>> locking properly though.
>>
>> Exporting __clk_is_enabled() looks a bit dangerous to me. It might make sense 
>> to replace the __clk_is_enabled() call in clk-rpg.c with a direct call to 
>> clk_is_enabled_regmap(), but we still have two other users (namely 
>> drivers/cpufreq/kirkwood-cpufreq.c and arch/arm/mach-omap2/pm24xx.c) in the 
>> mainline kernel.

(I'm guessing clk-rpg.c is actually clk-rcg.c?)

It's safe for the set_parent and set_parent_and_rate case because of the
way we do the parent switch (see __clk_set_parent_before() in
particular). The enable/prepare state of the clock cannot change while
these ops are called. If the clock is prepared before configure_bank()
is called then __clk_set_parent_before() has enabled the clock for us.
If the clock isn't prepared before configure_bank() is called then we're
holding the prepare lock and nobody can enable the clock without first
preparing the clock (which means they would need to grab the prepare
lock and wait for us to be done).

It looks like the only case where it actually is racy is a plain
set_rate, in which case we're not switching parents and a
clk_enable()/disable() could happen in the middle of configure_bank().
Sad. I doubt anyone will ever actually do that in practice, but sure
theoretical problems are still problems. This patch should fix it.

---8<---
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] clk: qcom: Synchronize configure_bank() with enable/disable

Calling __clk_is_enabled() in configure_bank() isn't safe without
synchronizing with enable/disable of this clock. Introduce a
global spinlock that we grab in enable, disable and across this
bank configuration function so that the clock can't be enabled or
disabled while configure_bank() is running.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index abfc2b675aea..51c08bc22378 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -22,6 +22,9 @@
 
 #include "clk-rcg.h"
 
+/* Synchronize .enable/.disable with plain .set_rate */
+static DEFINE_SPINLOCK(rcg_enable_lock);
+
 static u32 ns_to_src(struct src_sel *s, u32 ns)
 {
 	ns >>= s->src_sel_shift;
@@ -202,7 +205,9 @@ static void configure_bank(struct clk_dyn_rcg *rcg, const struct freq_tbl *f)
 	u32 bank_reg;
 	bool banked_mn = !!rcg->mn[1].width;
 	struct clk_hw *hw = &rcg->clkr.hw;
+	unsigned long flags;
 
+	spin_lock_irqsave(&rcg_enable_lock, flags);
 	enabled = __clk_is_enabled(hw->clk);
 
 	regmap_read(rcg->clkr.regmap, rcg->ns_reg, &ns);
@@ -251,6 +256,7 @@ static void configure_bank(struct clk_dyn_rcg *rcg, const struct freq_tbl *f)
 		*regp ^= BIT(rcg->mux_sel_bit);
 		regmap_write(rcg->clkr.regmap, bank_reg, *regp);
 	}
+	spin_unlock_irqrestore(&rcg_enable_lock, flags);
 }
 
 static int clk_dyn_rcg_set_parent(struct clk_hw *hw, u8 index)
@@ -492,6 +498,27 @@ static int clk_dyn_rcg_set_rate_and_parent(struct clk_hw *hw,
 	return __clk_dyn_rcg_set_rate(hw, rate);
 }
 
+static int clk_dyn_rcg_enable(struct clk_hw *hw)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rcg_enable_lock, flags);
+	ret = clk_enable_regmap(hw);
+	spin_unlock_irqrestore(&rcg_enable_lock, flags);
+
+	return ret;
+}
+
+static void clk_dyn_rcg_disable(struct clk_hw *hw)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&rcg_enable_lock, flags);
+	clk_disable_regmap(hw);
+	spin_unlock_irqrestore(&rcg_enable_lock, flags);
+}
+
 const struct clk_ops clk_rcg_ops = {
 	.enable = clk_enable_regmap,
 	.disable = clk_disable_regmap,
@@ -504,9 +531,9 @@ const struct clk_ops clk_rcg_ops = {
 EXPORT_SYMBOL_GPL(clk_rcg_ops);
 
 const struct clk_ops clk_dyn_rcg_ops = {
-	.enable = clk_enable_regmap,
+	.enable = clk_dyn_rcg_enable,
 	.is_enabled = clk_is_enabled_regmap,
-	.disable = clk_disable_regmap,
+	.disable = clk_dyn_rcg_disable,
 	.get_parent = clk_dyn_rcg_get_parent,
 	.set_parent = clk_dyn_rcg_set_parent,
 	.recalc_rate = clk_dyn_rcg_recalc_rate,

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

