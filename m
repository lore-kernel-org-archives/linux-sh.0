From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 Nov 2012 13:17:29 +0000
Subject: Re: [PATCH 17/42] sh-pfc: Move driver from drivers/sh/ to drivers/pinctrl/
Message-Id: <1694290.k6RRrcIRbt@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1353464863-10281-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1353464863-10281-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAOh2x=kEv1Sgx74jNgdQJL4ivrYVpYhC0kM6--BTk+ibwRm3kg@mail.gmail.com>
In-Reply-To: <CAOh2x=kEv1Sgx74jNgdQJL4ivrYVpYhC0kM6--BTk+ibwRm3kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viresh kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Phil Edworthy <phil.edworthy@renesas.com>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, linux-sh@vger.kernel.org

Hi Viresh,

On Wednesday 21 November 2012 08:58:19 viresh kumar wrote:
> On Wed, Nov 21, 2012 at 7:57 AM, Laurent Pinchart wrote:
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/pinctrl/Kconfig          |    1 +
> >  drivers/pinctrl/Makefile         |    1 +
> >  drivers/pinctrl/sh-pfc/Kconfig   |   24 ++
> >  drivers/pinctrl/sh-pfc/Makefile  |    5 +
> >  drivers/pinctrl/sh-pfc/core.c    |  611 +++++++++++++++++++++++++++++++++
> >  drivers/pinctrl/sh-pfc/core.h    |   54 ++++
> >  drivers/pinctrl/sh-pfc/gpio.c    |  181 +++++++++++
> >  drivers/pinctrl/sh-pfc/pinctrl.c |  481 ++++++++++++++++++++++++++++++
> >  drivers/sh/Kconfig               |    1 -
> >  drivers/sh/Makefile              |    1 -
> >  drivers/sh/pfc/Kconfig           |   18 --
> >  drivers/sh/pfc/Makefile          |    5 -
> >  drivers/sh/pfc/core.c            |  611 ---------------------------------
> >  drivers/sh/pfc/core.h            |   54 ----
> >  drivers/sh/pfc/gpio.c            |  181 -----------
> >  drivers/sh/pfc/pinctrl.c         |  481 ------------------------------
> 
> I haven't gone through the patch, but is it a simple git mv of files?
> If yes, please generate such patches with following command to make review
> really simple:
> 
> git format-patch -C -M

My bad. Will do in the next version.

-- 
Regards,

Laurent Pinchart

