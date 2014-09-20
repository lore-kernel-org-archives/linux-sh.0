From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Sep 2014 09:59:47 +0000
Subject: Re: [PATCH] i2c-rcar: check for no IRQ in rcar_i2c_irq()
Message-Id: <20140920095947.GL1612@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9/GiYV45wF7IL3Iq"
List-Id: <linux-sh.vger.kernel.org>
References: <3921243.2t7X6eKC2i@wasted.cogentembedded.com>
In-Reply-To: <3921243.2t7X6eKC2i-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--9/GiYV45wF7IL3Iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2014 at 12:20:19AM +0400, Sergei Shtylyov wrote:
> Check if the ICMSR register (masked with the ICMIER register) evaluates t=
o 0  in
> the driver's interrupt handler and return IRQ_NONE in that case, like man=
y other
> drivers do.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20

Applied to for-next, thanks!


--9/GiYV45wF7IL3Iq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHVATAAoJEBQN5MwUoCm2ZukP/jFhNWP79fnNy2gm6Ax9AtIz
k12hCAa7EvbCDE2i2oRZIxx1M4seEv9Ihp6n6kIKWMHz6yDJSTSY+wFT1HIxSn3i
WhShRFAsL6Ic5ZQpju60sspR4CIMnp1zEAYS5SeYyMuu+65J/w8hpMC8IHpABmMh
XOqfVOaN6c1mWkZez0AthT3GMdxe438oTtii7uMPAL2yGIHOkfmTXjQThwtK5Y7o
I/Hv8LTspfxZ/UtXZdlpXFU2X5lGnh/VQQUALwnkHlPQZwuvhHDPWKU3YYkzL2us
vmq8E0AIXogP3mwakd5Bgn4+v3GfChzgL91lawgq/xIClgwyd7M35luKvzFZgodK
VY5EiX0d0lX6W+WcGm/RELls3agN/h42L9SarWVvnVVcd6PyhfRAp7ngHDcS0QYE
xIAQ68wxMRDEyQIKMLwIBeqFj8Hxxt75NsQ0inkosgxY64FKe3qNSZmy6O/c5s4j
gXxgOJyD5kGvYl0AdQ6RXuu7qWYQt4xUc4skc0Y0GekS4AYTWnd6odeHkHaRJpd9
j1apfZCPxda3ZFXmR6NbFZkSeWEp6cvoyJYqMr7HzOKVX4u3wGv/+vQ+bwptf4m2
hbaFvwf40fyGkB9my3ZlENLFSgVVWzF0VJIzf1senBC3S/Lk+0BIhpBz6vwVA8A6
mVZm+x8GstaSAbVHeU5M
=rLJ+
-----END PGP SIGNATURE-----

--9/GiYV45wF7IL3Iq--
