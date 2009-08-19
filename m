From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 13:59:56 +0000
Subject: Re: [PATCH 1/3] Add SuperH FSI driver support for ALSA
Message-Id: <aec7e5c30908190659n4b81272ek6e06f23f4ee71a15@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uljlg59ls.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uljlg59ls.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, lethal@linux-sh.org, Takashi Iwai <tiwai@suse.de>, broonie@opensource.wolfsonmicro.com

Hi Morimoto-san,

Thanks for your work on this!

On Wed, Aug 19, 2009 at 8:25 PM, Kuninori
Morimoto<morimoto.kuninori@renesas.com> wrote:
> This driver is very simple.
> It support playback only now.
> It is tested by ms7724se board.
>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---

[snip]

> --- /dev/null
> +++ b/include/sound/fsi.h

How about using sh_fsi.h or sh_mobile_fsi.h? I think
include/sound/fsi.h is polluting the name space.

> --- /dev/null
> +++ b/sound/soc/sh/fsi.c
[snip]
> +struct fsi_master {
> + =A0 =A0 =A0 void __iomem *base;
> + =A0 =A0 =A0 atomic_t user;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 struct fsi_priv fsia;
> + =A0 =A0 =A0 struct fsi_priv fsib;
> + =A0 =A0 =A0 struct sh_fsi_platform_info *info;
> +};
> +
> +struct fsi_master *master;

Is it really necessary to have "master" as a global variable? Maybe
this global variable is there to work around some framework issue?

If possible please try to avoid using a global variable like this.
Future processors may come with multiple FSI blocks.

Right now I'm quite happy that the CEU driver does not use global
variables. Remember the case with a single CEU in sh7722 and now we
have two CEU blocks in sh7724. It was easy to support sh7724 because I
avoided using global variables when I initially wrote the driver for
sh7722.

Cheers,

/ magnus
