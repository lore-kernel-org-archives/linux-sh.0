From: Simon Horman <horms@verge.net.au>
Date: Fri, 25 Jan 2013 02:32:16 +0000
Subject: Re: [PATCH v2 1/8] sh-pfc: Add OF support
Message-Id: <20130125023216.GB620@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357693395-1653-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130115011019.GA13304@verge.net.au>
 <20130121003828.GD19062@verge.net.au>
 <1361419.Aenl5VCGHZ@avalon>
In-Reply-To: <1361419.Aenl5VCGHZ@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Phil Edworthy <phil.edworthy@renesas.com>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, devicetree-discuss@lists.ozlabs.org

On Thu, Jan 24, 2013 at 12:17:32PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 21 January 2013 09:38:28 Simon Horman wrote:
> > On Tue, Jan 15, 2013 at 10:10:19AM +0900, Simon Horman wrote:
> > > On Sat, Jan 12, 2013 at 06:18:54PM +0100, Guennadi Liakhovetski wrote:
> > > > On Wed, 9 Jan 2013, Laurent Pinchart wrote:
> > > > > Support device instantiation through the device tree. The compatible
> > > > > property is used to select the SoC pinmux information.
> > > > > 
> > > > > Set the gpio_chip device field to the PFC device to enable automatic
> > > > > GPIO OF support.
> > > > > 
> > > > > Signed-off-by: Laurent Pinchart
> > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > > Cc: devicetree-discuss@lists.ozlabs.org
> > > > 
> > > > This whole pinctrl mega-series is a very welcome improvement to the
> > > > sh-/r-mobile GPIO framework, and is very well done IMHO! But,
> > > > unfortunately, as discussed with you privately yesterday, there is still
> > > > a problem with pinctrl DT support on sh73a0, which will, probably,
> > > > enforce an update to one or several of patches from this lot. To explain
> > > > to other readers, on sh73a0 pin numbers are not contiguous, they are
> > > > sparse. When pins are referred to from C code, macro names are used,
> > > > which are then correctly decoded to respective positions in pin
> > > > descriptor tables. Whereas with DT, pins are referred to from .dts files
> > > > using their physical numbers, which then refer to either wrong or
> > > > missing entries in those tables.
> > > > 
> > > > I do not know where this problem should be solved best - either in
> > > > descriptor tables, or in DT handling code, so, I don't know which
> > > > patches would be affected. Don't think you'll want to keep the one-to-
> > > > one index-to-pin mapping by also making pin-descriptor arrays sparse,
> > > > so, so far I only see one possibility to fix this - by using the
> > > > .enum_id field from struct sh_pfc_pin instead of just the index - both
> > > > in  C and in DT case, and those .enum_id values will have to provide
> > > > physical pin numbers instead of plane indices. That way you'd have to
> > > > update at least drivers/pinctrl/sh-pfc/pfc-sh73a0.c and the
> > > > sh_pfc_map_gpios() function in drivers/pinctrl/sh-pfc/pinctrl.c.
> > > > 
> > > > Anyway, I'm sure you'll find a suitable solution of this problem and for
> > > > now I'll let Simon decide which patches he wants to apply and which ones
> > > > he'd prefer to hold back;-)
> > > 
> > > Actually, I'd appreciate some guidance from Laurent on this.
> > > It seems that the problems you raise go quite far back into the
> > > mega-series.
> > > 
> > > I was intending to send pull requests for the following branches soon.
> > > But I am now concerned that at least the sh73a0 patches may need
> > > reworking.
> > 
> > I have concluded that the changes below are safe and have
> > proceeded with sending them to arm-soc. However, I am still awaiting
> > a response from arm-soc.
> 
> Sorry for the late reply. The below changes are indeed safe, what I need to 
> rework are the pinctrl API and DT series.

Thanks. After some discussions with arm-soc I have finally sent a
pull-request for these changes which now live in the pfc branch of
my renesas tree.
