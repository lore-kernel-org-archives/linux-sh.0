From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Jul 2013 01:22:50 +0000
Subject: Re: [PATCH v4 5/7] mmc: SDHI: add DT compatibility strings for further SoCs
Message-Id: <20130717012247.GA2797@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307090940310.28812@axis700.grange>
 <CANqRtoQY7hwEhN5XMXG5V234aXDFZ_kfei8ZQL+VMKaaxW=0DQ@mail.gmail.com>
 <20130710011834.GA27240@verge.net.au>
In-Reply-To: <20130710011834.GA27240@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, SH-Linux <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Wed, Jul 10, 2013 at 10:18:35AM +0900, Simon Horman wrote:
> On Tue, Jul 09, 2013 at 06:06:00PM +0900, Magnus Damm wrote:
> > On Tue, Jul 9, 2013 at 4:43 PM, Guennadi Liakhovetski
> > <g.liakhovetski@gmx.de> wrote:
> > > Add further OF compatibility strings to the SDHI driver to be able to
> > > precisely control driver's behaviour on each of them.
> > >
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > ---
> > >
> > > v4:
> > > 1. added r8a7778 and r8a7779 per Morimoto-san's request
> > > 2. sh* and r8a* entries now sorted alphabetically
> > 
> > This looks good to me, thanks.
> > 
> > Acked-by: Magnus Damm <damm@opensource.se>
> 
> Thanks, I have queued this up for v3.12 in the dt branch.
> It should appear in renesas-next-20130710

Reviewing this, I now think that it should got through the MMC tree.
Chris, could you consider the patch below?

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

mmc: SDHI: add DT compatibility strings for further SoCs

Add further OF compatibility strings to the SDHI driver to be able to
precisely control driver's behaviour on each of them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Magnus Damm <damm@opensource.se>
Acked-by: Simon Horman <horms@verge.net.au>

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index ebea749..afa1bba 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -129,7 +129,12 @@ static const struct sh_mobile_sdhi_ops sdhi_ops = {
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,shmobile-sdhi" },
 	{ .compatible = "renesas,sh7372-sdhi" },
+	{ .compatible = "renesas,sh73a0-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,r8a73a4-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{ .compatible = "renesas,r8a7740-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,r8a7778-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,r8a7779-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,r8a7790-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
