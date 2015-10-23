From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 23 Oct 2015 12:28:35 +0000
Subject: Re: [RFC v2 4/5] ARM: shmobile: r8a7790: let rst module allow watchdog resets if desired
Message-Id: <20151023122835.GM13380@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yklP1rR72f9kjNtc"
List-Id: <linux-sh.vger.kernel.org>
References: <1444632876-2672-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1444632876-2672-5-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +#if defined(CONFIG_WATCHDOG)
> > +	void __iomem *p =3D ioremap_nocache(WDTRSTCR, 4);
> > +	BUG_ON(!p);
> > +	iowrite32(0xa55a0000, p);
> > +	iounmap(p);
> > +#endif
>=20
> That's a bit of a hack. We should aim at removing code from mach-shmobile=
, not=20
> adding new code :-) Furthermore it will cause issues with virtualization =
as=20
> hypervisors commonly map memory based on DT, the above code will thus gen=
erate=20
> a write access to an unmapped piece of memory as there's no corresponding=
 DT=20
> node.

I know. As I said in the cover letter (hint! ;)) it only works for me with
UP on Lager. These arch patches are only to be able to test the driver.
Totally not to be upstreamed.

> Time for a reset driver it seems ;-)

Can of worms for Gen2...

Let's hope it will be easier on Gen3 and we can submit the main driver
upstream this way.


--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKifyAAoJEBQN5MwUoCm2PTwP/AnNDzxYgj1yeYccfEkIxH7J
cyZ9XRKZ6pfekvQtLaU3CDz4bzGSQ7HFMiizl95GuvOQjyEOCkvVI7Y4OC+o7B3C
D3B0+l89RJ/aq8kJf/ZWVdGhR0797Q3ZKZiHU5x5qzAE4cc0hqFJ47c1+iwhesh3
ipKZ+QRFYjxyODF1Vl2fGe95djMiKuxWYNR+8rfQ1sNMAom4yqWgG5fIGIOQsWSI
gQjCg5+XvHxtxRnMxN+1S/rYxoyNQuE6bZa1tOp5W1le/0wZYyjkeHV56a/WYNWW
oIoq0+X/c7lQVftxfEl+mwlCm5pyslN2N6QE/lvKz6tWnaV9U0cK4IK2NOuWWm1i
hERffqEFfR6ZeRc9EpWW8IoMTqlCep/YvaA5Lkl7yblyCd5jj4DbU+XYULzrF+RW
1IMEjRJXu+21jbQLs1F0s9rzrMl5y6Vj9gAAqM7VOgxUyNFgsC3F34iFH36GTezb
o3vaAWgF1DsdV4YyWk6EUDQp2TtA5PQO6qjkwGCT8IbCt7kOqXYY3WyvFM0pz5RQ
an2ITpiCl07YYL+nugay91HMQLtAuVq/971mxQuipCfZDP4UvHm+NX20K6GtKtSk
gSmUCnRd0iQjlldpDHL+K65R63NOzNmlpqUQCl0LuhlxqDvOAUsVy9O+hgpVvzH9
VqiQx2z20+uKB5LoA88j
=x0kZ
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
