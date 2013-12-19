From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 19 Dec 2013 12:06:47 +0000
Subject: Re: [PATCH V2 5/5] i2c: riic: add driver
Message-Id: <20131219120646.GA2563@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
List-Id: <linux-sh.vger.kernel.org>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1387402321-21866-6-git-send-email-wsa@the-dreams.de>
 <1407973.m5fTNuo5v5@avalon>
In-Reply-To: <1407973.m5fTNuo5v5@avalon>
To: linux-arm-kernel@lists.infradead.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

thanks for the review!


> > +/*
> > + * This i2c core has a lot of interrupts, namely 8. We use their chain=
ing
> > as
> > + * some kind of state machine.
>=20
> I have mixed feelings about this. Wouldn't it be more efficient to have a=
n=20
> internal state machine (which you partially have already, using RIIC_INIT=
_MSG=20
> for instance) instead of relying on enabling/disabling interrupts ? The l=
atter=20
> has a larger overhead.

I am not sure I get you here. I need the interrupts anyhow. For example,
after the last byte has been written to the 1-byte-FIFO in the
transmission_irq, I need to wait for the transmission_end_irq to ensure
the bits are already on the wire before I mark the message completed.

Polling for that condition is more overhead than just enabling the
proper interrupt (one write to ICIER). I don't need to switch ISR since
all the interrupts are seperate and have dedicated ISR.

> > +static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], =
int
> > num)
> > +{
> > +	struct riic_dev *riic =3D i2c_get_adapdata(adap);
> > +	int i, ret;
>=20
> One of my favorite bikeshedding comments is to ask for unsigned int when =
the=20
> variable can't be negative :-)

OK.

> > +	/*
> > +	 * TODO: Implement formula to calculate the timing values depending on
> > +	 * variable parent clock rate and arbitrary bus speed
> > +	 */
> > +	rate =3D clk_get_rate(riic->clk);
> > +	if (rate !=3D 33325000) {
> > +		dev_err(&riic->adapter.dev,
> > +			"invalid parent clk (%lu). Must be 33325000Hz\n", rate);
>=20
> What about a "goto done;" here and below to avoid repeating the=20
> clk_disable_unprepare() call ?

Yeah, can be argued that way. I was fine with both.

>=20
> > +		clk_disable_unprepare(riic->clk);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Changing the order of accessing IICRST and ICE may break things! */
> > +	writeb(ICCR1_IICRST | ICCR1_SOWP, riic->base + RIIC_ICCR1);
> > +	riic_clear_set_bit(riic, 0, ICCR1_ICE, RIIC_ICCR1);
> > +
> > +	switch (spd) {
> > +	case 100000:
> > +		writeb(ICMR1_CKS(3), riic->base + RIIC_ICMR1);
> > +		writeb(ICBRH_SP100K, riic->base + RIIC_ICBRH);
> > +		writeb(ICBRL_SP100K, riic->base + RIIC_ICBRL);
> > +		break;
> > +	case 400000:
> > +		writeb(ICMR1_CKS(1), riic->base + RIIC_ICMR1);
> > +		writeb(ICBRH_SP400K, riic->base + RIIC_ICBRH);
> > +		writeb(ICBRL_SP400K, riic->base + RIIC_ICBRL);
>=20
> Couldn't you compute the ICMR1, ICBRH and ICBRL values at runtime instead=
 ?

As mentioned in the TODO above, this is scheduled for an incremental
update to this driver.

> > +	of_property_read_u32(np, "clock-frequency", &bus_rate);
>=20
> As the property is mandatory, shouldn't you check the return value of thi=
s=20
> function ? Another option would be to make the clock-frequency property=
=20
> optional and use a default value. What do the other I2C bus drivers usual=
ly do=20
> ?

bus_rate is initialized to 0 and if read_u32 fails, it will stay this
way. Then, the call to riic_init_hw() will fail and report the error.

There is no standard behaviour (use sane default or fail) yet. It is
somewhere on the I2C todo list :/

Regards,

   Wolfram


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSsuFWAAoJEBQN5MwUoCm25EkP/jVPDq/FAd09lDLR0c4MkcsN
p6KM6xmL0ol7uywFtP4MEBaXNcCnzN7LUveD7YQbWtJx3e61TM1O0eilH7inPAgd
biPcOGN7+wiGjley9rdA0VcV0/NMn28foAaZFQhLoRXRkz2A3/3B5ACFJj2k8kOt
lgzCldVvSWayEi+lQKHrntItffKohMyDMxEn8/izwoXPylnMahDvt4cpb6q4e2P/
WF8fY2wRFLBJ5Y57m+T/Wuenhkyiz3FM8fQLPvL7bSQEWHsMpqI/DTJyISC5nCuC
R00LWxCxb1QjnGAhA45XY7BEm+T2AqC4gOXXoHblkhFVXNTE1Xkm8ooOvfNrWQ4Z
5RRMGqcDYVk4DysEUTDHeoIiB3lNXUBnFjgKTJT6p6L7orHzsy8I8nd4xmRViQN7
tumKfrl7Y6gSYo2ZLaze4gpfO28l8VLMdfOLuGBUUvkKcDOv6L+Vzu2ycJpBTKKf
QyGOwsi4kYs+kTAJYGBWKZg4ZcYRN+rJZCHD/DK6fsDYgjtPELv4IER33xxJim0u
ZJ0f5n3SvgJyXiYUqmfLlKRsE7SU/8c9JHI0nAR2GmfgVid+7qGE4o16aixwujy+
Sii2Kra9uhLW7fQpVi/zaMCaEat9ZP79ntYzw8qcxYjlNL8oFI2ci6HuH2fxxMpX
WIbeme590TRlWEi0EspS
=fZoX
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
