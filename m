From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 12 Nov 2014 16:43:28 +0000
Subject: Re: [PATCH v2 0/6] ARM: shmobile: Change to using clock-indices
Message-Id: <20141112164328.GH4031@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Enx9fNJ0XV5HaWRu"
List-Id: <linux-sh.vger.kernel.org>
References: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Turquette <mturquette@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2014 at 07:49:33PM +0100, Geert Uytterhoeven wrote:
> 	Hi Mike, Simon, Magnus,
>=20
> This patch series finalizes the conversion from the vendor-specific
> "renesas,clock-indices" to the generic "clock-indices", started by Ben Do=
oks.
>=20
> The patches for r8a7790 and r8a7791 were extracted from a patch that Ben =
sent
> before ("[PATCH 2/3] renesas: change to using clock-indices"), but it was=
 never
> split/updated.

Cool!

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUY44vAAoJEBQN5MwUoCm2IQkQAKBdz//mkB6I0lSOHitBnkLq
0eMOm96nlcV2wf/69p30ugJOgqzuLHHkkpWM/rptRLKETtgIk1GCjaQj7UXmjZVV
kU2WEQpW6ZuRI89pjmBEZo0ruAqHbhWDPMg+6Fg+F62r+GIQsDoXajqzC88ZsGzg
9buTyLjlipstPprz88Bkd/LhFC7rVNbCYTihByXKkSDDNk3I7n7MA2CC5SQM8GzJ
0pIE6383lLLJ+ZfKiwHSn+LRqvximwICTD/Vtw8QNXmaaACQI4J/iWBmZ2a3zTa7
auv+5CZ29oi5SWcAYq76/OJPdRMXTjMkXmmAJUdqaT9PIEXt01ZyKYvVwY7ZxtH3
YY3Yt7iMgdVlSAqwVQz9oOEk5ziBYvH5Kq+VZ/5ux7em+CSfELF79t5lXH9HgLCY
C6TX0Z2EsreXSzuz5dBTD29AyUYsYoKBUr8vfxxVDDsJ4vNixEHyA9rTf4BSs7yK
0jmd46ee81HoDYjgEBVx0jLnELhNQPgNd7IUBKvv+gUuweZkpDU4X8FZKbx3HH+Y
gqcy+QDuPkouNATP6eSbisghvrpPBUSKF4gTZR33O63JGryaARmg6vhKr4g33V2k
9RljTqvrEkipF0KC/n8Lbqb6wzqy4Ltx+jwcuh3pbL6emAW5vzFgNQI4ULF71Ohy
jVl+5PkxICwkVT7I1C3X
=uws5
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
