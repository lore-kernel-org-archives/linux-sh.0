From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 04 Dec 2014 17:50:38 +0000
Subject: Re: [PATCH] i2c: sh_mobile: optimize irq entry
Message-Id: <20141204175038.GB7944@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="kORqDWCi7qDJ0mEj"
List-Id: <linux-sh.vger.kernel.org>
References: <1417710049-6894-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1417710049-6894-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2014 at 05:20:49PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> We can simply pass the pointer to the private structure to the irq
> routine instead of passing the platform device and looking up its
> driver_data.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgJ7uAAoJEBQN5MwUoCm28cgP/0MCcFtu5iv/dq3U9DDKFdob
WXk8ytyGx2DPTdRXuBn+q6nBQuxISX3vFF5gmF25bost10CtDXDiFEnPd3uDo6bw
YcN8hC1Koi3SsiDj/jYMK5QsdC57LELY+B96C3asWpw9v6oj+xMYYhxW6urCCArg
s7+j7Fj4lzQ8/T6g9EVFSjxHs+cMH6JH2USnX1EOV73L/ddgeSz9XABTve7tASA5
eU1NlR6QfXlWCOBjEshYIC0jQD8PTDyqWTQCSN/QU1QYtvyQGrrvBYlOsmBaYknc
vmjKiOj0qS2N9oAB4tvsWGgoxpvgbrnP8+75HbFubqcaD4rQ/W+pq74O6r23aSmZ
Hh3Qbrpq1anOfY4LpWbe/7f3amgmqk84rVIQFwvaMaQjDN5OuYAyCuO7IKwtdcwf
jOe/bSys4svMWuGYcZWl/pn8hCLnS4w+1GpIq7XMgML7ds54/qVKmysHvJfNN9qt
bNC8cYxr/pFTILnp5L8ayY7Y0jWzxheJkIngQmEyoAyZDa5yhxAMHSSW3wk5wQek
4nkedxwm4eRzXm9NG66TKt3vbTqaoqkRmnJ4bTLyaLgiIytjc3JfQbFnsh2CA0sn
iNOa2WVQHzLRH1dXGscqKfg9RTq1lGgIoVK4K02YRgqoNhrD0ih+qIp+H+jBDLD7
V2/10qdaqJeQ46rPbiqE
=XfuF
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
