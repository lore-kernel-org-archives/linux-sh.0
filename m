From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 17 Jun 2014 09:57:24 +0000
Subject: Re: [PATCH 1/2] I2C: EMMA Mobile I2C master driver
Message-Id: <20140617095724.GJ2638@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="T4IYkFBVPN84tP7K"
List-Id: <linux-sh.vger.kernel.org>
References: <1377688911-10911-1-git-send-email-ian.molton@codethink.co.uk>
 <1378226969-18722-1-git-send-email-ian.molton@codethink.co.uk>
 <1378226969-18722-2-git-send-email-ian.molton@codethink.co.uk>
 <20140218173843.GB18768@katana>
In-Reply-To: <20140218173843.GB18768@katana>
To: Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org


--T4IYkFBVPN84tP7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2014 at 06:38:43PM +0100, Wolfram Sang wrote:
> On Tue, Sep 03, 2013 at 05:49:29PM +0100, Ian Molton wrote:
> > Add a driver for the EMMA mobile I2C block.
> >=20
> > The driver supports low and high-speed interrupt driven PIO transfers.
> >=20
> > Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
>=20
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -777,6 +777,16 @@ config I2C_RCAR
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called i2c-rcar.
> > =20
> > +config I2C_EM
> > +	tristate "EMMA Mobile series I2C adapter"
> > +	depends on I2C && HAVE_CLK
> > +	help
> > +	  If you say yes to this option, support will be included for the
> > +	  I2C interface on the Renesas Electronics EM/EV family of processors.
> > +
> > +	  This driver can also be built as a module.  If so, the module
> > +	  will be called i2c-em
> > +
>=20
> Please keep it sorted.

Ping. Still any interest in this one?


--T4IYkFBVPN84tP7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToBEEAAoJEBQN5MwUoCm2SUwP/1EErRQhPdkB7QcsPQ3yCiI4
SCWyY+LsZVRUOT2VMz+i35TXXMSZM1klfSsf7JFAo1FBjKD+nHT64JKPxnNFPhd+
01om1iaabNQN2tIhI+udayvyqfsKgUhIEiRcZMKCo7NGoGFfBYTxzEXCikehTOLc
yxLJHaaUkAMbQi1AXlfm+4acFmjEUVVroF2PP9gr0JssOQs6umztzOfSlVfc7rix
eQ42Kfrofr9yIfFXqZggqLulzO5gNjlKa/EoKCPU5khz5hIUrEllsF3gKps/gRmC
Cs8ckfm/5cQHHKIcjD7nxZhdGDBjfiTJcRH2dpSybWobYOBxb1fg4G90erlUenV9
ODLCA45Y3+rIhu+8vqA4p1aLCawfpaZsG1245uqL5/DOGez9csGFIzJ3PPpsLl5o
W8WkVMDlro+0/VdshD1LO3zoIrY+63nDsX28+k+wAk5WxOaTiik5heks+jg6wpuP
RWg9sics9yLDxJyIRMZnWuwuFMjJSTfZmuaZ3B8sJv3f26WrdBc3F069l/EJ9VU8
np8G+5p+Pabg0RjOGaf3kzwBQ/k4mvXIbO+Ve9bHh9EmP0bv5GBLNpzR9NPoZ14a
4kMztFutj62aoBvS8+HwkbYsufSAwYyS2iWCKGxug3cU1QoRo0J2fYKDPJ8Kh36v
Ast0lUpdmFSzwZdTV0Ls
=QnXc
-----END PGP SIGNATURE-----

--T4IYkFBVPN84tP7K--
