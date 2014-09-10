From: Felipe Balbi <balbi@ti.com>
Date: Wed, 10 Sep 2014 13:49:37 +0000
Subject: Re: [PATCH 1/4] usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()
Message-Id: <20140910134937.GD667@saruman.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Hf61M2y+wYpnELGG"
List-Id: <linux-sh.vger.kernel.org>
References: <54102904.6060703@renesas.com>
In-Reply-To: <54102904.6060703@renesas.com>
To: linux-sh@vger.kernel.org

--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2014 at 07:33:40PM +0900, Yoshihiro Shimoda wrote:
> This patch fixes an issue that the NULL pointer dereference happens
> when we use g_audio driver. Since the g_audio driver will call
> usb_ep_disable() in afunc_set_alt() before it calls usb_ep_enable(),
> the uep->pipe of renesas usbhs driver will be NULL. So, this patch
> adds a condition to avoid the oops.
>=20
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Which commit does this fix ? Do we need a Cc: stable ?

--=20
balbi

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEFbxAAoJEIaOsuA1yqRE0nUP/1Oq28RoPJP4m8CjDPoGpfwf
QDfQxUY7gddbsKJUbgmprIl+mxqg+CrrAh/5DqCADoFzkHScLaUCXOlHT/VcB9dy
j41D0Ukj5+Y0d0mYW3Nz9iRiiVDyxeTByDg77ch18DrSxzmZCbOXpqa+vBuxKZKl
57tZ9wcjjMxXAh8lhkX2K0fVmypEZp8biysUcnkHQI+Dqq85RtZ/BdwwTGYIEkXo
w0oKnBO/JOb2HrAMBUFS9TfsnAcnJtHOREgcWQrogyKkwwLUzE46oaiU5tcV8H9n
9ooAzbLWgaX5lKaftdyd6gQKeNoyhZJi0T1oNlCYMoCDRXEssWPLWlgJRCVCUtfO
+UNMVHXwfhusRjgEK1B2c3TmDmsuQ3ZkVLvTptOopKHyGROhuoVQZPeNabdy9yy+
v5VBtoJziVeZHM21i5+WcT8j8VMYYodf7NTPXmd9IQFOZTchjHY8+gMfmkqdMov8
P+Dv7PAsUThNf3rJd84D1MV0U9RNAADsGCPG3N3ncIr7VeNw6StU0GszZxwd4cdW
dbZ79PxSS2PIg63viRlAAZo/AjZdmyX6KujQo0DAbl4sqUv6TCIz+H7EivVPZ+nd
xQPcz4K4WOwUfPXOo41WraetignE4dUuegNpzUmK5Ry86YyT4GXZlUic1/zu6/Eu
dquC69Ma6hJnibrDaiCj
=nWIo
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
