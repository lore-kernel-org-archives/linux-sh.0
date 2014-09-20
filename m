From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Sep 2014 09:45:10 +0000
Subject: Re: [PATCH v2 3/3] i2c-rcar: make rcar_i2c_irq_recv() *void*
Message-Id: <20140920094510.GJ1612@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BEa57a89OpeoUzGD"
List-Id: <linux-sh.vger.kernel.org>
References: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
 <19871938.mRdZLUD6Mv@wasted.cogentembedded.com>
In-Reply-To: <19871938.mRdZLUD6Mv@wasted.cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2014 at 12:17:34AM +0400, Sergei Shtylyov wrote:
> rcar_i2c_irq_recv() always returns 0, so we can make this function return
> *void* and also remove rcar_i2c_flags_set() invocation in rcar_i2c_irq().
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I prefer to skip this patch to have more similarity between the
send_irq and recv_irq routines.


--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHUymAAoJEBQN5MwUoCm2a6oQAJzKoP7rL106gdXmaiFBXgQJ
OQlV9VstM2lhEZVekNWWDfYXUgNbpR3D4WK+nhxHSCXPQvXtvjx1Y22JNwsVJbI4
zQ57d4uo75gsF7tZcXd4jSCaCo7Rw+6qan8ZmKcryOKfGbhW78T5oClcAyAUtkpw
hgy7dBcu8cF68WG3TtP7Q3034w6zLyRVVbZswRc7xARYQVr4qhm52IvKFZgrZCrc
39zAhSPg0j1xxPZbJfm23DVuLXsmz2Tb7C5sVagdfc6fEGeHPGguqZe8oPdoeDUR
zzapDFkG211YISiXRJlrRDrj9+sLqAKQbVwmOlkHOXWuaBmGmfzI/dk555kSJDOG
aMS1vw3+5ABaEHNTPc6HOrMp+cHa6GsZjfSPTKRD3lfTHspMPihdMSkvQSb++2fR
Sg7xM/m06kE3ZgRN2E+jTotPEGOBznbGDVYvosOF8/t7UuCmVL++pEykrNaXb/8M
HUzGXuMK1MgtpCsq66ZKli8Ep1UasycSy6mQaktcTal/yztOVFL/mTtXQiwjn/QX
ubJ90PQ5Qzv1LRttIYPhHnEjvlsh4OT4y/fE/7Hr6vzWKamv4QCr1jH9qc+Kj8Yn
x/1UEqCVuZ0d7GMz6ODCXjDdNfdGqmsll5PWOENODjq0bi1nOmdATqJ/tgnplg21
z6JZbT+puZqe1XX2Zs1/
=OQZo
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
