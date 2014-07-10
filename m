From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 10 Jul 2014 09:40:24 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Lager: Correct I2C bus for VDD MPU regulator
Message-Id: <20140710094024.GA2728@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
List-Id: <linux-sh.vger.kernel.org>
References: <53B5F327.5040301@renesas.com>
In-Reply-To: <53B5F327.5040301@renesas.com>
To: linux-sh@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Wolfram, can you give us your opinion about this patch? Does it
> improve our I2C software support on Lager?

Yes, it does. Khiem-san is right, IIC3 is dedicated to DVFS, so it
should be activated. From that point of view:

Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>

However, I sadly missed commit e489c2a9bc82713167d9f721ca764f4b0d37e543
("ARM: shmobile: lager: enable i2c devices") which enables i2c cores for
all busses. I do like the iic cores better because of SMBUS_QUICK
support and DMA capability (although not yet supported). i2c cores have
slave support as an advantage, yet they can be switched in when that is
actually needed (still needs to be implemented, too). So, it might make
sense to switch all busses to iic, I'd say.

All the best,

   Wolfram


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTvl+IAAoJEBQN5MwUoCm2eFoP/1Y9g/YFZpvWZwp7nvevA5Lk
Yx4gWzhlxNIxMooP8R+Qst8jcSQYuXbWTFVM3CFvIvB0Ygqyqy4rLmL46oQyPkkJ
nOcrRiBEWxw9fgg0fj54iRa0XYHSxw4fYI+PwQjl7s3G2nZKV3lB88jhhVOhp0vY
vpgv9l17a1A/8LfbD+UTsq0OuMrmQs3JOiWgnxjr5uDRDkmxnClHZWrfF4I34GBW
8d3OQXi0BVqvh/PxISNMvVCEppI9Ix4nyFvjhD5oae00ajDELdXaCgD16I8kQKAc
GpP17M7wABEQyqZB9SWcM6h0rv/AtTln+8961IO4vD3s0vTqr0q2kvT3vSF1QrrG
GA1PgTHvPhMVcHsY2sqbH2tIwfDtZCvbBbY/eWL16ait7bB/hCeG5qWJfEa8hCG8
dkwlJ89UetuQfx9Qbg2pD6nl9uW7cwkqzXbe3mGW8bH2QnnMxZLKPV3AFUVDc/D1
Wsb0bx8l6Yiexua+ZY9GVBM0tPBISchQfklN+PCscG3TytAFoeL3cjUQVQ+m4woD
4mXXdkV95oAVbFrvayEktSDL59+sOx70JXrzCIdnLHMQGjCX43EcDNqfoFIou2eO
8nXPjFmHXFDVsXBYcvJO1K1rvtS7lnA2AGDNlqbaNem5bo95BGuOMEbMa6+oZvCl
1DzrJL3pKWmIB1Sqs71z
=NR47
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
