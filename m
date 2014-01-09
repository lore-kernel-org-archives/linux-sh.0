From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 09 Jan 2014 17:53:43 +0000
Subject: Re: [PATCH 2/2] clk: shmobile: Fix MSTP clock array initialization
Message-Id: <3278719.rAcIQXV7lu@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1388167599-23525-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388167599-23525-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

On Thursday 09 January 2014 21:51:05 Valentine wrote:
> On 01/09/2014 09:46 PM, Laurent Pinchart wrote:
> > On Saturday 28 December 2013 12:35:31 Laurent Pinchart wrote:
> >> On Friday 27 December 2013 22:06:39 Valentine Barshak wrote:
> >>> The clks member of the clk_onecell_data structure should
> >>> point to a valid clk array (no NULL entries allowed),
> >>> and the clk_num should be equal to the number
> >>> of elements in the clks array.
> >>> 
> >>> The MSTP driver fails to satisfy the above conditions.
> >>> The clks array may contain NULL entries if not all
> >>> clock-indices are initialized in the device tree.
> >>> Thus, if the clock indices are interleaved we end up
> >>> with NULL pointers in-between.
> >> 
> >> I don't think that's an issue in practice as long as no reference to a
> >> NULL clock exists in the device tree, but it should of course be fixed.
> >> 
> >>> The other problem is the driver uses maximum clock index
> >>> as the number of clocks, which is incorrect (less than
> >>> the actual number of clocks by 1).
> >> 
> >> Good catch.
> >> 
> >>> Fix the first issue by pre-setting the whole clks array
> >>> with ERR_PTR(-ENOENT) pointers instead of zeros; and
> >>> use maximum clkidx + 1 as the number of clocks to fix
> >>> the other one.
> >>> 
> >>> This should make of_clk_src_onecell_get() return the following:
> >>> * valid clk pointers for all clocks registered;
> >>> * ERR_PTR(-EINVAL) if (idx >= clk_data->clk_num);
> >>> * ERR_PTR(-ENOENT) if the clock at the selected index was not
> >>> 
> >>>    initialized in the device tree (and was not registered).
> >>> 
> >>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >>> ---
> >>> 
> >>>   drivers/clk/shmobile/clk-mstp.c | 9 +++++++--
> >>>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>> 
> >>> diff --git a/drivers/clk/shmobile/clk-mstp.c
> >>> b/drivers/clk/shmobile/clk-mstp.c index be7d017..14b91ad 100644
> >>> --- a/drivers/clk/shmobile/clk-mstp.c
> >>> +++ b/drivers/clk/shmobile/clk-mstp.c
> >>> @@ -160,7 +160,7 @@ static void __init cpg_mstp_clocks_init(struct
> >>> device_node *np)
> >>> 
> >>>   	unsigned int i;
> >>>   	
> >>>   	group = kzalloc(sizeof(*group), GFP_KERNEL);
> >>> 
> >>> -	clks = kzalloc(MSTP_MAX_CLOCKS * sizeof(*clks), GFP_KERNEL);
> >>> +	clks = kmalloc(MSTP_MAX_CLOCKS * sizeof(*clks), GFP_KERNEL);
> >>> 
> >>>   	if (group = NULL || clks = NULL) {
> >>>   	
> >>>   		kfree(group);
> >>>   		kfree(clks);
> >>> 
> >>> @@ -182,6 +182,10 @@ static void __init cpg_mstp_clocks_init(struct
> >>> device_node *np) }
> >>> 
> >>>   	for (i = 0; i < MSTP_MAX_CLOCKS; ++i) {
> >>> 
> >>> +		clks[i] = ERR_PTR(-ENOENT);
> >>> +	}
> >> 
> >> No need for brackets here.
> >> 
> >> With this fixed,
> >> 
> >> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Could you please resubmit the series with this fixed and the Reviewed-by
> > line from Ben picked for patch 1/2, and ask Mike to apply it for v3.14 in
> > the cover letter ?
> 
> I did respin these here:
> http://marc.info/?l=linux-sh&m8823255807611&w=2

Oops, my bad, I've missed that.

> Mike said he had taken them in clk-next,

Great, thank you.

-- 
Regards,

Laurent Pinchart

