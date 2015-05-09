From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 09 May 2015 06:50:30 +0000
Subject: Re: [RFC] i2c-tools: i2ctransfer: add new tool
Message-Id: <20150509065030.GA1511@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
List-Id: <linux-sh.vger.kernel.org>
References: <1425053816-19804-1-git-send-email-wsa@the-dreams.de>
 <20150507220812.3776bb83@endymion.delvare>
 <20150508105401.223a8598@endymion.delvare>
 <20150508143826.GA1513@katana>
 <20150508234042.26708f86@endymion.delvare>
In-Reply-To: <20150508234042.26708f86@endymion.delvare>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> If you think it's not enough, then the address modifier could go
> separately before or after the address byte, i.e. either r1@0x123t or
> r1@t0x123. I suspect that the latter should be easier to implement.

In deed, I would aim for maximum flexibility (i.e. possible to mix 7 and
10 bit addresses), and implement the latter proposal of yours.

> > Handling R/W as "just another" flag made this option extremly simple.
> > But we probably can work something out.
>=20
> I think the proposal above makes more sense than grouping it with the
> direction letter (r or w)

I agree.


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVTa42AAoJEBQN5MwUoCm2xjEP/2tZmxvYmoXaU3hE/m5lSWar
cGoXPUHmxC1w5d61ASFylYLhbgF/6UPRDvMDo2C3pzUTA2NrYjFJRuoqQ8N9XoWl
KRNOapP2pf0byuG6FYacrRhxpCAs7TeCBJIGrTGZNfARzU5JDTu4zMriYes8DBMg
gbH5UbcWvARSgWCXQ4auMw1QyIIR3UiBZvXX5pj0PnRF6vIEN027PwAByHsp/E7r
49g+chtq3jwX7je//Qb9sDqal0JxXMOdzEwTNIV8iYXBHd0qcwodUNIdzNHTmdjH
yhdoCYj+XdBdLcWCstG2qG+cUGqtosrMqL/Ntrg1bzbQH8L8evNptBuodHey6BkR
91uuJZPDhX1gMpOng+KycivxVbUV9PxA4EoZmnRAQPkrXaHWA0ggCC2cMWoky89h
bYzXLvT3cGUddE1rZTxKTB5ORTvpM3/ab9vNOWFLlTs7H+gxBblNz/zYkLc4tZQv
7ozmGlLxIoYe2iI12kK7RJuOhDYAcatyZWSVhomUc6xoR3Aw62Wi2ZDU0n8C5l6B
jCvbUycOeJzNXP+tdZEOtJk6LBsm9f5LhcdSwFy6+uwoa3WqZhZeDCUp4HHEc8Mt
9aOuO5S4bWrzXWIipS6JjqmCAM7TgQ21civbnyvx+U+gslm8SM9W4RlwuMc7ezqe
1EHoutsKa0GTZKPkhQcK
=NJUc
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
