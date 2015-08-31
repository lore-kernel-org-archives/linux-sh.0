From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 31 Aug 2015 05:58:16 +0000
Subject: Re: [PATCH 0/2][RFC] pinctrl: sh-pfc: r8a7795 support
Message-Id: <87613w3sp3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1y7daou.wl%kuninori.morimoto.gx@renesas.com>
	<CANqRtoS9wrU4u=HL4j=u0aqU=Uwraa0+PFuTFJLVUNNjc6nMAQ@mail.gmail.com>
In-Reply-To: <CANqRtoS9wrU4u=HL4j=u0aqU=Uwraa0+PFuTFJLVUNNjc6nMAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon <horms@verge.net.au>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


Hi Magnus

> >  drivers/pinctrl/sh-pfc/Kconfig       |    5 +
> >  drivers/pinctrl/sh-pfc/Makefile      |    1 +
> >  drivers/pinctrl/sh-pfc/core.c        |    6 +
> >  drivers/pinctrl/sh-pfc/core.h        |    1 +
> >  drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 1863 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 1876 insertions(+)
> 
> Thanks a lot for your efforts. Breaking out the code like this should
> make it much easier to review.
> 
> One thing - above in the diffstat I cannot seem to find
> "Documentation/devicetree/bindings/"... When I try to use the PFC I
> also get complaints from checkpatch about missing compatible strings.
> 
> In the next version of this PFC series can you please add a patch that
> extends "renesas,pfc-pinctrl.txt" with r8a7795 information?

Ahh, good catch.
will do in next version

Best regards
---
Kuninori Morimoto
