From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 14 Oct 2015 08:25:49 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable HDMI output for RCar
Message-Id: <20151014082549.GA28435@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
To: linux-sh@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The Koelsch that failed has a much newer U-Boot (b653737dfca2), which
> only enables the MSTP clocks that are really needed, while you and I have
> much older versions (I have b6af5fcc8dfc).

What Laurent saw was a 1 byte shift in the transferreed EDID data. So,
most likely not a MSTP clock related problem ;)


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWHhGMAAoJEBQN5MwUoCm2QZoP/RYIYwro0h2Lk7+j0+tlIdof
rjg9NuvRxR6WE3dusopPq3Ue9xZyJYAxeu88713SvvSLHf5XrJb3HukOJwggUDzs
j1zx2EyCBsgjFyQ9QUJUkq2LUxbFsBI/zlPcaBOfmktkrpeR0mB8BiImkfQf2iN2
H71KV3zw4h8mO1hJkXIIn4usAE25kK4G3ZnW7XbS4hupVrrCQDY7hZKXQ9qGfvMr
s1o64MhP0jqzYf5jSjStvmlTMmWGSsY7OIo+mlNYH4hU1syQ8HQJq/STqLAMgOGY
D8yQyp66rsEX/LiTdMFdvyFSB/WMEMREmjLgxsaqldxcJAAm9ZeIl2HYR8CdtWdl
twMEPpIvf7ygs+bg/ZfE1gx6jwnNXlfiXX8Z1AdyTNzOI24qh/ECSxmOBPdzPztF
7OO/NEKVGefacV/1+3Ozcpg0r74cwbl2reYfRnoO4Dv5oLq4zhsIzFfKh/3x7Y81
p2wBwoo86XBNuaNxKwUyUZzNiReFb6u9D/BobPsvc1xERE9pqaJtFiuJm6SNAHOb
OZfI80HlNyxvkbZ/HLI0NgHCtoWWL+dMfZS34SLxeZo39KBijpzH228YTVZxtqpZ
DVfJd2G6kqwntbJxC3bSChatV8QVjyNK/A885mY58VOtKSbRSBajW1Ad1RmgiCxQ
0IH68GhatbtUBSWvJ0/A
=pZ7x
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
