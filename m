From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 17 Mar 2010 11:31:25 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <201003171231.25214.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Sorry magnus, maybe I'm able to develop some pieces of kernel, but for sure=
 i=20
dont' know how to use the cooperative development tools; now I'm learing.=20
Thanks for your patience

Thanks again


In data mercoled=EC 17 marzo 2010 12:15:29, Magnus Damm ha scritto:
: > On Wed, Mar 17, 2010 at 8:11 PM, Fabio Giovagnini
>=20
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Is it accessible by me for example
> > git://git.kernel.org/pub/scm/linux/kernel/git/magnus/sh-2.6.git
> >
> > or not?
>=20
> You don't need any speical tree or patches. The normal sh-2.6 tree
> should include all you need. Please try using the same commands as me
> below:
>=20
> Check last commit in git branch/tree:
>=20
> damm@t400s ~/git/sh-2.6 $ git log -1 --oneline | head -n 1
> 3f7581d serial: sh-sci: remove duplicated #include
>=20
> Look for board support:
>=20
> damm@t400s ~/git/sh-2.6 $ grep SMSC911X_SWAP_FIFO
> arch/sh/boards/mach-rsk/devices-rsk7203.c
>        .flags          =3D SMSC911X_USE_32BIT | SMSC911X_SWAP_FIFO,
>=20
> Look for driver support:
>=20
> damm@t400s ~/git/sh-2.6 $ grep SMSC911X_SWAP_FIFO drivers/net/smsc911x.c
>        if (pdata->config.flags & SMSC911X_SWAP_FIFO) {
>        if (pdata->config.flags & SMSC911X_SWAP_FIFO) {
> damm@t400s ~/git/sh-2.6 $
>=20
> Cheers,
>=20
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
