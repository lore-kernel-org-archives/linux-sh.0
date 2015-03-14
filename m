From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 14 Mar 2015 11:43:36 +0000
Subject: Re: [RFC 0/4] prototype: switch I2C IP cores at runtime
Message-Id: <20150314114336.GF970@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Zs/RYxT/hKAHzkfQ"
List-Id: <linux-sh.vger.kernel.org>
References: <1418674817-12809-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1418674817-12809-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--Zs/RYxT/hKAHzkfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

finally going back to this topic.

> I'm mostly approaching this from the DT point of view, as DT describes the
> hardware, so the description should reflect the actual hardware topology =
as
> closely as possible.
>=20
> Currently DT describes (let's keep using i2c as an example):
>   - one ore more i2c masters (in .dtsi),
>   - an i2c bus (in .dts), which is a child of one particular i2c master n=
ode,
>   - pinctrl (in .dts) to link the i2c bus to one particular i2c master.
>=20
> Obviously this does not match the hardware, as
>   (1) pinctrl is dynamic, and
>   (2) the i2c bus is not hard-tied to that specific i2c master instance.
>=20
> What does describe the hardware is:
>   - one or more i2c masters (in .dtsi),
>   - pinctrl for the i2c masters (tables/code under drivers/pinctrl/),
>   - an i2c bus (in .dts), defined by actual pin connections,
>   - pinctrl (in .dts) to link the pin connections used by the i2c bus to =
one
>     default i2c master (is this needed?).
> With the above description, switching can be controlled from pinctrl,
> triggered by the user or by availability of drivers and/or QoS.

If I understood correctly, we currently can't describe this in DT this
way. If we wanted to connect a bus to pins, we need to tie it to the pin
names like "GP5_5" for SCL and "GP5_6" to SDA. We don't have those, we
only have the function groups like "iic2" or "i2c2". And even if we had
those, we would need a reverse mapping to check if "GP5_5" can be
configured to this or that I2C core. Or?

> Your "i2c-demux" in DT is actually a description of an i2c bus.
> But instead of linking it to pins, it contains a list of all i2c masters.

Yes, one layer of indirection. The list is (currently) only used to get
the desired pin mapping.

> If I want to add an i2c-gpio master, I'll have to add it to DT. That soun=
ds
> insignificant, but (in theory) all I/O masters could be implemented using=
 GPIO.
> So one day someone may implement an xxx-gpio driver for whatever bus,
> and I think it should be supported out-of-the-box. When using pins, and t=
hus
> describing the i2c bus in a pin-centric way, that will just work.

If my assumption about the reverse mapping above holds true, I don't
think this is worth the hazzle?

Thanks for your feedback!

   Wolfram


--Zs/RYxT/hKAHzkfQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBB7oAAoJEBQN5MwUoCm21PcP/jgJTH9lsG6+rOOIHdA7g30m
cIoNnHiKqP2/pJuHFgIdmFZR9bB9Un8L9/SCB9HbF0g5yjZ07+yLZwL3bsxcs1SN
kPEpV+Qq2CKXY+DdJ7WIFmDkyBPpQqMxUl1A1du6AWZ8iveGkm4stODMjLbRWeND
+Vh5n3rTR5wGwH2+8Ct/vgD13QnrqGls3Vf4a2H3jlMMFjWtwDmAawyY0ONEAIsM
UkxVevMxtNanS3bfrUkFXpYYoEnQ/1OPBZ4g7zdicatWDqCh8aungD/Qbk1YCXP4
x4L7ZcWGHkV5aKUEQO4ax5TBiUq713oQeEGsD6rJXLruc2JVt2rRHa9/D+3FRNy/
eDCpCp9+kXrbT4YPAnIHH/BZQY8GoudZuAuVQCpO2EL9MQvn9Wx5hjdxsMnVeWta
KbATXvREFsSo5atGwl/4c7/H397uKHDlaqqLm4OBnnE3RMMYij4Wr7jzqknN2JiT
PPfFFxl4XnwBbO7E5HZGrO2+YLU3ymHPDANuECeYsfvXk6t2AK6CqrCWI7inj5k/
QcETeKJ84G9aadjsLvliR/mYSH61HZklbFfjPpmCB/5YJnWx2Z/Qa1xcxhPxfRrO
jEDoctrVUCgsJodEhOBpsXcv0IYs4vOiea+AeSmPkl1IQlfVVYdOH69Yiorj9/e3
Rq9gSONBN+gunxE3DuYU
=lYyM
-----END PGP SIGNATURE-----

--Zs/RYxT/hKAHzkfQ--
