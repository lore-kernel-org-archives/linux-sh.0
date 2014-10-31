From: Felipe Balbi <balbi@ti.com>
Date: Fri, 31 Oct 2014 13:41:38 +0000
Subject: Re: [PATCH v5 1/4] usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()
Message-Id: <20141031134137.GD1273@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8w3uRX/HFJGApMzv"
List-Id: <linux-sh.vger.kernel.org>
References: <1414729211-3276-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414729211-3276-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: linux-sh@vger.kernel.org

--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 01:20:08PM +0900, Yoshihiro Shimoda wrote:
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
> Fixes: 132fcb4608 (usb: gadget: Add Audio Class 2.0 Driver)

since this change is not patching the audio class driver, you can be
fixing that commit. Looking at the history of that file, it seems like
this was always broken since day one of this driver (commit 2f98382dc)
and if that's the case, this should become:

Fixes: 2f98382dc (usb: renesas_usbhs: Add Renesas USBHS Gadget)
Cc: <stable@vger.kernel.org> # v3.0+

> Cc: <stable@vger.kernel.org> # v3.3+
> ---
>  drivers/usb/renesas_usbhs/mod_gadget.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas=
_usbhs/mod_gadget.c
> index 2d17c10..294d43c 100644
> --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
> @@ -602,6 +602,9 @@ static int usbhsg_ep_disable(struct usb_ep *ep)
>  	struct usbhsg_uep *uep =3D usbhsg_ep_to_uep(ep);
>  	struct usbhs_pipe *pipe =3D usbhsg_uep_to_pipe(uep);
> =20
> +	if (!pipe)
> +		return -EINVAL;
> +
>  	usbhsg_pipe_disable(uep);
>  	usbhs_pipe_free(pipe);
> =20
> --=20
> 1.7.9.5
>=20

--=20
balbi

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUU5GRAAoJEIaOsuA1yqREa80QAJvPbqFdXGdcIr9F1XKaek5b
o5Fonex5loGM5uyaEwp+lDvTjX4HeUJ4KAz6NQckWZVkyntenORXfQzHjugMc3hG
D/pB4h6kCe/4ZQ9AJAyBPWke5Q/SvabR4FPCzS9LIU/5EeRJv/9cvkDy62IavLPj
F3Bqk63Izes53CHupGQMrsNXfLxWb5ARh7ZF/1YcPlMdJlBzgGJZ4sfZ8deZ2gXx
6kO77R+PWUgUn8fWdRvXoQIBcJFqkNHTgqfxPk34wVaTitfkXWj/+IrojU0adHZg
3j2V/xBjsnphU9JG9ljkEJRNY7AAY6qT7KVuUy2UWme2UaGwAAgdgAigpGRqRUMU
wIbkgP+4U3Pn2AxWohCPWTCvgow6zLIAzEbhfl7wALfLZVmNWtakrgQH745wtm8u
bGV5MZMMSuaajheVeaYNZFyDvUuoKEq1cMVULG1TPZRKdm3kwpdnptiB5AMNDYup
xMhQQeiHMjATtJa6xfBUrJBduoaMyzFw0yZqEFjhIeY15bISMdVq4YamauKgumss
8SLs7t6X4g1RD4r7cek+yJxzC6WYrs7kUyQ/Db9eTkHTSzPI6AC5lcHtHYnZsnxh
KCh61qTEjZ9e0jg8w2zh8dnjy0Ar657aiqvaQXwI7wsjL1IgpagP4Q3DlgPa+rDz
bVfYJhryW5Qfbx9dtKyp
=C/kq
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
