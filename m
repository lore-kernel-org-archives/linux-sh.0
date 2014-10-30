From: Felipe Balbi <balbi@ti.com>
Date: Thu, 30 Oct 2014 14:10:33 +0000
Subject: Re: [PATCH v3 1/4] usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()
Message-Id: <20141030141033.GI6482@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CNK/L7dwKXQ4Ub8J"
List-Id: <linux-sh.vger.kernel.org>
References: <1414665019-1340-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414665019-1340-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: linux-sh@vger.kernel.org

--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 07:30:16PM +0900, Yoshihiro Shimoda wrote:
> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>=20
> This patch fixes an issue that the NULL pointer dereference happens
> when we uses g_audio driver. Since the g_audio driver will call
> usb_ep_disable() in afunc_set_alt() before it calls usb_ep_enable(),
> the uep->pipe of renesas usbhs driver will be NULL. So, this patch
> adds a condition to avoid the oops.
>=20
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/usb/renesas_usbhs/mod_gadget.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas=
_usbhs/mod_gadget.c
> index 2d17c10..2d0903f 100644
> --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
> @@ -602,6 +602,9 @@ static int usbhsg_ep_disable(struct usb_ep *ep)
>  	struct usbhsg_uep *uep =3D usbhsg_ep_to_uep(ep);
>  	struct usbhs_pipe *pipe =3D usbhsg_uep_to_pipe(uep);
> =20
> +	if (!uep || !uep->pipe)

how can uep ever be NULL ? Look at the definition of usbhsg_ep_to_uep():

	#define usbhsg_ep_to_uep(e)             container_of(e, struct usbhsg_uep,=
 ep)

how can a container_of() ever return NULL ? What you should check if
"ep" (the argument to this function) being NULL.

--=20
balbi

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUUkbZAAoJEIaOsuA1yqREksgP/jVhTLl8OK84eqg0gqX+TOcW
S6K7jp2caMFy+M/nT49JPGjNaeWMv3jTV+dMcGm+29sXonTMP7Gr30cdlDOr/yjC
2lt1/GZ1CijnOkjksi1XrIA++TZfTu9F+/U/5zArJHghNWmlESM9xnvFXD/rDz+l
lS4Xs+HwRL3X6w04C8x9VXhtefGm6dBiiv9z8vRs1rGyCXiSw8SkSeQXCmJRdUe4
n2o0qfbBUk6sW2pDtxeW6XsO023bfgoWyvrWV3fIKwB/O9tBZkigDrYlwvyWZuBU
QaaE8oy//hOZRCMdIpKbdefGNU8EE+j+CVmK4LBDaO+tTsqFRBLeO/OJSD+5nqkd
jNOX3Hq4JADSzc/2jbacSi4MBN2o3EyPsWgCrJ/jhSU9XAU+VabpVf+EXYHierL2
pr+GgtJr43HZTOo4+chlj0OuQp3UyN/8iQ8ANil+dJWEZ08i1/WanaFGJlAiAggK
4WZQgx1Ps98EiSN+UsJ8evnP6xFiWnxl6aKBS1e5DpKDeegvWYOxQ7FgohMHXTNX
zQZ3I6elmJR3pRY3avXw1ovjnU1Ngs8ZHIhgDO1aiTqz7/a/fYDGJGweiHlhmM0P
drbx1j8SFukawdbHM7zEXF76RGEAU67b8lObmFUqpgAok+qyoi/h7rhpfYFHx8vS
dgRoEfnCv5D+yW/VMThZ
=8Bl4
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
