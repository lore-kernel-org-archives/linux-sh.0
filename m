From: Felipe Balbi <balbi@ti.com>
Date: Thu, 06 Oct 2011 11:46:50 +0000
Subject: Re: [PATCH v2 2/4] usb: r8a66597-udc: add function for external
Message-Id: <20111006114649.GI1714@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xQR6quUbZ63TTuTU"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2011 at 08:07:21PM +0900, Yoshihiro Shimoda wrote:
> R8A66597 has the pin of WR0 and WR1. So, if one write-pin of CPU
> connects to the pins, we have to change the setting of FIFOSEL
> register in the controller. If we don't change the setting,
> the controller cannot send the data of odd length.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

applied, thanks

--=20
balbi

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOjZUpAAoJEAv8Txj19kN1q2EH/3aCbQbJVqv7JWmwFgrtHke0
kezWvf8E+mtVwi1oDAJ20qxl1RJ4P1oR2vdUrhRlCEi5131WSvUHcl1brsRPf0cB
rhhX99RoxDLCPX50goeSuz+/7Q3IP901Z7mNYFcXPivSxulkBLXeMUTFTmdabEk9
lxa3grR80qPrlLY+uh8/lFSCReHsGcGUSN3OxcHzxW7KiYRUBQbBZpVzeA4NaRQw
6tU3c9lnu0tTocac54l/T9E9OfeyLYgNRjWPuc+Cdh0FzCIWrFXpV0HnBcq0H3t6
rlAAHN3o7BZ1Q7sFgAAoBTzZY/uC0WV40Qt8KrJmGxazMgeMm1YDTCbuYT9Ai2g=
=uGKb
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
