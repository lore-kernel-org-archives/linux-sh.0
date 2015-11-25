From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Nov 2015 00:16:12 +0000
Subject: Re: [PATCH 00/04] pinctrl: sh-pfc: r8a7794: DU support
Message-Id: <20151125001611.GE20596@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20151117031832.24924.60685.sendpatchset@little-apple>
 <2997631.z1xUhmAZzM@avalon>
In-Reply-To: <2997631.z1xUhmAZzM@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, koji.matsuoka.xm@renesas.com, linux-gpio@vger.kernel.org, geert@glider.be

On Fri, Nov 20, 2015 at 04:46:50AM +0200, Laurent Pinchart wrote:
> Hi Magnus,
> 
> Thank you for the patch.
> 
> On Tuesday 17 November 2015 12:18:32 Magnus Damm wrote:
> > pinctrl: sh-pfc: r8a7794: DU support
> > 
> > [PATCH 01/04] pinctrl: sh-pfc: r8a7794: Add DU pin groups
> > [PATCH 02/04] pinctrl: sh-pfc: r8a7794: Separate DU CDE and DISP
> > [PATCH 03/04] pinctrl: sh-pfc: r8a7794: Add missing dot clock signals
> > [PATCH 04/04] pinctrl: sh-pfc: r8a7794: Break out ODDF from sync
> > 
> > These patches take the r8a7794 PFC DU support code from the BSP
> > and reworks it to fit the r8a7794 ALT board. Tested with the ALT
> > VGA port - by default PFC is not used however enabling PFC using
> > an incremental (yet to be posted) patch works well.
> > 
> > It is worth noting that patch 2-4 modifies the pin groups. This
> > means that the upstream DT ABI for PFC DU will differ compared
> > to the unreviewed BSP code.
> > 
> > In general it is not considered good practice to change the pin
> > groups and break compatibility since they are part of the DT ABI.
> > 
> > For this particular case upstream never have had PFC DU support
> > for r8a7794, so treating the BSP bindings as experimental and
> > migrate away seems reasonable.
> 
> If we start considering DT bindings that never went upstream as stable
> we'll have a big problem. I mean even bigger than the upstream DT
> bindings stability problem :-)

FWIW, I agree.

> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Wouldn't it make sense to merge the 4 patches together ?
> 
> > ---
> > 
> >  Written against v4.4-rc1
> > 
> >  drivers/pinctrl/sh-pfc/pfc-r8a7794.c |  282 +++++++++++++++++++++++++++----
> >  1 file changed, 252 insertions(+), 30 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
