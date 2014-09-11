From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 11 Sep 2014 14:54:22 +0000
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Message-Id: <20140911145421.GE5149@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DqhR8hV3EnoxUkKN"
List-Id: <linux-sh.vger.kernel.org>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <20140911141257.GC5149@katana> <20140911144003.GD5149@katana>
 <1591383.Xdy91rktuP@fb07-iapwap2>
In-Reply-To: <1591383.Xdy91rktuP@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2014 at 04:52:22PM +0200, Marc Dietrich wrote:
> Am Donnerstag, 11. September 2014, 16:40:04 schrieb Wolfram Sang:
> > > b) could be seen as a configuration thing since the functionality
> > > backend could be changed at runtime even.
> >=20
> > Come to think of it, not only the functionality, also the address can be
> > changed at runtime. This makes me think it should really not be in DT
> > after all.
>=20
> even worse, there can be multiple masters and slaves changing their role =
on=20
> the fly AFAIK. So the best dt can do is to provide an initial configurati=
on,=20
> so all drivers know where they are and where to start. Everything else ca=
n be=20
> changed during runtime.

Why do you want DT to be involved at all?


--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEbedAAoJEBQN5MwUoCm2SEIP/1y1KCLP9O8HoaQmsSO7FrIA
03eEtT0dQWz1i5+UNR1AXOJrnFsegC2PlSf6Kws+XTmdX3wC1Nd8atxd+nGDRxfE
kzz+h0PDh3JE2jAX/Txytrsje8PVsfTVM0FW8DPG/rpsUZ/gEN+pfqIVl30/OWR8
2z5eC4bLRxvxYsG1PkggD2TvhZYfSGwa9AkaDpyHsUBJLomAoBg+Ec6pAbjFHwxO
95wc1YP03MPydDRZpQ5dGHRt3wkzZJbhra9gG5oBH33na66k6AEWezZKDNcOBy/U
6x0dOrqn457EFM8WMWkma+Yp9OuOt5wMiybBsA2yj1j8CFaCa4u5N56Zd+y3XNpA
5evLhIqNzr/hoU/EMAGbNQ1y6mQuMhkYf5ryDdHSlxKEo8yCCsLWvEo71vFmutjP
0huMZa4b/ZyDqy6rJbfwQ/Nqu1W83qF6Fnhi9czUQUna1mZwwwquHhS9soUt6QDB
NSLEApGp1irvbbiiMyVk25tsBBh7amPqbGV2tREVrbX5SsdvOjSFZfD/1gDaB2Aq
MmxHGI1Lv3m7IG/MdM68pv9gMutfv3bXe5W+xabqXODY6oHQgdMZ5lUjF+6ri5l5
wxg2LIhX7pVzX7kJ5rd9iPNfu6BGRzoZ0zNcfW82QPbfnURtgDArWmkUnBkS8dYp
9nxCgTFi2PTmtRLWJLSV
=+FEn
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
