From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 20 Nov 2015 14:53:10 +0000
Subject: Re: [PATCH 00/04] pinctrl: sh-pfc: r8a7794: DU support
Message-Id: <7175557.3oSik5Zhyq@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20151117031832.24924.60685.sendpatchset@little-apple> <2997631.z1xUhmAZzM@avalon> <CANqRtoTMf4TP2gcEuF4y5qdRz0fdf9-sebS=ymg+4zAGMj8dSA@mail.gmail.com>
In-Reply-To: <CANqRtoTMf4TP2gcEuF4y5qdRz0fdf9-sebS=ymg+4zAGMj8dSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, linux-gpio <linux-gpio@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>, geert@glider.be

Hi Magnus,

On Friday 20 November 2015 16:16:15 Magnus Damm wrote:
> On Fri, Nov 20, 2015 at 11:46 AM, Laurent Pinchart wrote:
> > On Tuesday 17 November 2015 12:18:32 Magnus Damm wrote:
> >> pinctrl: sh-pfc: r8a7794: DU support
> >> 
> >> [PATCH 01/04] pinctrl: sh-pfc: r8a7794: Add DU pin groups
> >> [PATCH 02/04] pinctrl: sh-pfc: r8a7794: Separate DU CDE and DISP
> >> [PATCH 03/04] pinctrl: sh-pfc: r8a7794: Add missing dot clock signals
> >> [PATCH 04/04] pinctrl: sh-pfc: r8a7794: Break out ODDF from sync
> >> 
> >> These patches take the r8a7794 PFC DU support code from the BSP
> >> and reworks it to fit the r8a7794 ALT board. Tested with the ALT
> >> VGA port - by default PFC is not used however enabling PFC using
> >> an incremental (yet to be posted) patch works well.
> >> 
> >> It is worth noting that patch 2-4 modifies the pin groups. This
> >> means that the upstream DT ABI for PFC DU will differ compared
> >> to the unreviewed BSP code.
> >> 
> >> In general it is not considered good practice to change the pin
> >> groups and break compatibility since they are part of the DT ABI.
> >> 
> >> For this particular case upstream never have had PFC DU support
> >> for r8a7794, so treating the BSP bindings as experimental and
> >> migrate away seems reasonable.
> > 
> > If we start considering DT bindings that never went upstream as stable
> > we'll have a big problem. I mean even bigger than the upstream DT
> > bindings stability problem :-)
> 
> I'm not saying that local DT hacks should be considered stable, more
> that it as usual makes sense to follow upstream first with proper DT
> review process early on.
> 
> >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > 
> > Wouldn't it make sense to merge the 4 patches together ?
> 
> Yeah, I guess so. My feeling is also that it would be good to verify
> HDMI on ALT before commiting to DT bindings. Right now only one DU
> channel is tested.

I agree with that.

-- 
Regards,

Laurent Pinchart

