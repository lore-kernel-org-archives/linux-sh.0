From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Aug 2013 00:13:51 +0000
Subject: Re: [PATCH 3/3 v4] ARM: shmobile: bockw: add USB Function support
Message-Id: <87zjs0qbly.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878v2g6psd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878v2g6psd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

> > Magnus, could you review this?
> 
> Sure, I can try. Just to be clear though - I think I know this board
> and SoC as little as you do. =)

Thank you

> Thanks for your work on this. In this patch I understand that you
> based on Kconfig select if ehci-platform or renesas-usbhs should be
> used. I wonder how well that will work together with multiplatform
> kernels in the future. Probably not so well. So we need to figure out
> how to handle this in the future.
> 
> I propose that we accept this patch as-is today to enable the
> hardware, but we should also investigate if we for instance could let
> the PFC handle mutual exclusion of the hardware and use bind/unbind to
> start/stop devices during run time. Paul Mundt and I talked about this
> ages ago but I'm not sure if it is actually possible with pinctrl or
> not. If possible would install both ehci-platform and renesas-usbhs
> devices in parallel and instead dynamically select one of them through
> sysfs.
> 
> Laurent, do you think it is possible to use pinctrl for mutual
> exclusion control in the drivers somehow? Basically, if the requested
> pins are already in use then the conflicting driver instance should
> error out.

Thank you for your help, and I think it is good point.

bind/unbind control USB seems nice idea if pinctrl works well.
But, It has 2 issues on this run time exchange.
 1) USB switching Host/Func needs dip-switch settings.
 2) USB Host/Func switching needs USB-PHY re-settings

I guess it is a little bit difficult 2) case in bind/unbind control

Some boards are difficult to full-support on multiplatform ?

> We also want to have DT bindings for USB drivers. Morimoto-san, can
> you please work on adding USB support to Bock-W DT reference?

OK, I will try it

Best regards
---
Kuninori Morimoto
