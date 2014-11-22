From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 22 Nov 2014 18:14:06 +0000
Subject: Re: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
Message-Id: <20141122181406.GC9698@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="kVXhAStRUZ/+rrGn"
List-Id: <linux-sh.vger.kernel.org>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <20141121071941.GK27002@pengutronix.de>
 <20141121141624.GT27002@pengutronix.de>
In-Reply-To: <20141121141624.GT27002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Uwe,

please don't quote so much :)

> > > +	case I2C_SLAVE_REQ_READ_END:
> > > +		eeprom->buffer_idx++;
> > You don't check here for buffer_idx >= ARRAY_SIZE(buffer)?
> > Ditto in the I2C_SLAVE_REQ_WRITE_END case.
> I just noticed that buffer_idx is an u8, so it overflows at 255+1. So
> the probe routine should error out if size is bigger than 256.

But size is currently fixed to 256, so all is fine. Yes, if we extend it
for bigger sizes, all that stuff needs to be taken care of, right.


--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcNJuAAoJEBQN5MwUoCm2l7EQAIB38Q14ZNJIzPFRjLjTjRWb
1dS4pDjOsI55HYaWMUUr1kfYbWhwk2mW1i/mF97E8E9ruPxERwY7APlQzsM/UlVu
Z5ILUhK/cDPa6qKW79vt+gi8R9Td28uKQyrbjbFq8BOL3JdlO49WGLPzxQj21mw9
05smfM45pf7FYo0MTERH1RDdE8BqRzyW0KICQYShg/qEDayXF7gzRkvuOiSvcxSI
T+ra5NraDRSkg4Dn0COHDoL1LjLLnI8iIgLshmDXRHpqkBWQdOW8qr0+iOU0XU64
FtGdH8kwXBOQQyCZetK1DkpI9MToMkuWiZJdh+xvSNZE4vun0k7pqzsE5tP+xCjS
ltWzK7cfG/RWkYGnT/D91NoiO+kh2aqb06sdXruPdWdZm38g8MoyT/EtYZtcSrl5
2y6QoK7YzfliRDdasZyHe8m9M93ge8Zto5e4M7+7ob6y+wu0GpCa0sQOr+NT9Og+
8hQRSyjInUdP1HmurP6NfCk00MGakTxcAZ7YnomyOhCCxzXc2yvi4PUz8QBf45F0
SRH3y1B30axKYK5XGr0evan2fljuohfwZDNGY0oZMtLT2JE5l3b/W4xfQDZXe3wT
HEFi8zXcNiKnGIYrpm78JmOnmdVvhTfSgAmYYnCUDi/RmmifHpFzzPsXNWzg5pjR
kIzQQVD/CQeus7UlxXRN
=dsv6
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
