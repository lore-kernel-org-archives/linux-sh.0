From: morimoto.kuninori@renesas.com
Date: Wed, 04 Mar 2009 10:51:12 +0000
Subject: Re: [PATCH v2] Add OHCI USB support for SH7786
Message-Id: <uiqmpimsf.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlg2yu02.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlg2yu02.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


Dear Iwamatsu-san

Thank you for checking patch.

> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* USB initial settings
> > + =A0 =A0 =A0 =A0*
> > + =A0 =A0 =A0 =A0* The following settings are necessary
> > + =A0 =A0 =A0 =A0* for using the USB modules.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 __raw_writel(0x00ff0040, 0xffe70094);
> > + =A0 =A0 =A0 __raw_writel(0x00000001, 0xffe7009c);
> > +
> You forget to revise here.

well... there are no name in these register,
and there are no explanation about these value in manual.
It just say do so.
This is the reason why I didn't use MACRO here.

But should I use MACRO ?

Best regards
--
Kuninori Morimoto
=20
