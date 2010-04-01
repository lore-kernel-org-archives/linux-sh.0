From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 01 Apr 2010 10:06:16 +0000
Subject: Re: PFC of SCIF 1
Message-Id: <201004011206.16554.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201004011136.26340.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004011136.26340.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Sorry Magnus, I do not understand.
I have ttySC0 as default console and the system works; now I'm writing my=20
application for managing teh ttySC1 port for my specif problem.
Where can I find the PFC initialization for ttySC0 Port into the kernel tre=
e?

Thanks a lot


In data gioved=EC 01 aprile 2010 12:03:01, Magnus Damm ha scritto:
: > Hi Fabio,
>=20
> On Thu, Apr 1, 2010 at 6:36 PM, Fabio Giovagnini
>=20
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Hi All,
> > is the bootloader responsable of initizlization of PFC for Serial Ports
> > pin, or the sh-sci drivers?
>=20
> Close. =3D) The board specific code.
>=20
> Cheers,
>=20
> / magnus
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
