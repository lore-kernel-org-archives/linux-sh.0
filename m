From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 17 Nov 2015 07:00:53 +0000
Subject: Re: [PATCH v2 05/10] i2c: rcar: refactor setup of a msg
Message-Id: <20151117070053.GA952@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
 <1447338715-9955-6-git-send-email-wsa@the-dreams.de>
 <2420286.JI0i0lloO0@avalon>
In-Reply-To: <2420286.JI0i0lloO0@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

> Sorry for bringing bad news, but as with v1, this patch breaks ADV7511=20
> detection on my Koelsch board. Reverting it on top of the series fixes th=
e=20
> problem.

In v1, patch 5/9 was breaking. I hope in v2, it is 6/10 and not 5/10 as
you replied to (patch 1/10 is the new one)? This bug is strange enough,
but 5/10 breaking would be extremly crazy.

> You'll find the dmesg and trace logs with your debugging patch applied=20
> attached to this e-mail in two versions, one with the whole series applie=
d (-
> bad) and one with this patch additionally reverted on top of the series (-
> good).

Thanks for doing this. I'll think about it some more, but it may be that
I am running out of ideas without being able to connect a scope. Would
it be possible to exchange our Koelsch and Lager boards for a while? Or
is your multimedia work Koelsch dependant?

Thanks,

   Wolfram


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWStClAAoJEBQN5MwUoCm2cnEP/2sK6kl6m1emqXVKunzAlLmY
vg3hO4znNd8h4zcVAVRz1w38WD4E1ujjwvkMamVI0Z8VitJWYeT9MoFs5XFfzjZa
PJ7sSRb6DWO32qETv6IV/aSzgzqzJI9WTrpMFCQqirEvkFES3Sate2ULpqMzp6PM
0cm0TTTNrQD6pzotuFd1EUVSdGZfVmQARJ6irtQJ5qzqVkZR/VzlcGtK/aldHrtX
rbPRdQlyLbdhguaw4wIuUHoHeTK137nLEvSNJ8N09S9boOYfbOGof9Yez8uYCn78
8hRYaVSSKwhNVilG/tAsMIqrQ5A5XLdLfKYZzlYQMS1Fzo+WEHRcWq5sh+y+pAYA
vYZBZyFEI84fqQeS307IBm7WZc3N1xo8sBauFQt3bHBVmLehKE0Yzo4k/5pIbAKY
atQ38j+F6DUr+eKTH4bM8qHbAAUy3kxeL2EauD4RW/rNokJQf45ms9D20D2E3bRW
dO50jAcd6sRVY7Xyb84jko2BaDe2lPeG2uB3+at2UOVQ2tZ6MFPV1vAx9Wcx8hS2
lBOhbqwOMvwcEAn0wRpO1AB4QCGOjq6zoXEYdL+pSvqbPJPKrGvQWScu87iCWoln
V2uao23C1Nr+nUE7AgUsqYH8S+XSP8avnV8WSBEs45DLu9Ai/xcICHA41odCcvJ1
HiBbw/2Tkdfoe9iU+vgw
=Iat5
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
