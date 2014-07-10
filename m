From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 10 Jul 2014 15:22:33 +0000
Subject: Re: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <20140710151033.GG2296@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2xeD/fx0+7k8I/QN"
List-Id: <linux-sh.vger.kernel.org>
References: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2014 at 01:56:48PM +0200, Wolfram Sang wrote:
> On Thu, Jul 03, 2014 at 02:32:25PM +0530, Vinod Koul wrote:
> > On Thu, Jul 03, 2014 at 10:48:34AM +0200, Wolfram Sang wrote:
> > > Hi,
> > >=20
> > > > With dynamic debug, these flags dont make much sense unless you wan=
t something
> > > > to be printed *always* during boot.
> > >=20
> > > Yes, this was exactly what I wanted. So, for consistency reasons I
> > > copied the existing mechanism over to sh. If it turns out that the
> > > desired default is something different, I'll send patches for that.
> >=20
> > Ah good, and while at it, Please *do* mention this in changelog!
> >=20
> > also fix the subsystem name to dmaengine in patch title
>=20
> So, I assume you are okay with the change now that I gave the reason?
> But should I fix the other subdirs, too? Or keep the change minimal
> (=3D only for sh)?

Yes with a right reason :)

And yes makes sense to do so for whole subsystem.

--=20
~Vinod

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTvqzoAAoJEHwUBw8lI4NHldkP/39jNgZbiq7O0GFGmImiOlZe
C0L8ENjy59QRTQnJhj38qyRkUiR/DZoYbcVRnDu22qVsdjO01i2IhfU31n6EuaKt
YMTpIRh7akmB6PAb0IPKa8gkhfT+V2433BJ9wdiLFpWUZ2bwxRybtOEv4JIviG9h
j53HWgRw3uZrR2CiGRT8aixrBCwEHLQHo6UDweqYnY3zFewGq6f/oNgsvBzLAJln
S/oNZmnSNpi+bXFXFSjT6XLqYPpjNxiWr3HOW6Kr16aM0tSLD9IcxDihFFAAkYIn
hqCmu9Zw97e6GWjw7YE9kuVTikwVzOIJoqyoHbWcLcbWzsrC1Iu/KuiDlqdj7sHZ
Hcx7Mv6YfjypFqMH5UlyFFuw1h1O0SFqySOyP1yKpkZTjjLTUyNVQEXSIs4NHCbk
bBewYQpK09vnpuzr0NtADY2hUPtHLH045ePvbgO2JkQNSI9x7YlDzvtW7fUBRHZx
Ugoz/pZ84HQ2MeMo9QUP2tdtl5vmNx09pwWcjSMim6koCnT0lIUoTeS6HWP2eWcK
wjVF8EHRO8Kaffc93xT5xwxD1QkFHPudnDec1JUiRd1y/7Nd0hbZc/KuKOxjS6Qp
ZgfcVeX8E1Pfh0cfvFxgm1HJfyKrNKh5SgbHzz8GbXlc93twj3U40deE5MVyC9Lg
ibap9vSK/N2HLs5RNqit
=rDlC
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
