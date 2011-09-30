From: Felipe Balbi <balbi@ti.com>
Date: Fri, 30 Sep 2011 08:17:04 +0000
Subject: Re: [PATCH 2/2] usb: r8a66597-udc: add support for SUDMAC
Message-Id: <20110930081703.GE13825@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vmttodhTwj0NAgWp"
List-Id: <linux-sh.vger.kernel.org>
References: <4E803B16.1090905@renesas.com>
In-Reply-To: <4E803B16.1090905@renesas.com>
To: linux-sh@vger.kernel.org


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 26, 2011 at 05:43:02PM +0900, Yoshihiro Shimoda wrote:
> SH7757 has a USB function with internal DMA controller (SUDMAC).
> This patch supports the SUDMAC. The SUDMAC is incompatible with
> general-purpose DMAC. So, it doesn't use dmaengine.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/usb/gadget/r8a66597-udc.c |  359 +++++++++++++++++++++++++++++++=
++++--
>  drivers/usb/gadget/r8a66597-udc.h |   26 +++-
>  include/linux/usb/r8a66597.h      |   60 ++++++
>  3 files changed, 425 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66=
597-udc.c
> index cd2cd16..4d27cb3 100644
> --- a/drivers/usb/gadget/r8a66597-udc.c
> +++ b/drivers/usb/gadget/r8a66597-udc.c
> @@ -28,13 +28,14 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <linux/dma-mapping.h>
>=20
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>=20
>  #include "r8a66597-udc.h"
>=20
> -#define DRIVER_VERSION	"2009-08-18"
> +#define DRIVER_VERSION	"2011-09-26"
>=20
>  static const char udc_name[] =3D "r8a66597_udc";
>  static const char *r8a66597_ep_name[] =3D {
> @@ -186,6 +187,51 @@ static inline void control_reg_sqclr(struct r8a66597=
 *r8a66597, u16 pipenum)
>  		printk(KERN_ERR "unexpect pipe num(%d)\n", pipenum);
>  }
>=20
> +static void control_reg_sqset(struct r8a66597 *r8a66597, u16 pipenum)
> +{
> +	unsigned long offset;
> +
> +	pipe_stop(r8a66597, pipenum);
> +
> +	if (pipenum =3D=3D 0)
> +		r8a66597_bset(r8a66597, SQSET, DCPCTR);
> +	else if (pipenum < R8A66597_MAX_NUM_PIPE) {
> +		offset =3D get_pipectr_addr(pipenum);
> +		r8a66597_bset(r8a66597, SQSET, offset);
> +	} else
> +		printk(KERN_ERR "unexpect pipe num(%d)\n", pipenum);

according to CodingStyle, if one branch as braces, all of them should
have. Also, try to avoid printk(), I guess you have a *dev here to use
dev_err(). Besides this, I guess it looks fine.

--=20
balbi

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOhXr/AAoJEAv8Txj19kN1YS0H/A2J/QWF5DbUuD+Ikmsm9AP7
13apCxX7RRaqM6ho7ZHN7TSoK9iqsBMU4gnpD/Oj2hVRZjcdvcs0RCBKeWQPVDBH
CLRBURjDu25FLvzYfbnlFOSmekZP8OWoODh2o9/o+n7UjvUddx4UPvEl93ZrnDz8
HTNlcgvK8qCP6FyoT/DUPhCuEvOF5Nq8bi7T8jR46afWbR9Mgcwx6dgfZoYhvQIh
7fqSgmhVR5KSIaOec/krNc8u9ZB9+DFR8+H1JSv8cT+UsoND6c76HueX7Bpzw1op
1v1Z+4NqeFja5IjoKpNOm0ZiZBbbmQXJBVsCwWavjTIBZEyKQgnKaCo4HMlCDRw=
=LP/8
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
