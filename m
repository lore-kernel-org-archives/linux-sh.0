From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 23 Mar 2010 05:39:25 +0000
Subject: Re: smc9118 problem
Message-Id: <201003230639.25595.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003222019.48247.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003222019.48247.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Ok. I'll do ASAP, but it will be not so easy, because I need a very complet=
e=20
different environment, as Andrew wrote some days ago.

Cheers and thanks.

P.S.
I can get  2.6.34-rc2 using git from sh rep or I need to download from the =

official kernel mirror?





In data marted=EC 23 marzo 2010 05:07:32, Paul Mundt ha scritto:
: > On Mon, Mar 22, 2010 at 08:19:48PM +0100, Fabio Giovagnini wrote:
> > Hi all, II have a problem with smc9118 chip;
> > I do not make any eeprom initialitazione because I do not have any eepr=
om
> > on my board.
> > When occurs an rx overrun the chip stops to receive, and I have
> > experienced that doing
> > ~> cat /proc/smc911x/resetphy
> > ~> cat /proc/smc911x/resetsmc
> > ~> cat /proc/smc911x/enable
> >
> > it restart properly.
> >
> > I'm using kernel 2.6.17; does any of you have suggetion about I nedd to
> > check for discover which bits I have to set in case of rx overrun?
>=20
> Please verify whether you can reproduce this with 2.6.34-rc2, thanks.
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
