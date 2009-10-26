From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 26 Oct 2009 21:12:41 +0000
Subject: Re: [PATCH] sh: rsk7203 CONFIG_MTD=n fix
Message-Id: <200910262212.41454.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091026100855.13528.68879.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091026100855.13528.68879.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Is this the prop=E8er repository where to clone kernel from?
git clone git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Thanks a lot


Alle 14:49, luned=EC 26 ottobre 2009, Fabio Giovagnini ha scritto:
> I hacked the previuos MCP data toolchain and I got g++ runnung, so I was
> able to compile and run SDL based applications.
> Now I start from u-boot to manage the board from the reset. Later I'll
> approach the problem of user space applications.
> Coudesourgery toolchian is uClibc based or glibc based?
>
> Thanksa  alot
>
> Alle 13:12, luned=EC 26 ottobre 2009, Paul Mundt ha scritto:
> > On Mon, Oct 26, 2009 at 12:23:57PM +0100, Fabio Giovagnini wrote:
> > > OK. Thanks a lot.
> > > Did you build any application for rsk7203?
> > > I used MCP data environment, but it is without g++, so I cannot use
> > > libraries as SDL, qt embedded, or more.
> > > I think  exculding all the g++ stuff  is not strategic.
> >
> > Then talk to MPC about it. This is not an MPC support forum, and
> > obviously we do not recommend using antiquated toolchains.
> >
> > The CodeSourcery toolchain is the only one that is current and supporte=
d,
> > although the SH-FDPIC toolchain aimed at SH-2A is not yet publically
> > available. However you can of course take the source and attempt to
> > construct a FLAT toolchain from it in the interim (although this too
> > would result in a currently unsupported configuration).
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Fabio Giovagnini

Aurion s.r.l.
CF e P.IVA 00885711200
Tel. +39.335.8350919

www.aurion-tech.com

account telefono VoIP skype (www.skype.com):
aurion.giovagnini
