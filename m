From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 09 Aug 2015 12:15:46 +0000
Subject: Re: [PATCH 10/10] i2c: dt: describe generic bindings
Message-Id: <20150809121545.GA1521@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
 <1439066007-13951-11-git-send-email-wsa@the-dreams.de>
 <55C722A5.4020403@linaro.org>
In-Reply-To: <55C722A5.4020403@linaro.org>
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Thanks for the patch and it looks good to me.

Thanks, I interpret this as an Acked-by :)

> Shouldn't we also update/add other generic optional properties?
> For example,
>=20
>  - i2c-sclk-low-time-ns
>  - i2c-sclk-high-time-ns
>  - etc...

Yes, I will do this as an incremental patch once people are happy with
this start. Review is usually easier if done in small chunks.


--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVx0RxAAoJEBQN5MwUoCm2aPoQAJFJMCOga/E6jGrcakP5F9Sj
jYObq+N7Byi/xjchh7APNI9X/n/QJEH/qAh3ntDAPT+KfoN9Fmcg7QiywiO7LyBK
qJc6mC9N2oJr9LZV5bCWuCyW6T4beYTwZQQKUlvX9p3OQztALK31s/W/KKCp3QmT
P+xTe4um+Izf5z+g7vjJwGyjA90+aDpfx5klzKbQrOyTKRozQij7hzy996idzRrw
UzZcqjxrABcnngu8zL37IcrOJUsx+yO72/Vuef1d/k+GCQMZhiCHMw36eHA/gWin
XJlxs5LFeLAt+ZyiotMM1PcuD7G6VKD7OBXqenjvdi3cPs3M8+/AW1YyCLZf4r1G
K7ZcWJcY0f5MkiAeF3LODVEFNpeMbeG15h8MUqR+sKH9STGYfRXWK/rRxmLv1J8o
e+5OUPjfPgXvnAG+mJNQDmlaXjzAC29X3vaSWMinqe6g6tBn2BEj4xP34/+V0vAj
uF2e4AJ0YDPSSw5TAu47rifPqRbMbF6GuO56HnY3Vv6OhHXgCGEd71gBGmIjeVQ7
/aF9iQwAgfZEh9j9hfl9iOusycmOycwXmUoZinKtqrW1KqAxroMKUR+c3U+17AqX
Qmp5WVd/9jR6W5b4Uy2MpJ3GBhPQoI08jPetZw4/3sBaSLSVpS1JdflHvy9rZ1JN
0bM3FoMMStvwloDtUbnt
=zRKI
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
