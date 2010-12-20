From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 20 Dec 2010 08:12:24 +0000
Subject: Re: about sh_mobile_lcdcfb.c :: lcd_size_cfg
Message-Id: <AANLkTinf-Hz3MXT0SzDUnbRaEU0rX_aTD33q8aXALAxo@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pd3ow6f3t.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pd3ow6f3t.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hey Morimoto-san,

On Mon, Dec 20, 2010 at 5:08 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Dear Guennadi, Magnus, Paul
> and SuperH ML members
>
> I noticed that current sh_mobile_lcdcfb.c driver seems doesn't use lcd_si=
ze_cfg.
> maybe turning point is
>
> --------------
> commit 14177a5e56904a584f3777f36b50c8d7bfde5810
> Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Date: =A0 Fri Sep 3 07:19:49 2010 +0000
>
> =A0 =A0fbdev: sh_mobile_lcdcfb: use fb_videomode_to_var() instead of open=
-coding
>
> =A0 =A0Use the standard fb_videomode_to_var() instead of filling fb_var_s=
creeninfo
> =A0 =A0fields manually in, also remove a redundant memset(0).
>
> =A0 =A0Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> =A0 =A0Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> --------------
>
> So, I created below patch.

Thanks for your patch, Morimoto-san.

> Is this correct ?

I don't think so. The purpose of these members is to allow users to
calculate aspect ratio properly. If you remove all this information
then there is zero chance of that happening. I think the LCDC driver
should be fixed instead.

Cheers,

/ magnus
