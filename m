From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 07 Aug 2015 00:00:15 +0000
Subject: Re: [PATCH 06/13 v4][RFC] arm64: renesas: enable SCIF on defconfig
Message-Id: <87d1z0dl8a.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oaikyhba.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oaikyhba.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -106,6 +106,9 @@ CONFIG_SERIAL_8250_CONSOLE=y
> >  CONFIG_SERIAL_8250_MT6577=y
> >  CONFIG_SERIAL_AMBA_PL011=y
> >  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> > +CONFIG_SERIAL_SH_SCI=y
> > +CONFIG_SERIAL_SH_SCI_NR_UARTS=6
> 
> 11?
> 
> 6 x SCIF + 5 x HSCIF

Good catch
will fix in v5
