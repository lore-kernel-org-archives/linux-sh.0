From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 18 Jul 2014 15:45:49 +0000
Subject: Re: [PATCH 1/2] I2C: EMMA Mobile I2C master driver
Message-Id: <20140718154549.GC2731@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JgQwtEuHJzHdouWu"
List-Id: <linux-sh.vger.kernel.org>
References: <1377688911-10911-1-git-send-email-ian.molton@codethink.co.uk>
 <1378226969-18722-1-git-send-email-ian.molton@codethink.co.uk>
 <1378226969-18722-2-git-send-email-ian.molton@codethink.co.uk>
 <20140218173843.GB18768@katana>
 <20140617095724.GJ2638@katana>
In-Reply-To: <20140617095724.GJ2638@katana>
To: Ian Molton <ian.molton@codethink.co.uk>
Cc: magnus.damm@gmail.com, grant.likely@linaro.org, rob.herring@calxeda.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, ben.dooks@codethink.co.uk


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 11:57:24AM +0200, Wolfram Sang wrote:
> On Tue, Feb 18, 2014 at 06:38:43PM +0100, Wolfram Sang wrote:
> > On Tue, Sep 03, 2013 at 05:49:29PM +0100, Ian Molton wrote:
> > > Add a driver for the EMMA mobile I2C block.
> > >=20
> > > The driver supports low and high-speed interrupt driven PIO transfers.
> > >=20
> > > Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> >=20
> > > --- a/drivers/i2c/busses/Kconfig
> > > +++ b/drivers/i2c/busses/Kconfig
> > > @@ -777,6 +777,16 @@ config I2C_RCAR
> > >  	  This driver can also be built as a module.  If so, the module
> > >  	  will be called i2c-rcar.
> > > =20
> > > +config I2C_EM
> > > +	tristate "EMMA Mobile series I2C adapter"
> > > +	depends on I2C && HAVE_CLK
> > > +	help
> > > +	  If you say yes to this option, support will be included for the
> > > +	  I2C interface on the Renesas Electronics EM/EV family of processo=
rs.
> > > +
> > > +	  This driver can also be built as a module.  If so, the module
> > > +	  will be called i2c-em
> > > +
> >=20
> > Please keep it sorted.
>=20
> Ping. Still any interest in this one?

I happen to have access to a kzm9d board meanwhile. Do you have the
board enablement patches still somewhere?


--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTyUEtAAoJEBQN5MwUoCm2tUUP/R5A5+IsddqxMWW3ejsNpDrS
zz96FOKdwp3GU3NaszaY185hXxYGppyvflPXG2xNPtD21D/V1eqnvIUrRdcbTQ0q
fIhngks5NAxoyq6IksfWXGL6dphn17TVa9gieo6a++8lH1h4CAhx5Cmph8PG50zO
Ioy97ORHPHv2qAGlmM/LukaH+ud8F6mtnBeWI2prjtVEPxWL4zRTVx0wJxA+OZMV
R0YwrLdcodYzJyRRVxSsHWMTfPFrL3QPl6xHvQ7/N/bnMcQqld9EfUWYshDo5El9
VzjhZhoh4oB2CN8dRhJ9gV0gqPiYFc7IIUHjK9gj3i+ossG+Uf15aK4F3Z+QnCpD
8S7IZVxttaWWsn1O9ByCzSt5bsp0xFdfFqV0/6DifHKVgF82d72JkanbPEtAXsq1
S8J7prPxqU2zlF446+LA/YFPC+IWQeGKLHkPahAn/sfvbOGcjxk4+ns0678To9gd
Jb/4EtUzxt2ph5knUK/XzJtAWCTW7Jcu5nEwaWuULqbej81Cmol65VhMFE1r/Pyb
twfXKXdOoTXX7AG7oFerKYpw4FrmOigmzEaBWTvus/EA+OjtzySc9vN0N+A2r1I/
ndhxUeoqQyYkJMdrxsMIeXn3hIgYsw3U1JnzsUhYJ+8AWDWPH25MhmbiWFKZacxw
yHgC24JX/RKk6xvDLWbh
=7Rfj
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
