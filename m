From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 16 Mar 2010 12:38:02 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <201003161338.02940.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

After I'll be able to have busybox I'll try to do it for sure.
Which one you suggest to me?



In data marted=EC 16 marzo 2010 13:32:29, Magnus Damm ha scritto:
: > Hi Fabio,
>=20
> On Tue, Mar 16, 2010 at 8:59 PM, Fabio Giovagnini
>=20
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Thanks a lot, but 2 questions.
> > 1)I'm using linux2.6.16-ucinux-7203; with the oscilloscope i can se that
> > after chip reset by the driver the irq line is driven low and stays
> > always low. I think the is not proper because this means that never the
> > chip irq state flag is erased
>=20
> Why are you using such an old kernel? It's more than 3 years old!!!
>=20
> > 2) I have a 32 bus connected sh2a D0 do smc9118 D0 and sh2a D31 do
> > smc9118 D31; do I need a software swap? ( I followed the schematics of
> > rsk+ 7203 eva board before to learn that for big endioan processors the
> > designer needs to physically swap the bytes).
>=20
> I've added code to enable swap on upstream for the rsk7203. It was
> needed by big endian platforms.
>=20
> Please use a newer kernel if possible.
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
