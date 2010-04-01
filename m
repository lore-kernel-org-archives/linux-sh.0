From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 01 Apr 2010 13:52:21 +0000
Subject: Re: PFC of SCIF 1
Message-Id: <201004011552.22035.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201004011136.26340.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004011136.26340.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

My problem is in=20
tcsetattr(HPort, /*TCSAFLUSH*/TCSANOW, &term)

Where can I find a term setting working a a very basic raw mode (just like =
the=20
ttySC0 running the terminal console)

Thanks.



In data gioved=EC 01 aprile 2010 12:16:13, Fabio Giovagnini ha scritto:
: > Ok, now I'll get a look.
>=20
> Thanks a lot
>=20
> In data gioved=EC 01 aprile 2010 12:11:51, Magnus Damm ha scritto:
> : > Hi Fabio,
> >
> > On Thu, Apr 1, 2010 at 7:06 PM, Fabio Giovagnini
> >
> > <fabio.giovagnini@aurion-tech.com> wrote:
> > > Sorry Magnus, I do not understand.
> > > I have ttySC0 as default console and the system works; now I'm writing
> > > my application for managing teh ttySC1 port for my specif problem.
> >
> > If the boot loader usually sets up the pinmux and if the kernel does
> > not touch it then it will work. On SH the proper way to do this is to
> > let the kernel use the GPIO framework to configure the pinmux using
> > request_irq().
> >
> > > Where can I find the PFC initialization for ttySC0 Port into the kern=
el
> > > tree?
> >
> > Have a look at this:
> >
> > damm@t400s ~/git/linux-2.6 $ find arch/sh | xargs grep gpio_request |
> > grep SCIF
> >  arch/sh/boards/mach-se/7724/setup.c:	gpio_request(GPIO_FN_SCIF3_I_SCK,
> >  NULL);
> >  arch/sh/boards/mach-se/7724/setup.c:	gpio_request(GPIO_FN_SCIF3_I_RXD,
> >  NULL);
> >  arch/sh/boards/mach-se/7724/setup.c:	gpio_request(GPIO_FN_SCIF3_I_TXD,
> >  NULL);
> >  arch/sh/boards/mach-se/7724/setup.c:	gpio_request(GPIO_FN_SCIF3_I_CTS,
> >  NULL);
> >  arch/sh/boards/mach-se/7724/setup.c:	gpio_request(GPIO_FN_SCIF3_I_RTS,
> >  NULL);
> >  arch/sh/boards/mach-ecovec24/setup.c:	gpio_request(GPIO_FN_SCIF0_TXD,
> >  NULL);
> >  arch/sh/boards/mach-ecovec24/setup.c:	gpio_request(GPIO_FN_SCIF0_RXD,
> >  NULL);
> >  arch/sh/boards/mach-kfr2r09/setup.c:	gpio_request(GPIO_FN_SCIF1_RXD,
> >  NULL);
> >  arch/sh/boards/mach-kfr2r09/setup.c:	gpio_request(GPIO_FN_SCIF1_TXD,
> >  NULL);
> >=20
> > arch/sh/boards/mach-highlander/pinmux-r7785rp.c:	gpio_request(GPIO_FN_S=
CI
> >F 0_CTS, NULL);
> > arch/sh/boards/mach-highlander/pinmux-r7785rp.c:	gpio_request(GPIO_FN_S=
CI
> >F0 _RTS, NULL);
> > arch/sh/boards/mach-highlander/pinmux-r7785rp.c:	gpio_request(GPIO_FN_S=
CI
> >F0 _SCK, NULL);
> > arch/sh/boards/mach-highlander/pinmux-r7785rp.c:	gpio_request(GPIO_FN_S=
CI
> >F0 _RXD, NULL);
> > arch/sh/boards/mach-highlander/pinmux-r7785rp.c:	gpio_request(GPIO_FN_S=
CI
> >F0 _TXD, NULL);
> > damm@t400s ~/git/linux-2.6 $
> >
> > Cheers,
> >
> > / magnus
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
