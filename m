From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 29 Oct 2015 19:23:14 +0000
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Message-Id: <20151029192314.GD8992@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="veXX9dWIonWZEC6h"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <36149610.Eic43bQLgJ@avalon>
 <20151023121439.GK13380@katana>
 <3725918.YSMPQz70Zm@avalon>
In-Reply-To: <3725918.YSMPQz70Zm@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Laurent,

> RTPORC7791SEB00010S
> KOELSCH SN.057
>=20
> I'm not sure if that tells anything about the board revision.

Can you try this patch I just sent out?

"i2c: rcar: make sure clocks are on when doing hw init"

We know that Koelsch boards have different bootloaders leaving the
clocks in different states. What you see could be the result of a
disabled clock.


--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWMnIiAAoJEBQN5MwUoCm2WIIP/235pQyuj/HWFETG+kB9z6lx
+d6Rz83ezgT4a5VV1Wbgm8n9nSxSB2lCVz2GnOnjvhB95dX4P+NRYAD9QjeLvEsx
YJiTCmMBEoMgT5lf2qxswSMKcrrf/4jN3Q7zqwZrNkgHGnciKaYIkW+x35HGBygm
AIUDh4xJjm16jcvxKhKgnnlAYQevx6A4iYyWTzv1iamXAk+2bDc5EKku1yIRjxn9
3hLRAlCqOOj3dFa6VliSyQbVJFRDC0dt5qIkh2vCaHJdJ57ElC6ifE8vZiAVEyWV
NBrzxjgWQusxJ9PoNlHXE+rIRaNkEoJzXB0zmgRcX8FaFuLBeASViz8XYRGT6S/t
s+ly4y0jRAkNkxLJg43DUYDnuo/LMHPlx6EqKtB4ixkhJvVqp/aEFE+iZyBu5Qqe
Aqjqxj9lLyB1LVTT3v6MbzalbXZmw36ID+SY38IIYgTzX4WmKs+PfyomMOrWOMYK
QU5LhpTt8tPB2Ffniq1YNBCgQmQol8bHJWGk2x4CM2ugSW58kkr+DI8JVa79cO9M
01anquxxVcw0I3ij8iWbTCFNw8GwJ3ZKBhA1IfTgKP9g9NTalyG4tPihyK32Sm3F
RE6KV9QZU3u+FbZ96+jQMGk+ci11pOrjmx5EzFASKLi4qxDzaE0WuRcvmEqztL5c
MKQXZJ8LgVbaQa/PiOM/
=L2NW
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
