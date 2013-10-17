From: Simon Horman <horms@verge.net.au>
Date: Thu, 17 Oct 2013 00:52:13 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7790: add QSPI support
Message-Id: <20131017005211.GC21728@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 16, 2013 at 05:13:51PM -0700, Kuninori Morimoto wrote:
> 
> Hi Hiep
> 
> I have one comment
> 
> > From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> > 
> > Add platform device and clock for the r8a7790 QSPI.
> > 
> > Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> > ---
> (snip)
> > @@ -276,6 +279,7 @@ static struct clk_lookup lookups[] = {
> >  	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
> >  	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
> >  	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
> > +	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
> >  };
> (snip)
> > +void __init r8a7790_add_qspi_device(struct rspi_plat_data *pdata)
> > +{
> > +	platform_device_register_resndata(
> > +		&platform_bus, "qspi", 0,
> > +		qspi_resources, ARRAY_SIZE(qspi_resources),
> > +		pdata, sizeof(*pdata));
> > +}
> 
> Please use -1 ID, and use just "qspi", instead of "qspi.0"

Thanks Morimoto-san.

Hiep-san, could you please update your patches according to
the feedback from Morimoto-san, Magnus and myself. Please also
rebase them on the latest devel tag of the renesas tree.
Then please re-post your patches as v2, noting changes in
the change log and including v2 after PATCH in each subject line.

Thanks
