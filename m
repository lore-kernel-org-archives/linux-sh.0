From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 15 May 2013 12:38:35 +0000
Subject: Re: marzen pinctl conflict for renesas-next-20130515v2 + v3.10-rc1
Message-Id: <5635579.B5DNDee33A@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130515084658.GA19115@verge.net.au>
In-Reply-To: <20130515084658.GA19115@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Wednesday 15 May 2013 16:36:58 Sergei Shtylyov wrote:
> On 15-05-2013 12:46, Simon Horman wrote:
> > Hi Laurent,
> > 
> > I am preparing to rebase the branches of the renesas tree which
> > are targeted for v3.11 on top of v3.10-rc1. In the course of
> > doing so I have noticed a problem on the marzen board which appears
> > to be related to pinmux.
> > 
> > On boot, using the default config I see the following:
> > 
> > sh-pfc pfc-r8a7779: pin GP_4_22 already requested by sh-hspi.0; cannot
> > claim for ehci-platform.0 sh-pfc pfc-r8a7779: pin-150 (ehci-platform.0)
> > status -22
> > sh-pfc pfc-r8a7779: could not request pin 150 on device sh-pfc
> 
> I have already reported this. Laurent prepared a fix, which I somewhat
> criticized, but he never published a second version.

I've posted v2 earlier today.

> > ehci-platform ehci-platform.0: Error applying setting, reverse things back
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000036
>
> These are new to me.
> 
> > Looking at pfc-r8a7779 and the SoC documentation it seems
> > that HSPI0 and USB0 do indeed use different functions of
> > GPIO pin 4 22 (and other pins too).
> 
> No, only this pin.
> 
> > I am unsure how this should be managed by either the pinmux driver
> > or the board code.
> 
> PENC0 and USB_OVC0 were incorrectly grouped together, the fix is to ungroup
> them. USB_OVC0 which causes the conflict is not actually used.

-- 
Regards,

Laurent Pinchart

