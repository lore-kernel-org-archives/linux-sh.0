From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 Nov 2013 11:14:35 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: Initial r7s72100 support
Message-Id: <1976247.WEVz5t99cX@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20131127074122.18314.48522.sendpatchset@w520>
In-Reply-To: <20131127074122.18314.48522.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, wsa@the-dreams.de, linus.walleij@linaro.org, linux-sh@vger.kernel.org, horms@verge.net.au

Hi Magnus,

On Wednesday 27 November 2013 16:41:22 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add r7s72100 PINCTRL support via sh-pfc. At this point this code
> provides enough support to allow use together with the gpio-rz
> driver. Incremental per-device patches will in the future be
> submitted on top of this base patch to allow PINCTRL enablement
> for each individual device.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/pinctrl/sh-pfc/Kconfig        |    5
>  drivers/pinctrl/sh-pfc/Makefile       |    1
>  drivers/pinctrl/sh-pfc/core.c         |    9 +
>  drivers/pinctrl/sh-pfc/core.h         |    1
>  drivers/pinctrl/sh-pfc/pfc-r7s72100.c |  166 ++++++++++++++++++++++++++++++

One more comment, you should update the DT bindings documentation with the new 
compatible string.

>  5 files changed, 182 insertions(+)

-- 
Regards,

Laurent Pinchart

