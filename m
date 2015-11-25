From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Nov 2015 09:57:20 +0000
Subject: Re: [PATCH] thermal: rcar: enable to set tripN-temp via DT
Message-Id: <CAMuHMdVeDz0ECBM7H2b-GKJyY0NuEJBwoRpM0vE7f-Rkq1R3Dg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <HK2PR04MB0804B55DC6CE36094AEF5162BC1C0@HK2PR04MB0804.apcprd04.prod.outlook.com>
	<564D14A1.70806@renesas.com>
	<87h9kiilbe.wl%kuninori.morimoto.gx@renesas.com>
	<56545CE5.3040502@renesas.com>
	<87mvu37wv2.wl%kuninori.morimoto.gx@renesas.com>
	<5655059C.40509@renesas.com>
	<87io4q97s7.wl%kuninori.morimoto.gx@renesas.com>
	<20151125034320.GA14278@localhost.localdomain>
	<87bnai8xnx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bnai8xnx.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "osd2-bV+sCa4451V9uiUsa/gSgQ@public.gmane.org" <osd2-bV+sCa4451V9uiUsa/gSgQ@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Morimoto-san,

On Wed, Nov 25, 2015 at 6:23 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> Besides, your property is already covered by of-thermal. Please convert
>> your driver to use of-thermal, this way it will give you the flexibility
>> to configure thermal data in DT.
>
> I see, but we need to keep compatibility for non-DT SoC.
> (This driver is used from both DT, non-DT SoC)

Which SoCs with non-DT support use this driver in mainline?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
