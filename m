From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Apr 2013 08:50:33 +0000
Subject: Re: [PATCH v3 0/9] Reorganize R8A7779/Marzen USB code
Message-Id: <20130410085033.GL7983@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="t5NgoZwlhlUmGr82"
List-Id: <linux-sh.vger.kernel.org>
References: <201304100226.08967.sergei.shtylyov@cogentembedded.com>
 <20130410044923.GD10044@verge.net.au>
In-Reply-To: <20130410044923.GD10044@verge.net.au>
To: linux-arm-kernel@lists.infradead.org

--t5NgoZwlhlUmGr82
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 10, 2013 at 01:49:23PM +0900, Simon Horman wrote:
> On Wed, Apr 10, 2013 at 02:26:08AM +0400, Sergei Shtylyov wrote:
> > Hello.
> >=20
> >    Here's the set of 9 patches against the Simon Horman's 'renesas.git'=
 repo,
> > 'renesas-next-20130410' tag.  It was created to fix the shortcomings in=
 the
> > R8A7779/Marzen USB platform code and R8A7779 USB common PHY driver, and=
 so
> > spans both arch/arm/mach-shmobile/ and drivers/usb/ subtrees (some patc=
hes have
> > to touch both subtrees). The patches were conceived with the complete
> > bisectability goal in mind.
> >=20
> > [1/9] ARM: shmobile: Marzen: move USB EHCI, OHCI, and PHY devices to R8=
A7779 code
> > [2/9] ehci-platform: add pre_setup() method to platform data
> > [3/9] ARM: shmobile: R8A7779: setup EHCI internal buffer
> > [4/9] rcar-phy: remove EHCI internal buffer setup
> > [5/9] ARM: shmobile: R8A7779: remove USB PHY 2nd memory resource
> > [6/9] rcar-phy: correct base address
> > [7/9] rcar-phy: add platform data
> > [8/9] ARM: shmobile: Marzen: pass platform data to USB PHY device
> > [9/9] rcar-phy: handle platform data
> >=20
> >    I'm not sure thru which tree this patchset should be merged, however=
 it turns
> > out that it's too late now to push it thru Felipe Balbi's USB tree for =
3.10
> > (which would have been most convenient probably), and it's probably too=
 late to
> > merge thru Simon's tree for 3.10 too. So it now have to be postponed to=
 3.11,
> > unfortunately...
>=20
> Felipe, how would you prefer to handle this?
> I'm happy for you to take it or to take it myself.

please take it yourself, just keep in mind there will be conflicts, I
will go over the patches now and give my Acked-by so you can queue them
up.

cheers

--=20
balbi

--t5NgoZwlhlUmGr82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRZSfZAAoJEIaOsuA1yqREbDwP/i+hy4M5yN42/paoRaYGzGlp
za/Cur6Oj4W7Qy3qzzwmkra21e8J+6gtpi/oft7FWl+3bxf3VCwGeATkxP7BOD5h
eqjDX2s9mpqUX80A47N84oeoYfTxrU6O6xgUKOjTn0jRbhGKjjdh3GD69pJWSaYS
MutbkLGkDfyc/y1JN2fjvlWYf3H2g4j2rcNs72cVW9uCMpfvHCzaOD8yW8u0ft9F
9xNajMZwkphldKt5kOBCGuAgtYy4x5twRHHR/vwtD5bMf2GsRgqnIac1BC9NMVVW
fWOEzEEBBE9/Q0eyqttKTGY8ASEdCcvi97kuDhwOzvprebZkVScppAL949jlYN6r
/JNOkBTS9ezDgujr9uLN+sRdN02lCmPjyyEUsuRllF+uKaba9+kPPzNffkoKOrzT
yX51xTti6LDKVSC1i0ntvxTTyw8hDmmNioM23wnd4FintaSkekdEoWYcW0HibqqK
pTg+03lTyJyAmEwXD4s1wGnOiKaCpeEjTTGemFiXQKQtClsBEbpheKzS3/jl1oZn
sDseRvhg+Rxx8dji46RCqmDCRl1crM43t+2r28P2udWGkIohrSXf+AMPhCuwFAB9
3x7xaRUDN7oKq413DJp5GIK0vPFnkYZTI8ZxEEkcB1RO61JpqS9utSTF5NRNgLde
xhIcm8hJCELTJVZi3bf3
=FA3C
-----END PGP SIGNATURE-----

--t5NgoZwlhlUmGr82--
