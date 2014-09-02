From: Mike Turquette <mturquette@linaro.org>
Date: Tue, 02 Sep 2014 00:44:53 +0000
Subject: Re: [PATCH 1/3 v2] clk: shmobile: add missing 0x0100 for SDCKCR
Message-Id: <20140902004453.5251.30288@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <871tsul8b3.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <871tsul8b3.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Quoting Simon Horman (2014-08-05 18:40:57)
> On Wed, Aug 06, 2014 at 10:24:00AM +0900, Kuninori Morimoto wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > 10cdfe9f327ab8d120cf6957e58c6203e3a53847
> > (clk: shmobile: Add R-Car Gen2 clocks support)
> > added R-Car Gen2 clock support via DT for v3.14.
> > 
> > But, cpg_sd01_div_table is missing
> > "0x0100: x 1/8" division ratio.
> > This patch fixes hidden bug.
> > It is based on R-Car H2 v0.7, R-Car M2 v0.9.
> > 
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Thanks Morimoto-san.
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Mike, could you consider picking up this patch.
> It is a bug fix but it doesn't manifest as no boards use the clock in
> question.

Applied to clk-next.

Regards,
Mike

> 
> I believe the remaining two patches in this series should go though my
> renesas tree.
> 
> > ---
> >  drivers/clk/shmobile/clk-rcar-gen2.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
> > index dff7f79..e996425 100644
> > --- a/drivers/clk/shmobile/clk-rcar-gen2.c
> > +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
> > @@ -202,6 +202,7 @@ static const struct clk_div_table cpg_sdh_div_table[] = {
> >  };
> >  
> >  static const struct clk_div_table cpg_sd01_div_table[] = {
> > +     {  4,  8 },
> >       {  5, 12 }, {  6, 16 }, {  7, 18 }, {  8, 24 },
> >       { 10, 36 }, { 11, 48 }, { 12, 10 }, {  0,  0 },
> >  };
> > -- 
> > 1.7.9.5
> > 
