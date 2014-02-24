From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 24 Feb 2014 10:33:09 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: r8a7791: add IIC0/1 clock macros
Message-Id: <20140224103309.GA4445@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
List-Id: <linux-sh.vger.kernel.org>
References: <1389121036-3555-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1389121036-3555-2-git-send-email-geert@linux-m68k.org>
To: linux-sh@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2014 at 11:13:42PM +0100, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> Thank you for the patch.
>=20
> On Sunday 23 February 2014 13:40:21 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa@sang-engineering.com>
> >=20
> > Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> > ---
> >  include/dt-bindings/clock/r8a7791-clock.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/include/dt-bindings/clock/r8a7791-clock.h
> > b/include/dt-bindings/clock/r8a7791-clock.h index 30f82f2..9aa60f4 1006=
44
> > --- a/include/dt-bindings/clock/r8a7791-clock.h
> > +++ b/include/dt-bindings/clock/r8a7791-clock.h
> > @@ -55,6 +55,8 @@
> >  #define R8A7791_CLK_CMT1		29
> >  #define R8A7791_CLK_USBDMAC0		30
> >  #define R8A7791_CLK_USBDMAC1		31
> > +#define R8A7791_CLK_IIC0		18
> > +#define R8A7791_CLK_IIC1		23
>=20
> Could you please keep the entries sorted by value ?

Ehrm, yes, sure. Very weird, I am pretty sure I looked for the sorting
and thought I found a chornological one. Will fix.


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTCx/lAAoJEBQN5MwUoCm2T3wP/AoLREyJyl3BIv0R5yyJ8rWi
KuXrFtsH+UMMpzTapbtZ6NLiofDOFLAHobITCjcD/9N7QbaoR4l9Q3oD6FS028nC
UhxQyCsux37jxLF9/tPbndeFUvB4P3NSpwyxfRB2arDMpVHpQ0OCBmqGSdV1PvsC
OlAR9RRzVWQvgxKrLgGXkADclagzUCReVpPwbfloFvY183/pbBPVqIqE5ZGy4CXs
SydG2YTQNRHS24cjieqjhSUw5Qf6OEFvvM+Rp88lDp8yJIjszu97x+mUR6tU3wNn
HZSrxrr9JiTYnj+no3O/Men+cf3Ksuotvut5nkCwPW3KResYXwV2hYy91i/Renlg
JdphKZzZMudaFbxm/C67IfKRtS84sR/tA2hdaOBuusB4kMiHlqqp+sB7tN1cJYHs
c9tZxeL0ooWRlw3QUwvMd6duScbf1lDYLE88PCHHPP1yNZcP+buePdEKc6+rchJH
TzSB34HCv5DbnVGOfXHTBAOi6ovFCvf71gjtVc3qNxeVdC3e8ALLDpoaz9gu/6xw
gRpj2kblTECtygsfv5EduWdIsFmdvEJ26ATUawWmWvqBFcL3FFLVEt/wMuzAMxA4
bycYJt5M2e2ej7XLhxB0cw+c7aO29nbDpWpyVoiLpwApQyIJi3yEorTng+e+tlGs
Z41RP2FJUAuUl3xcrHYl
=fVpY
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
