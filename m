From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 26 Jan 2011 15:27:51 +0000
Subject: Re: AW: Hi All, we are looking for support for developing our sh2a 7203 based board
Message-Id: <201101261627.51590.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101261311.28480.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101261311.28480.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

The board si already done, and when we designed it sh2a 7203 was the only=20
available for us.
Furthermore we bought a rsk+ dev kit so it was easier to design.

By the way I have problem only with the video ram management.
I have just one SDRAM chip connected to the sh2a bus, and I use that ram fo=
r=20
code and framebuffer; the ram is 32 bit wide.
Sometime I have a glitch pixel on the screen and I suppose because of I do =
not=20
allocate into the uCLinux kernel properly the framebuffer.
But I'm not sure of this.


On Wednesday 26 January 2011 16:20:51 Christian Bauer wrote:
> Hi Fabio,
>=20
> Developing a 7203 based board should not be very complicated if it based =
on
> the Renesas RSK+.
>=20
> Have you any reason to select a 7203? Renesas designed the 7262/7264 that
> also supports uCLinux and is much better documented as it was developed by
> Renesas and not mpc data (like the 7203/7201 port).
>=20
> Christian J. Bauer
> Software-Development
> MONDIAL electronic GmbH, Austria
>=20
> -----Urspr=FCngliche Nachricht-----
> Von: linux-sh-owner@vger.kernel.org [mailto:linux-sh-owner@vger.kernel.or=
g]
> Im Auftrag von Fabio Giovagnini Gesendet: Mittwoch, 26. J=E4nner 2011 13:=
11
> An: linux-sh@vger.kernel.org
> Betreff: Hi All, we are looking for support for developing our sh2a 7203
> based board
>=20
> Hi All
> we are lloking for support (paying of course) for developing our sh2a 7203
> based board.
> Is any of you interested to talk about?

--=20
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
