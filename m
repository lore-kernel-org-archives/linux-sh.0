From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 03 Apr 2016 13:47:40 +0000
Subject: Re: [PATCH v3 09/11] i2c: rcar: revoke START request early
Message-Id: <20160403134740.GA7231@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
List-Id: <linux-sh.vger.kernel.org>
References: <1447948611-2615-10-git-send-email-wsa@the-dreams.de>
 <56FD9080.4090203@cogentembedded.com>
 <20160331224838.GA7381@katana>
 <56FED245.4010503@cogentembedded.com>
 <20160401201415.GA25936@katana>
 <56FEFEC4.6010401@cogentembedded.com>
 <20160402072726.GA1384@katana>
 <56FFC06F.70108@cogentembedded.com>
 <20160403082513.GA1404@katana>
 <57011C30.7020805@cogentembedded.com>
In-Reply-To: <57011C30.7020805@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >>    And I still don't feel good about the patch removing the spinlock -=
- I'm
> >>not sure it's SMP-safe...
> >
> >In what scenario?
>=20
>    I've reviewed the patches once again and it looked like they are safe.

Thanks.


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAR78AAoJEBQN5MwUoCm2I1QQAKsVA7Ox0U5X8VOh+q3ETJux
SoFEUcPoQQ7ODNUKbymn0FjkntGnPnIRdQoCpzJSFoqOSySYKNuGw9aKNE5UioeT
0qwNnpLIOF7iM5ttM9krXCyFjh/9yxaeUGBVDmgZgy2YgUqcVPwNcOPzi/lasY8F
qnmJTUwrfHoiAKh+D91jY2ou9v+bBSERyCNUtzMm3UtlXCvaE15xFQVac2uWLsCE
Hwf+i4lQw/fDzReZTjE6WKucTuu+7yqGBxSQlfqIZ4W30WpJuolMpk4UjaUjaHYX
Wnt8g62+HrrH493R4c7xkYNRiIEVyO12KvNmwc9ISRSXgEF5r/i80aKTTZBiQVh1
u69Z6A9JfG0xxf4BUqqpSaFwGVBqxC6YK2J6Vtz0bYTGXKOvw/SvKVadqnBCPW6q
cbGtQ5HyFmSVN7IwqpxQZ+iaPXOe6PDOTVcdEKqwA9CiMd7BorCJE+sXV0wFQdZc
ctwFa5pUfusguZMdr8sc4eaJuLtCXRV3kJmHn5b3IAXIeJBAGdNL3BS4u53DgbYZ
qVQQ1/5JsMEKj3W6yTx+BvdQa3Vy+xH/7et/1sJ9YAxdx9c3NzjXpW50SRdduXqI
eAVwD4qs9t9n/y0Nbb/psFKH9IW7IyaMP5tB3JZfUCOtOJTNh1Zjxv1D6PM0eCCy
moJdHqv5atwi9bUxZT7N
=V6v+
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
