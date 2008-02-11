From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 11 Feb 2008 00:22:28 +0000
Subject: Re: [PATCH 1/2] SH/Dreamcast - joystick (Control pad)
Message-Id: <200802101922.29214.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2103449.OKDcMVanvp"
List-Id: <linux-sh.vger.kernel.org>
References: <1202684222.6237.9.camel@localhost.localdomain>
In-Reply-To: <1202684222.6237.9.camel@localhost.localdomain>
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: dtor@insightbb.com, Paul Mundt <lethal@users.sourceforge.net>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

--nextPart2103449.OKDcMVanvp
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 10 February 2008, Adrian McMenamin wrote:
> +static int dc_pad_connect(struct maple_device *mdev)
> +{
> + ...
> +		if (data&(1<<i) && abs_bit[i] >=3D 0)

could use a few spaces in that first expression

> +/* allow the controller to be used */
> +static int probe_maple_controller(struct device *dev)
> +{
> +	struct maple_device *mdev =3D to_maple_dev(dev);
> +	struct maple_driver *mdrv =3D to_maple_driver(dev->driver);
> +	int error;
> +
> +	error =3D dc_pad_connect(mdev);
> +	if (error)
> +		return error;
> +
> +	mdev->driver =3D mdrv;
> +
> +	return 0;
> +}
> +
> +static struct maple_driver dc_pad_driver =3D {
> +	.function =3D	MAPLE_FUNC_CONTROLLER,
> +	.connect =3D	dc_pad_connect,
> +	.disconnect =3D	dc_pad_disconnect,
> +	.drv =3D {
> +		.name =3D "Dreamcast_controller",
> +		.probe =3D probe_maple_controller,
> +	},
> +};

no remove function ?  looks like the probe() forces a connect, but there's =
no=20
remove() to force a disconnect ...
=2Dmike

--nextPart2103449.OKDcMVanvp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQIVAwUAR6+VRUFjO5/oN/WBAQLOeg//Tarw44Hdf34CQrXXsR7vzJMA66OM0ogY
avICwv0wKr83ApHy8RcE7w82YjXz7iAnrdsB+PstbrusjYIHbN2HMoaF4jFOE66K
A2RlgqxnKUvTMopzmap3YaK9PSdZ3esEVAoc5FOAUrrqjccLfDO7JLQfKRc5/zs5
acCpYjs2PvsU09kNH9kUuxGJ2R7MkWbeU9jZNf3lFAtyoLTZKsJsixcMH5cEuCYE
9sFG/arsxkTrj+GgrSVqe17NIF/3kLv5NW/EvH63fBB8HnCgeU7jLyXfWDwJvgz/
CvwCEUqmYNK2Vdv1/z5PlbrOSdagCHhYRA63Gdm2wRc8rA1atbHrzBm+n3GI5yvw
GVoAonFjkUTlxNhOoU744Kf4sRWVcgnDz/vXwCYg2NDZBdvWdpnv8iw9SlSinMTN
j85kL0rZ6skDHWtCXTw4EmLMvDh9VFFwOpG2D47ig9/MPHZvogDKnPyIIbdJ5JIr
KM06ck7bioLnYs8TWVtKZVG3BqtCOHkBt2jN7iDXOhJIDWfiPZ321FPBJGLNdVBF
/IzAc2McKOMnwD2S8vX+RSjEfUbiTYTDyqNghM/X4Ez5ABOsUdV+GQtGAibBS4OO
IkqNTIGCow6gU8pxN/pOvjTvza+bA3+KjQBf6kVTMKfu4dg0u66CGRKWX/dxDMhj
4WKygzW+Or0=
=7wSH
-----END PGP SIGNATURE-----

--nextPart2103449.OKDcMVanvp--
