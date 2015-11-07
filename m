From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 07 Nov 2015 13:32:45 +0000
Subject: Re: [RFC PATCH 0/3] Add PCIe to r8a7795 & Salvator-X
Message-Id: <20151107133245.GC21726@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="m51xatjYGsM+13rf"
List-Id: <linux-sh.vger.kernel.org>
References: <1446484121-26682-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1446484121-26682-1-git-send-email-phil.edworthy@renesas.com>
To: linux-sh@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2015 at 05:31:36PM +0000, Phil Edworthy wrote:
> These patches are needed to get PCIe working on the Salvator-X board, see
> https://lkml.org/lkml/2015/11/2/445.
>=20
> They depend on the cpg-mssr driver and other patches so are on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
> renesas-drivers-2015-10-27-v4.3-rc7

I agree to Geert's comments; still, for the record, these patches worked
here with my USB3 card, so this series is:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWPf18AAoJEBQN5MwUoCm2mH8P/iA6oTrELN3smE+AV8fDWfzH
HQdNLXJB6IaAEYDipQ4a9ICn3L+sICx7j5QQ8PKZGCc+HCkHgxNRAIHmcXMFOk74
5h3X8lUJgwtwdXDmsYxjGYDYljZ7BatPIASDnGZWcakMKjJwa0OuDU96ZuP4ptmL
8bq9eE2/uXhWJzCBry4mAEvo4j+Z/SX5+l4mwC4uTw579V+qxLpPM+8Sqv5xt2Xf
46Pq5SPbQhPid/WXD+9FxZUovPzToc4h6850mKrf2knHorpcfXddVla7eCx3qg9K
4G2J+VkRaCMMC3/VTPKW8Q/Mf0CWMOSoDtD17ABiGP1Gdd4xFeaNPuato86OyTG4
tCr/QH6mchTLdvs/rLAmMu7qxCVN9XqeRJxxpO8RbjuWgvR0zIYbLXRoDXFQ6RTZ
8FycP6hNevkft5lS0uGY1GSYX600UinjM6EcakM+hRTnaYgWwOKgLpzFhg8qIKsn
YHqh7xkkW8F4hRknaKz9Jpjm2cSmBkx5vmcYKvvMS/hthf3sBreJue9stujuSn+6
j+mclDowAcajZLwXKVeoh+Qr5ZQY8cS0KzVcZZPlOtmeAEFTkuRekZeE8DuLP5w6
FLbBlPMKM4rMBbIg6XcNXm7V8b6+InQMhZWPdgDIvWLAo9fBxCGqHlQBjolan5ym
1Svh6yZAImowddonlZUF
=XZ1w
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
