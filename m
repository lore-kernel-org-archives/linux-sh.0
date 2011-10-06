From: Felipe Balbi <balbi@ti.com>
Date: Thu, 06 Oct 2011 11:47:22 +0000
Subject: Re: [PATCH v2 4/4] usb: r8a66597-udc: add support for SUDMAC
Message-Id: <20111006114721.GK1714@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7ArrI7P/b+va1vZ8"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2011 at 08:07:38PM +0900, Yoshihiro Shimoda wrote:
> SH7757 has a USB function with internal DMA controller (SUDMAC).
> This patch supports the SUDMAC. The SUDMAC is incompatible with
> general-purpose DMAC. So, it doesn't use dmaengine.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

applied, thanks

--=20
balbi

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOjZVJAAoJEAv8Txj19kN1DocH/1P4kFoh3xaa9cKY42azwF90
IpgJ3FdrS7aqPBowO10ys7zotHkPmyct3oIPS0vnMbd/4pYb5QhXdeLHTsRgGp9G
jc0H1Wn/y38GQ6577hCraSxCnhmSFOnVlAjgDl9upAtTI0+oe+lcdAfpu7SoRlkZ
YMWg4xLjphtP4pbaEoQ5w9VPB9Ryov1ohQW27IuI06YTvlBE6eOeb/3nuCax16mR
V681nEwC+wG4UOQNmMtrBHmxfFPkmflruhtjPSvl4xdGDACV5pjK1dJueRrBbEY9
I6tAa8xwKzfxctF0kXdLZ07KXug6nfQ5lpGujq0likPettdj35+moJKKj2FpxNk=
=T4LM
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
