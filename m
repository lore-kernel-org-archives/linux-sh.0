From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 09 Sep 2015 05:42:55 +0000
Subject: Re: [PATCH][RFC] clk: Use node name and index for clock name
Message-Id: <1981230.p8F5aT0ffl@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150909050554.27129.68718.sendpatchset@little-apple> <13888179.tcIA8DJW1S@avalon> <CANqRtoTE+jdavqQ0i5jHu=5REtPhf1xDVfREKC0XD2Bz=rf4kQ@mail.gmail.com>
In-Reply-To: <CANqRtoTE+jdavqQ0i5jHu=5REtPhf1xDVfREKC0XD2Bz=rf4kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, SH-Linux <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Magnus,

On Wednesday 09 September 2015 14:27:58 Magnus Damm wrote:
> On Wed, Sep 9, 2015 at 2:14 PM, Laurent Pinchart wrote:
> > On Wednesday 09 September 2015 14:05:54 Magnus Damm wrote:
> >> From: Magnus Damm <damm+renesas@opensource.se>
> >> 
> >> This patch hacks the CCF core to take clock-indices into
> >> consideration when making a default clock name in case
> >> clock-output-names is not provided.
> >> 
> >> Without this patch of_clk_get_parent_name() does not work
> >> for clocks with multiple indices associated with one node.
> >> 
> >> Proof of concept only. Leaks memory. Not for upstream merge.
> >> 
> >> Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >> ---
> >> 
> >>  Written on top of "renesas-drivers-2015-09-08-v4.2"
> >>  Needed to propagate clock frequencies from CPG to MSTP.
> >>  
> >>  drivers/clk/clk.c                    |   46 +++++++++++++++++-----------
> >>  drivers/clk/shmobile/clk-mstp.c      |    3 --
> >>  drivers/clk/shmobile/clk-rcar-gen3.c |   13 +--------
> >>  include/linux/clk-provider.h         |    1
> >>  4 files changed, 35 insertions(+), 28 deletions(-)
> >> 
> >> --- 0001/drivers/clk/clk.c
> >> +++ work/drivers/clk/clk.c    2015-09-09 13:48:21.992366518 +0900
> >> @@ -3045,31 +3045,25 @@ int of_clk_get_parent_count(struct devic
> >>  }
> >>  EXPORT_SYMBOL_GPL(of_clk_get_parent_count);
> >> 
> >> -const char *of_clk_get_parent_name(struct device_node *np, int index)
> >> +const char *of_clk_get_name(struct device_node *np, int index)
> >>  {
> >> -     struct of_phandle_args clkspec;
> >>       struct property *prop;
> >>       const char *clk_name;
> >>       const __be32 *vp;
> >>       u32 pv;
> >> -     int rc;
> >>       int count;
> >> +     bool has_indices = false;
> >> 
> >>       if (index < 0)
> >>               return NULL;
> >> 
> >> -     rc = of_parse_phandle_with_args(np, "clocks", "#clock-cells",
> >> index,
> >> -                                     &clkspec);
> >> -     if (rc)
> >> -             return NULL;
> >> -
> >> -     index = clkspec.args_count ? clkspec.args[0] : 0;
> >>       count = 0;
> >>       
> >>       /* if there is an indices property, use it to transfer the index
> >>        * specified into an array offset for the clock-output-names
> >>        property.
> >>        */
> >> -     of_property_for_each_u32(clkspec.np, "clock-indices", prop, vp, pv)
> >> {
> >> +     of_property_for_each_u32(np, "clock-indices", prop, vp, pv) {
> >> +             has_indices = true;
> >>               if (index = pv) {
> >>                       index = count;
> >>                       break;
> >> @@ -3077,12 +3071,34 @@ const char *of_clk_get_parent_name(struc
> >>               count++;
> >>       }
> >> 
> >> -     if (of_property_read_string_index(clkspec.np, "clock-output-names",
> >> -                                       index,
> >> -                                       &clk_name) < 0)
> >> -             clk_name = clkspec.np->name;
> >> +     if (of_property_read_string_index(np, "clock-output-names", index,
> >> +                                       &clk_name) < 0) {
> >> +             if (has_indices)
> >> +                     return kasprintf(GFP_KERNEL, "%s.%u", np->name,
> >> index);
> >
> > What if the clock provider has a #clock-cells larger than one ?
> 
> Right that is of course one issue. But according to the DT
> documentation file clock-bindings.txt #clock-cells is typically set to
> 0 or 1.

"Typically" :-)

We've discussed recently the possibility of using two cells for MSTP clocks.

> > Another issue is that this won't guarantee that the names are unique as
> > multiple DT nodes can have the same name. Instead of trying to generate
> > unique names, would it be possible to handle clock registration and
> > lookup without relying on names for DT-based platforms ?
> 
> It would of course make sense to do that for the long run, but at the
> same time that sounds like major internal API rework since most
> functions operate on string clock names today. So for short term is
> the correct approach to use clock-output-names?

I think Stephen and Mike should comment on that.

-- 
Regards,

Laurent Pinchart

