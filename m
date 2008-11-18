From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 18 Nov 2008 15:53:59 +0000
Subject: Re: [PATCH] - Fix dreamcast irq.c formatting
Message-Id: <20081118175424.19bc9a4b.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__18_Nov_2008_17_54_24_+0100_4oz1+un3hUADivLD"
List-Id: <linux-sh.vger.kernel.org>
References: <20081118172847.1ac04194.kristoffer.ericson@gmail.com>
In-Reply-To: <20081118172847.1ac04194.kristoffer.ericson@gmail.com>
To: linux-sh@vger.kernel.org

--Signature=_Tue__18_Nov_2008_17_54_24_+0100_4oz1+un3hUADivLD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Nov 2008 00:49:51 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Tue, Nov 18, 2008 at 05:28:47PM +0100, Kristoffer Ericson wrote:
> > This patch cleans the bad formatting
> > found in mach-dreamcast/irq.c file.
> >=20
> Why even bother? There are more useful things you can be doing with this
> file, like fixing up the comment to deal with the fact there have been
> path changes, converting to the new IRQ model (this is one of the last
> ones left on hw_interrupt_type), etc. Once those sorts of things are out
> of the way, the rest is fairly trivial to tidy, and you can fix up the
> formatting as you go along with regards to new code.

Oki point taken. Ive got no dreamcast to fiddle with
so I'll just leave it alone. Just decided to drop a patch
when I accidently saw the mess it was in.

>=20
> Whitespace changes have a high risk of causing merge conflicts and
> provide precisely zero benefit. If you don't plan to be making any
> constructive changes to this file, then simply leave it alone.


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Tue__18_Nov_2008_17_54_24_+0100_4oz1+un3hUADivLD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkki80AACgkQPQls10ERAGeO2ACgpV/cYbo+qGrf3TcBZ38U5dba
1EEAni2Yr0bRBfWRaTklM2e7/Sb8mcgy
=mKWs
-----END PGP SIGNATURE-----

--Signature=_Tue__18_Nov_2008_17_54_24_+0100_4oz1+un3hUADivLD--
