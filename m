From: Felipe Balbi <balbi@ti.com>
Date: Mon, 13 Feb 2012 12:08:15 +0000
Subject: Re: [PATCH 2/2] usb: fix renesas_usbhs to not schedule in atomic context
Message-Id: <20120213120814.GP6614@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3mUD2hqWbnBptYHy"
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1202092313560.18719@axis700.grange>
 <Pine.LNX.4.64.1202092316180.18719@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1202092316180.18719@axis700.grange>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Paul Mundt <lethal@linux-sh.org>


--3mUD2hqWbnBptYHy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 09, 2012 at 11:17:51PM +0100, Guennadi Liakhovetski wrote:
> @@ -997,7 +991,7 @@ static bool usbhsf_dma_filter(struct dma_chan *chan, =
void *param)
>  	 *
>  	 * usbhs doesn't recognize id =3D 0 as valid DMA
>  	 */
> -	if (0 =3D=3D slave->slave_id)
> +	if (0 =3D=3D slave->simple_slave.slave_id)
>  		return false;
> =20
>  	chan->private =3D slave;
> @@ -1176,8 +1170,8 @@ int usbhs_fifo_probe(struct usbhs_priv *priv)
>  	fifo->port	=3D D0FIFO;
>  	fifo->sel	=3D D0FIFOSEL;
>  	fifo->ctr	=3D D0FIFOCTR;
> -	fifo->tx_slave.slave_id	=3D usbhs_get_dparam(priv, d0_tx_id);
> -	fifo->rx_slave.slave_id	=3D usbhs_get_dparam(priv, d0_rx_id);
> +	fifo->tx_slave.simple_slave.slave_id	=3D usbhs_get_dparam(priv, d0_tx_i=
d);
> +	fifo->rx_slave.simple_slave.slave_id	=3D usbhs_get_dparam(priv, d0_rx_i=
d);

what are these "simple_slave" changes ? They have nothing to do with
$SUBJECT ? In fact, breaks my gadget branch.

How many times does a maintainer have to ask for contributors to keep
changes atomic ? One patch =3D=3D One single, self-contained, change.

--=20
balbi

--3mUD2hqWbnBptYHy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOP0uAAoJEIaOsuA1yqRE/F0P/jQ050wnWxUhMybRCdZGE/33
nwbyxk9Fk2nFmRs6aIwIB3BZMp//XInhfwUtV/6jvcjYOEnhb235ev5ezCoLbpEL
+IvAosBUab6+lS+w4h0YxFheDoFbnWgj+REwEuT5bz662GA+rGRofIA/hE72L1SD
BSUmjqvIaKy8KVvesx1BQvfOy5/gOfoAcxwF6QDX0q/BZvJkopPV+bSPNA2Ra47l
wTeGxj1hT0QZZ36+BKyA0TlMxZ+E8dOMEjahNLFlqBN657QsunbCEnWpOkmVm5rF
xnQgTJ5hbGwbnVcMoZm+XJWSd1F/6uVFrUieKed17DZWmgjSUjyyuXMMP2kZvHLS
ocifuqLJYRL0j5kJhefOrA0aGOmq8FhOHc2x3xbuRP7u3pIy2nHL71xx7cwNqjGG
o7um6KbsP34o9xD57Use3FUEa/KacSHONDak6V+9d4l+m+y5E0XyQ3jfs8uMN8A/
iyrqGvlVUILEV4OjkwVKbKjlbcYmAWOCFZMnXqhc1jrC2aNiVaGxaJaeT3k+hP2V
ZtnuTCb7VLxmECIoeD/Tj2NPnyIjfZmOhMC4WppPoYT9SguCSlS3ckwYlFf09SYu
ZqXWhsblVzWIJa8Tem0ZPqRqio04VqXtB4JLAiZ0Z8ptWlsZ1lFF4IsxdaqlhTlO
FvjLCFZh/8SmGjUuLEtg
=GQMV
-----END PGP SIGNATURE-----

--3mUD2hqWbnBptYHy--
