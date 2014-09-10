From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Sep 2014 13:50:04 +0000
Subject: Re: [PATCH 2/4] usb: renesas_usbhs: gadget: fix the behavior of pullup
Message-Id: <20140910135004.GE667@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2qXFWqzzG3v1+95a"
List-Id: <linux-sh.vger.kernel.org>
References: <54102910.70703@renesas.com>
In-Reply-To: <54102910.70703@renesas.com>
To: linux-sh@vger.kernel.org

--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2014 at 07:33:52PM +0900, Yoshihiro Shimoda wrote:
> This patch fixes an issue that this driver always enable the D+ pullup
> after it detected the VBUS connection even though this usb controller
> can control the D+ pullup timing by software. So, this driver should
> enable the D+ pullup after a gadget driver called usb_gadget_connect().
>=20
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

which commit does this fix ? Do we need cc stable ?

--=20
balbi

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEFcMAAoJEIaOsuA1yqRELzUP/RZf7CdVM2VeM2Czpely5F6Q
503Lk2xUsgburIKMjCg8ypCHn4hR/GzIlTDDrPL11fC7WbxEF8BnZ7kHvgxv4v+S
yzSLJMwSFlPc+Ci8rd01+EBCWdxSjbGowotUBfb0YI5wfpxxLXoxnVk3vlmrJYUU
HTnbRzR4xJmrVaUf7Nlx7PvCgKVkuSBNyAZS3f3Ixp66PWxbtOmW7SF+CpVXR/Q1
5APooY0Dpbzdtjo28kC6oxsXXtSZ6X4JI49GGPxwyHAMbDQlKb7Y0ijdErqf0KR6
8OH3LpUtp1LvQ9nOiYuJQKQs0SCAnuIr5fO6sX0Sj+PaOAdnYxFAtuKMT91rnuGs
YdNtUD1gXDI22t5HHrrOS2dPn39T/QkKv9x5D1BfhYb7rt3075BBHoVf4sSHiiQr
gQEardk+a0YqpUSTyGVBgQ10PqDYYBWCxGHcEEYxrwb6PA2OYrd2wD8WtksSERJS
wUwkjAN09biygR1Etfb+/ley5sKVZwIV/h0JJwtm+KPHYmmXNp8fcacqIPoU/eNB
kM5ez+Gs8mkjX5iv/YJg3ph7LSSeKrlcGM2IcQEDd6LUqzKrfVr7gHBJLYccLAdu
R5i2/dfBt00cc/8v9ghu53ptL9ZtQfGZ46GxFPBqAIHTtLfh9ELNIlDlaEGOZPqU
5AXxhVnVtpwes7/e2Zd0
=u168
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
