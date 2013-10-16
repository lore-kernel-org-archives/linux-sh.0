From: Simon Horman <horms@verge.net.au>
Date: Wed, 16 Oct 2013 06:16:27 +0000
Subject: Re: [PATCH] sh-pfc: r8a7791 PFC support
Message-Id: <20131016061626.GG15425@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131008040824.3480.69707.sendpatchset@w520>
 <17712286.HDNRip2xPu@avalon>
In-Reply-To: <17712286.HDNRip2xPu@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 10, 2013 at 12:43:17AM +0200, Laurent Pinchart wrote:
> Hi Magnus,
> 
> On Tuesday 08 October 2013 13:08:24 Magnus Damm wrote:
> > From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> > 
> > Add PFC support for the r8a7791 SoC including pin groups for
> > on-chip devices such as MSIOF, SCIF, USB, MMC, VIN, SDHI, DU.
> > 
> > Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> > Signed-off-by: Kunihito Higashiyama <kunihito.higashiyama.ur@renesas.com>
> > Signed-off-by: Yoshikazu Fujikawa <yoshikazu.fujikawa.ue@renesas.com>
> > Signed-off-by: Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>
> > Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> > Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > [damm@opensource.se: Forward ported to upstream, reused existing sh-pfc
> > macros] Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> BTW, the patch was too big and didn't make it to the list :-/

I got it it anyway but if it doesn't hit the list it won't show
up in patchwork. And that is a minor problem for my work-flow

Magnus, when you repost this please ping me about it to
make sure it is on my radar.
