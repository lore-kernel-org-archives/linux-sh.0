From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 31 Aug 2015 04:50:38 +0000
Subject: Re: [PATCH 0/2][RFC] pinctrl: sh-pfc: r8a7795 support
Message-Id: <CANqRtoS9wrU4u=HL4j=u0aqU=Uwraa0+PFuTFJLVUNNjc6nMAQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1y7daou.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1y7daou.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon <horms@verge.net.au>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Morimoto-san,

On Fri, Aug 28, 2015 at 6:31 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi LinusW, Laurent
>
> These are remake of r8a7795 PFC support
> Previous version included many PFC settings, and it was over 5000 line !
> but some of them are not used. So it was super difficult for reviewing.
>
> This time, 1) patch is very basic PFC frame only.
> 2) adds SCIF support
> I can post HSCIF support next week if these are accepted.
>
> I know this is not good things, but these patches are based on
> below patch which I posted. The code will be more readable
> if we can use it. Thus these patches are also [RFC]
>
>         Subject: [PATCH][RFC] sh-pfc: add new PINMUX_IPSR_MODS() macro
>         Date: Fri, 28 Aug 2015 14:20:41 +0900
>
> Kuninori Morimoto (2):
>       1) pinctrl: sh-pfc: Initial R8A7795 PFC support
>       2) pinctrl: sh-pfc: r8a7795: add SCIFx support
>
>  drivers/pinctrl/sh-pfc/Kconfig       |    5 +
>  drivers/pinctrl/sh-pfc/Makefile      |    1 +
>  drivers/pinctrl/sh-pfc/core.c        |    6 +
>  drivers/pinctrl/sh-pfc/core.h        |    1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 1863 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 1876 insertions(+)

Thanks a lot for your efforts. Breaking out the code like this should
make it much easier to review.

One thing - above in the diffstat I cannot seem to find
"Documentation/devicetree/bindings/"... When I try to use the PFC I
also get complaints from checkpatch about missing compatible strings.

In the next version of this PFC series can you please add a patch that
extends "renesas,pfc-pinctrl.txt" with r8a7795 information?

Thanks,

/ magnus
