From: Felipe Balbi <balbi@ti.com>
Date: Fri, 31 Oct 2014 00:48:15 +0000
Subject: Re: [PATCH v3 1/4] usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()
Message-Id: <20141031004815.GB17652@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CdrF4e02JqNVZeln"
List-Id: <linux-sh.vger.kernel.org>
References: <1414665019-1340-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414665019-1340-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: linux-sh@vger.kernel.org

--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 12:06:06AM +0000, yoshihiro shimoda wrote:
> > On Thu, Oct 30, 2014 at 07:30:16PM +0900, Yoshihiro Shimoda wrote:
> > > From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > >
> > > This patch fixes an issue that the NULL pointer dereference happens
> > > when we uses g_audio driver. Since the g_audio driver will call
> > > usb_ep_disable() in afunc_set_alt() before it calls usb_ep_enable(),
> > > the uep->pipe of renesas usbhs driver will be NULL. So, this patch
> > > adds a condition to avoid the oops.
> > >
> > > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Cc: <stable@vger.kernel.org>
> > > ---
> > >  drivers/usb/renesas_usbhs/mod_gadget.c |    3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c
> > > b/drivers/usb/renesas_usbhs/mod_gadget.c
> > > index 2d17c10..2d0903f 100644
> > > --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> > > +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
> > > @@ -602,6 +602,9 @@ static int usbhsg_ep_disable(struct usb_ep *ep)
> > >  	struct usbhsg_uep *uep =3D usbhsg_ep_to_uep(ep);
> > >  	struct usbhs_pipe *pipe =3D usbhsg_uep_to_pipe(uep);
> > >
> > > +	if (!uep || !uep->pipe)
> >=20
> > how can uep ever be NULL ? Look at the definition of
> > usbhsg_ep_to_uep():
> >=20
> > 	#define usbhsg_ep_to_uep(e)             container_of(e, struct usbhsg_=
uep, ep)
> >=20
> > how can a container_of() ever return NULL ? What you should check if
> > "ep" (the argument to this function) being NULL.
>=20
> Thank you for the point.
> Morimoto-san also pointed out this code at v1 patch. But I forgot to fix =
it...
> We can change the "if (!uep || !uep->pipe)" to "if (!pipe)".

alright, I'll wait for a new version. Thank you

--=20
balbi

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUUtxPAAoJEIaOsuA1yqREkjAP/jxerhg6A1M2OWx32unjdjJo
n9aJjgWAfbi5Hohxq4RQTQxbiE3/Q/w2Nk/HZMWbO723fpBAqBSpj8SiWzctTm+s
Qsgv8Tp98OEINEGlB3S2ewGwBhM5YrX9w/AZoFH0xiWlClclyJ3nb7Q6GCvLg6yV
7y3xGuyEaKbrTs02IhW6NqzJ0t4miFPtvjIb/FqUvX+vfd8556yH14LgN/LPYj77
aMi1YlCI0he0Mydu1hD1pkO729zJLRG7aJtlgVlcDy/n1iDK2pTBqHnxRyLOOcAY
KVQzepUIlQ/Iyg5YOmPN8t0b3PZfGaQuINoVmApvfYSIrUPsjBRLjxeiG1/bCt68
lnAqXe+T6uBeU7BkRqcerdVAjn8S4Rv7fAdiCXNh9Jepgao51hft6yYU1JVhEmFl
1+SOiGUID0qKlwjXCkStQo60mlIywzJmUpmuqnwCNCi+jfKFlydHs7pmswmXvSb4
RJHjT2+Oz05vqbaGAk5MgsjIv2HHgMLaqPADkl8Cf5BialhJlk6u4geZuqk+cWjC
sIYbsDsN3RAsuEoDQqhmhqNeWTIpv3j4DY2y8MFkpy1XILKWLuX5/yfdGj7dijVL
n3kvqy9O5IpMz6zQswmejQCLwg3VcUEnNTGo8UjuqLNoMu3ZjeW7WOJ2WJS23oFx
O1ACZhannlAw1opKI5UD
=QXNy
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
