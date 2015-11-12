From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 12 Nov 2015 15:52:36 +0000
Subject: Re: [PATCH v2 04/10] i2c: rcar: remove spinlock
Message-Id: <20151112155235.GA11070@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
 <1447338715-9955-5-git-send-email-wsa@the-dreams.de>
 <5644AA7B.6090802@cogentembedded.com>
In-Reply-To: <5644AA7B.6090802@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2015 at 06:04:27PM +0300, Sergei Shtylyov wrote:
> Hello.
>=20
> On 11/12/2015 5:31 PM, Wolfram Sang wrote:
>=20
> >From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> >After making sure to reinit the HW and clear interrupts in the timeout
> >case, we know that interrupts are always disabled in the sections
> >protected by the spinlock.
>=20
>    What about SMP? Spinlocks are mostly necessary for the SMP support, th=
eir
> tole isn't limited to disabling interrupts...

We have per-adapter locks in the core. Once a transfer is started, you
can't access the adapter unless the transfer is finished. But then, all
interrupts are off again.


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRLXDAAoJEBQN5MwUoCm2rNYP/0ofl+0WTTl0ZBlpiRmSopKY
6g0RYZnhsGTfHa9uGgdLwZicp4za9bwkai8KnirHOJUOFpLSuUQ7kcf0Tv6YJB9g
6Vvav47Awn2KXfhIazCK+2RktKdzd/4gqrGVUTXmwKOdQYG7mz5HKvowtuOQAf7m
TQ2YG9aEfnhyHkZzGgfewpPuFVtbrnxISlWQLIQWGTmT0TdvcpJXyDQZH/3lHs/3
xgfS9P8dYwxs1mwONbTRoKorgnJ5aZCiioBlq7LJNC2RJJufrS7junXYF4Vu2gbg
uvUKVciqsa+kBgWBsHE7vVd45YGW1scb99d8c26InMhpltDsG5g8E89AI0yqrHNx
gqfRyd9Mkz3EgY7Sk7SWR9hqTt+ZouPEXt0sJsJ7mluIfNT4lM5SnFnQu7OFkwTQ
QUsNnCSoxXittZRG+QLaRgHmHDkPPkAfzqQS5M7YSKPvx2I1HZPw0gZHqWIl2Ef4
ZxRZ2hrWmdmlsbXGIuBu16Ww6lJFhkXFW/UpOqqi6Nf/eR/xmtzaP6aOp6AaOed8
xj6ThlNyMBKYAZ5CFqP+4aykwLX+vzr1kqM/LBQxnThHZTUwKtFZqc65VVz2AnxY
5HS2cvzZCIX9wULdnDp1WdP3wWLPxnc7b7cY1rsUuMuH6/Y6LRcs1UmWyn3eZFLs
0l9IebLruTSCGuiW2GqX
=ZaKk
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
