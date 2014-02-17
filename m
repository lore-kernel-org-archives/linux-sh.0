From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 17 Feb 2014 09:19:00 +0000
Subject: Re: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
Message-Id: <20140217091900.GD2633@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3Pql8miugIZX0722"
List-Id: <linux-sh.vger.kernel.org>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
 <CAMuHMdW8MLknykkfu9XS5CDpuJcRNyPz+GV5bhUNGndxFacnQw@mail.gmail.com>
In-Reply-To: <CAMuHMdW8MLknykkfu9XS5CDpuJcRNyPz+GV5bhUNGndxFacnQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I think the tricky part is when a driver for "renesas,i2c-r8a7790" is updated
> with a new feature for r8a7790, which doesn't necessarily exist in r8a7791.
> Then the compatible entry above will cause breakage.

If the driver is updated in that way, then it MUST introduce an r8a7791
compatible entry and make sure the new feature is only used on r8a7790.
Otherwise it is a bug. If this is adhered, we won't have a breakage
because the specific entry (here r8a7791) always comes first. Or?


--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTAdQEAAoJEBQN5MwUoCm2inQQAKPAf/ZOehERrp3k9klzMdKS
3TfVjm6akOQ55VXdq8Un4cCauBK+6U5y33wiK9E1B45SQ5FT1KNE72fas93skrAf
grhhNMVLavqwjCZGL0HpcZVgPvbtfwXE/qQw8GD58RZUi6baHWZnJC1Y3MVnKV1B
mSNPbv8j53IUGUopP3fx7aJdrJfo/BuV83jgUa4r8P+lBkJedWO2CTLkyo72N+1B
KQicq3X0JVUtm9ucWoZaM8A3Wo8IFEd6+fIx6rXo2KTayqS8dOe+DDP2e/ngfjBR
higg6JlCaq3vPgAEpzLxI4KsZ+Ai4InNcZzIyuZLhOmOSy9iXOsgbmg3wgToIhuk
7JaJobCM5V1EVk6GUfKeNg53J/Y4+1CgrGovXKKmYppvkEM/K2orClPevfHfLz3i
JNnuylTvKO6fLC+9iUOQbDEHyw2ZfrR8Pqa2No7FsvR+rJMf4eRfqBrH/5FsQy6k
3d+ymLq2SdNKlESJWKfne4HHOMvYX/2B7af6mrt4UhSnU55ggLm8bTlUPlWnjpwZ
BGESkp43S5Q5ZLAAUj0Ed5IHjExLXU82RaKX1+GaT6Yk+ck9ORLnV1cVmfPusvsr
FJVt/oYt0CiBrM7GIUMohHVcfs3GUC3PSQT2npXpUfxfnzY7d9IqI5sr95+Xq7XS
rSia99pebejlwg8400bA
=LLiB
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
