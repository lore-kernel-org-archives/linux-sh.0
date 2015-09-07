From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Sep 2015 16:54:03 +0000
Subject: Re: Regression due to dropping "clock-output-names" (was: Re: [PATCH v5 02/05] clk: shmobile: Add Re
Message-Id: <CANqRtoSmr_7SGxRtvYY-d3pObuU+NPjFqTiSym2NZMWGqdAyFA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWXpkiKwywgT37EP-iSc9sLOiWAjFzNeAE+T5KJzaNwfA@mail.gmail.com>
	<CAMuHMdWScUcBuAMcYzkTi1wV3OnkDJ7Vb86iuD_OJfzDmTKTQg@mail.gmail.com>
In-Reply-To: <CAMuHMdWScUcBuAMcYzkTi1wV3OnkDJ7Vb86iuD_OJfzDmTKTQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Geert, Mike, Stephen, all,

On Thu, Sep 3, 2015 at 5:22 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Ping?

Btw, I've just sent off the V7 series which still has this issue:
[PATCH v7 00/05] Renesas R-Car Gen3 CPG support V7

From my point of view it looks like some core CCF changes are needed
to allow us to drop "clock-output-names" for the CPG node. I've
written some ugly prototype code to patch things together and I've
pasted it in as a proof-of-concent patch below. My apologies in
advance if gmail mangled the inline patch somehow...

> On Mon, Aug 31, 2015 at 5:56 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Mon, Aug 31, 2015 at 2:49 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>>>
>>> This V5 patch adds initial CPG support for R-Car Generation 3 and in
>>> particular the R8A7795 SoC.
>>>
>>> The R-Car Gen3 clock hardware has a register write protection feature that
>>> needs to be shared between the CPG function needs to be shared between
>>> the CPG and MSTP hardware somehow. So far this feature is simply ignored.
>>>
>>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>>> ---
>>>
>>>  Changes since V4: (Magnus Damm <damm+renesas@opensource.se>)
>>>  - Simplified clks array handling - thanks Geert!
>>>  - Updated th DT binding documentation to reflect latest state
>>>  - of_property_count_strings() -> of_property_count_u32_elems() fix
>>>
>>>  Changes since V3: (Magnus Damm <damm+renesas@opensource.se>)
>>>  - Reworked driver to incorporate most feedback from Stephen Boyd - thanks!!
>>>  - Major things like syscon and driver model require more discussion.
>>>  - Added hunk to build drivers/clk/shmobile if ARCH_RENESAS is set.
>>>
>>>  Changes since V2: (Magnus Damm <damm+renesas@opensource.se>)
>>>  - Reworked driver to rely on clock index instead of strings.
>>>  - Dropped use of "clock-output-names".
>>
>> Unfortunately dropping "clock-output-names" causes a regression: it turns
>> out all fixed-factor clocks that have <&cpg_clocks R8A7795_CLK_*> as a parent
>> have lost their parent clock, and have rate zero.
>>
>> E.g. instead of
>>
>>    clock                         enable_cnt  prepare_cnt        rate
>> accuracy   phase
>> ----------------------------------------------------------------------------------------
>>  extal                                    1            1    16666600
>>    50000 0
>>     main                                  1            1     8333300
>>    50000 0
>>        pll1                               1            2   799996800
>>    50000 0
>>           cl                              0            0    16666600
>>    50000 0
>>           s3                              1            1   133332800
>>    50000 0
>>              s3d4                         1            2    33333200
>>    50000 0
>>                 mstp3_clks.10             2            2    33333200
>>    50000 0
>>
>> /sys/kernel/debug/clk/clk_summary now has:
>>
>>    clock                         enable_cnt  prepare_cnt        rate
>> accuracy   phase
>> ----------------------------------------------------------------------------------------
>>  extal                                    0            0    16666600
>>    50000 0
>>     main                                  0            0     8333300
>>    50000 0
>>        pll1                               0            0   799996800
>>    50000 0
>>  cl                                       0            0           0
>>        0 0
>>  s3                                       1            1           0
>>        0 0
>>     s3d4                                  1            2           0
>>        0 0
>>        mstp3_clks.10                      2            2           0
>>        0 0
>>
>> Surprisingly, the system still works.
>>
>> Several clock drivers (e.g. fixed-factor-clock) use of_clk_get_parent_name()
>> to find the name of the parent clock.
>> In the absence of "clock-output-names", this returns the name of the device
>> node of the parent's clock. Which is always "cpg_clocks", and no longer the
>> name of the clock matching the index.
>>
>> I believe the same issue is present for MSTP clocks, but there we don't have
>> children clocks, so it doesn't manifest itself (yet).
>>
>> A quick workaround is to just re-add the clock-output-names to r8a7795.dtsi:
>>
>>                                 clock-output-names >>                                         "main", "pll0", "pll1","pll2",
>>                                         "pll3", "pll4";
>>
>> Hence it seems like dropping "clock-output-names" for clocks with multiple
>> outputs is not such a good idea?
>>
>> See also my question in "Re: [PATCH 3/4 v3][RFC] arm64: renesas: Add initial
>> r8a7795 SoC support" (http://www.spinics.net/lists/linux-sh/msg44609.html):
>>
>> | BTW, was "dropping clock-output-names" a general comment for all clock
>> | drivers, or specific to the SoC's Clock Pulse Generator?
>> |
>> | For e.g. "fixed-factor-clock", the driver falls back to using the node's
>> | name if  "clock-output-names" is not present.
>> |
>> | But e.g. for MSTP clocks, that can't be done, as the clocks wouldn't have
>> | names in that case (single node with multiple clocks). Unless we start
>> | fabricating them from the node name and the indices."
>>
>> For MSTP, we started fabricating them, but that doesn't solve the
>> of_clk_get_parent_name() issue.
>>
>> Thanks for your comments!

Thanks for making this very useful summary. It made it relatively easy
for me to understand what was going on.

From my side I've noticed exactly the same thing as you describe. So
in case we have more than one clock provided by a single node the
of_clk_get_parent_name() function will not work as expected unless
clock-output-names is provided. More or less all of the main clock
drivers for renesas hardware is built using a single node with
multiple indices, and today we use clock-output-names so we have no
issues for existing platforms.

For the upcoming R-Car Gen3 SoC we were asked to get rid of
clock-output-names if possible, but it seems that is difficult to do
without changing core CCF code. The patch below is my proporsal how to
fix the issue. It needs to be reworked to handle memory allocation
properly, but hopefully there are better ways to fix this.

The main portion of the patch below is based around a new function
called of_clk_get_name(). The idea is that it will check a certain
node if the clock-indices property is present together with
clock-output-names. In case clock-output-names is set it will make use
of that. If no clock-output-names is provided and no clock-indices
then the node name is used as-is, but if clock-indices is set then a
"%s.%u" name is generated based on node name and clock-index.

Included in the patch is also some debug code and minor changes to
make use of of_clk_get_name() from of_clk_get_parent_name() and a
couple of Renesas-specific drivers. With this patch the debugfs clock
frequency propagation is unbroken again, but unfortunately we now have
memory leaks instead. =)

