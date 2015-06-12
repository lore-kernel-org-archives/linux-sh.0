From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 12 Jun 2015 19:07:19 +0000
Subject: Re: [PATCH v2 3/6] pinctrl: sh-pfc: r8a7790: Add separate functions for SDHI 1.8V operation
Message-Id: <34148355.aYdSK9R7Ck@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1433892104.12074.49.camel@codethink.co.uk> <2554026.6LTcTIWBdF@avalon> <1434115435.25446.1.camel@codethink.co.uk>
In-Reply-To: <1434115435.25446.1.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Ben,

On Friday 12 June 2015 14:23:55 Ben Hutchings wrote:
> On Fri, 2015-06-12 at 10:18 +0300, Laurent Pinchart wrote:
> > Hi Ben,
> > 
> > (CC'ing Linus Walleij)
> > 
> > Thank you for the patch.
> > 
> > On Wednesday 10 June 2015 00:23:31 Ben Hutchings wrote:
> > > All the SHDIs can operate with either 3.3V or 1.8V signals, depending
> > > on negotiation with the card.
> > > 
> > > Add separate functions for the 1.8V mode, and implement the set_mux
> > > operation on all SDHI functions to configure the voltage for each
> > > group of pins.
> > 
> > I don't think duplicating all functions for 1.8V and 3.3V is the right way
> > to go. Can't we use the pinconf API instead, and in particular the
> > PIN_CONFIG_POWER_SOURCE configuration ?
> 
> [...]
> 
> So far as I could see, you can't use the pinconf API with pinmux groups.

Can't you ? Both Documentation/devicetree/bindings/pinctrl/pinctrl-
bindings.txt and Documentation/devicetree/bindings/pinctrl/renesas,pfc-
pinctrl.txt document the usage of pinconf with groups (see for instance 
example 3 in the latter).

-- 
Regards,

Laurent Pinchart

