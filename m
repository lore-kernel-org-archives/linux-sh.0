From: Felipe Balbi <balbi@ti.com>
Date: Wed, 11 Apr 2012 09:38:48 +0000
Subject: Re: [PATCH] usb: renesas_usbhs: gadget: add support for set_selfpowered
Message-Id: <20120411093847.GJ12064@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mFHiwr52TKrxpkjc"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 01:10:15PM +0900, Shimoda, Yoshihiro wrote:
> The previous code always set to USB_DEVICE_SELF_POWERED in GET_STATUS.
> So, this patch adds set_selfpowered().
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

applied, thanks

--=20
balbi

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhVEnAAoJEIaOsuA1yqREG00P/3+9ElWm+7rP/I12z8sG96zA
zPpow7RZN7dWm3A5X93Lo2HjeZih1ubt9zi6jJ+NhtG/krSJMaGBKi1az6e0YE8L
m96f4ojyywhxcWyGenfGPA62wEp2weXK9zgnHTdoP2LhsH2PpbEagC/AmWw3C0z9
OnFFMdKEMrqzsmjIHExBliNR3PaRHoY11yVOl8unpXheSnraOlSYhF1aPlIXpn9O
OL75ncpelb1oKxpkev0HxtIsD5fn0lv5HuGS97qV05ljFi00rIvVRBGyWLhZjCu6
JLfreah7H/rnNxmres0VT2jwZPmirjyY8TQGOwXnXtvmtpecExHMQSPOFQRmiTQs
LmFYv/CNZCGiPYdgRG5V+0KxyYyng+Y2xg0HCe9509CO31upmGESf2lalRTgAo8u
t3CZCiPdVBp95Ue6TtlMBkGUWXTt6vjRjm9QHZzx8gN2NTNtpfk886GH/vJ3Jsq1
8SIr+T0sXsBsIa8D3T3bjzn09FwEaqx4V6nySCjnLeYYQnNbh7D0BGq8QHZ6htWY
ui7aGJgof0DqMbiw9jrVkkN5aZdIJkfHoEgjHUFTwNetuQlKS0UN8ddFNV2fxTpG
Uia2ivq4D0YqasRqoZvWk6Lw1tQvQgtsWreyUt47Cq16LSlZII8Qc98qdzjPRmnt
nD+Q4l5H7YU8BD2HKnMJ
=Fk3r
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--