The prototype is only written to highlight what that the problem is.
Not for upstream merge.

Not-yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/clk/clk-fixed-factor.c       |    3 ++
 drivers/clk/clk.c                    |   46 ++++++++++++++++++++++------------
 drivers/clk/shmobile/clk-mstp.c      |    3 --
 drivers/clk/shmobile/clk-rcar-gen3.c |   13 +--------
 include/linux/clk-provider.h         |    2 +
 5 files changed, 39 insertions(+), 28 deletions(-)

--- 0001/drivers/clk/clk-fixed-factor.c
+++ work/drivers/clk/clk-fixed-factor.c    2015-09-07 21:49:36.472366518 +0900
@@ -82,6 +82,9 @@ struct clk *clk_register_fixed_factor(st
     if (!fix)
         return ERR_PTR(-ENOMEM);

+    printk("xxxx name %s parent name %s %i %i\n", name, parent_name,
+           mult, div);
+
     /* struct clk_fixed_factor assignments */
     fix->mult = mult;
     fix->div = div;
--- 0001/drivers/clk/clk.c
+++ work/drivers/clk/clk.c    2015-09-07 22:08:32.472366518 +0900
@@ -3045,31 +3045,25 @@ int of_clk_get_parent_count(struct devic
 }
 EXPORT_SYMBOL_GPL(of_clk_get_parent_count);

-const char *of_clk_get_parent_name(struct device_node *np, int index)
+const char *of_clk_get_name(struct device_node *np, int index)
 {
-    struct of_phandle_args clkspec;
     struct property *prop;
     const char *clk_name;
     const __be32 *vp;
     u32 pv;
-    int rc;
     int count;
+    bool has_indices = false;

     if (index < 0)
         return NULL;

-    rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
-                    &clkspec);
-    if (rc)
-        return NULL;
-
-    index = clkspec.args_count ? clkspec.args[0] : 0;
     count = 0;

     /* if there is an indices property, use it to transfer the index
      * specified into an array offset for the clock-output-names property.
      */
-    of_property_for_each_u32(clkspec.np, "clock-indices", prop, vp, pv) {
+    of_property_for_each_u32(np, "clock-indices", prop, vp, pv) {
+        has_indices = true;
         if (index = pv) {
             index = count;
             break;
@@ -3077,12 +3071,34 @@ const char *of_clk_get_parent_name(struc
         count++;
     }

-    if (of_property_read_string_index(clkspec.np, "clock-output-names",
-                      index,
-                      &clk_name) < 0)
-        clk_name = clkspec.np->name;
+    if (of_property_read_string_index(np, "clock-output-names", index,
+                      &clk_name) < 0) {
+        if (has_indices)
+            return kasprintf(GFP_KERNEL, "%s.%u", np->name, index);
+        else
+            return kstrdup_const(np->name, GFP_KERNEL);
+    }
+
+    return kstrdup_const(clk_name, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(of_clk_get_name);
+
+const char *of_clk_get_parent_name(struct device_node *np, int index)
+{
+    struct of_phandle_args clkspec;
+    const char *clk_name = NULL;
+    int rc;
+
+    if (index < 0)
+        return NULL;

-    of_node_put(clkspec.np);
+    rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells", index,
+                    &clkspec);
+    if (!rc) {
+        clk_name = of_clk_get_name(clkspec.np, clkspec.args_count ?
+                       clkspec.args[0] : 0);
+        of_node_put(clkspec.np);
+    }
     return clk_name;
 }
 EXPORT_SYMBOL_GPL(of_clk_get_parent_name);
--- 0017/drivers/clk/shmobile/clk-mstp.c
+++ work/drivers/clk/shmobile/clk-mstp.c    2015-09-07 22:04:50.942366518 +0900
@@ -216,8 +216,7 @@ static void __init cpg_mstp_clocks_init(

         if (of_property_read_string_index(np, "clock-output-names",
                           i, &name) < 0)
-            allocated_name = name = kasprintf(GFP_KERNEL, "%s.%u",
-                               np->name, clkidx);
+            allocated_name = name = of_clk_get_name(np, clkidx);

         clks[clkidx] = cpg_mstp_clock_register(name, parent_name,
                                clkidx, group);
--- 0020/drivers/clk/shmobile/clk-rcar-gen3.c
+++ work/drivers/clk/shmobile/clk-rcar-gen3.c    2015-09-07
21:41:38.502366518 +0900
@@ -26,15 +26,6 @@
 #define RCAR_GEN3_CLK_PLL4    5
 #define RCAR_GEN3_CLK_NR    6

-static const char * const rcar_gen3_clk_names[RCAR_GEN3_CLK_NR] = {
-    [RCAR_GEN3_CLK_MAIN] = "main",
-    [RCAR_GEN3_CLK_PLL0] = "pll0",
-    [RCAR_GEN3_CLK_PLL1] = "pll1",
-    [RCAR_GEN3_CLK_PLL2] = "pll2",
-    [RCAR_GEN3_CLK_PLL3] = "pll3",
-    [RCAR_GEN3_CLK_PLL4] = "pll4",
-};
-
 struct rcar_gen3_cpg {
     struct clk_onecell_data data;
     void __iomem *reg;
@@ -136,7 +127,7 @@ rcar_gen3_cpg_register_clk(struct device
                const struct cpg_pll_config *config,
                unsigned int gen3_clk)
 {
-    const char *parent_name = rcar_gen3_clk_names[RCAR_GEN3_CLK_MAIN];
+    const char *parent_name = of_clk_get_name(np, RCAR_GEN3_CLK_MAIN);
     unsigned int mult = 1;
     unsigned int div = 1;
     u32 value;
@@ -177,7 +168,7 @@ rcar_gen3_cpg_register_clk(struct device
         return ERR_PTR(-EINVAL);
     }

-    return clk_register_fixed_factor(NULL, rcar_gen3_clk_names[gen3_clk],
+    return clk_register_fixed_factor(NULL, of_clk_get_name(np, gen3_clk),
                      parent_name, 0, mult, div);
 }

--- 0001/include/linux/clk-provider.h
+++ work/include/linux/clk-provider.h    2015-09-07 21:35:54.332366518 +0900
@@ -665,6 +665,8 @@ struct clk *of_clk_src_onecell_get(struc
 int of_clk_get_parent_count(struct device_node *np);
 int of_clk_parent_fill(struct device_node *np, const char **parents,
                unsigned int size);
+
+const char *of_clk_get_name(struct device_node *np, int index);
 const char *of_clk_get_parent_name(struct device_node *np, int index);

 void of_clk_init(const struct of_device_id *matches);
