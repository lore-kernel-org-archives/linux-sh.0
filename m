From: Felipe Balbi <balbi@ti.com>
Date: Wed, 11 Apr 2012 10:03:13 +0000
Subject: Re: [PATCH v2] usb: r8a66597-udc: add support for set_selfpowered
Message-Id: <20120411100312.GR12064@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="phbq2bkSb+hZnunM"
List-Id: <linux-sh.vger.kernel.org>
References: <4F855420.5010705@renesas.com>
In-Reply-To: <4F855420.5010705@renesas.com>
To: linux-sh@vger.kernel.org


--phbq2bkSb+hZnunM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 06:51:28PM +0900, Shimoda, Yoshihiro wrote:
> The previous code always set to USB_DEVICE_SELF_POWERED in GET_STATUS.
> So, this patch adds set_selfpowered().
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

applied, thanks

--=20
balbi

--phbq2bkSb+hZnunM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhVbgAAoJEIaOsuA1yqREhx0QAKxO1vTu7HRgrQXZ7bcIUsuw
YROXtCJZacA6HVYN1RME3ybG5tBJHujCExzihetxy4dI1WJPFY9jli73ZiIWZENM
gDFY2VA+8CTDkaaASR1fd6J6WhG8GS8xJ+rOgBVZadCLVN5Zu0cQ9xrG6Rp3G4sp
l99Sx0mNYe9kjGyEzZN8DA3/YCVzgj4tnQ3XR/SZnTG6Q2jnCgibob0SizrOSRFB
ifHXaXsoYwit4b42AQq6iJsbMq/20jlrTDof23aio5ms4GqJVe0s4PfGTLag+0vC
USfxFwLugmKwJ/4DvA5UWPyL/c6CRg3MBRo/IguPsM3HCP8M1liTpS5NOOGNgo6S
GSNUjZDcFSsbbHZ5YVeeJYJsoTvCRnDyXYw1EYwyaKbxiYTv/mhhMX+9xnFRZ/EE
32HmX0neYx4irIoyXfm5MIuQv1UX8cShQw6lm15FWnzr/G/PSYpaF328yYDcm2s0
aBLoXpITckuxhYD2olNZXi1uuZGoxAN+3Z+K2HpPz9+9ZIO1jbxJctsW+0ljxNq1
23xWVcCrUck9Kcak2jAN42t4Rqfp2up4aX7WYs9PPgVRgTOaZp3SAFi1Ska+fipC
YV8PMserVbV/hoSXPc84aXlP0uIJhWsoxpcAIUzKaXjXms/wwUpCu/4+JMYehukB
BnMp++5GgNzyeVVAJXJ0
=wMhM
-----END PGP SIGNATURE-----

--phbq2bkSb+hZnunM--
