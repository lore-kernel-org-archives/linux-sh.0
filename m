From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 16 Mar 2010 11:59:19 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <201003161259.19579.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Thanks a lot, but 2 questions.
1)I'm using linux2.6.16-ucinux-7203; with the oscilloscope i can se that af=
ter=20
chip reset by the driver the irq line is driven low and stays always low. I=
=20
think the is not proper because this means that never the chip irq state fl=
ag=20
is erased

2) I have a 32 bus connected sh2a D0 do smc9118 D0 and sh2a D31 do smc9118 =

D31; do I need a software swap? ( I followed the schematics of rsk+ 7203 ev=
a=20
board before to learn that for big endioan processors the designer needs to=
=20
physically swap the bytes).

Best regards and thanks a lot



In data marted=EC 16 marzo 2010 12:35:45, Magnus Damm ha scritto:
: > On Tue, Mar 16, 2010 at 8:25 PM, Fabio Giovagnini
>=20
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Hi all, I build a board with smsc 9118 eth chip; Of course I'm not sure
> > the hw is ok.
>=20
> Not sure what is missing in your case, but if you want top optimize
> your performance then this commit may be helpful:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmit;h
> =A30c89ad41099f58922e0941e346e7c4371655b9
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
