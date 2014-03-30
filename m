From: Mark Brown <broonie@kernel.org>
Date: Sun, 30 Mar 2014 22:24:33 +0000
Subject: Re: [PATCH] ASoC: rsnd: fix src clock prepare/unprepare
Message-Id: <20140330222433.GJ2269@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JKvC8Wn6JllzUPdT"
List-Id: <linux-sh.vger.kernel.org>
References: <1396018997-12390-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140329101043.GF21628@sirena.org.uk>
 <53381DE2.9050907@codethink.co.uk>
In-Reply-To: <53381DE2.9050907@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk


--JKvC8Wn6JllzUPdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 30, 2014 at 02:36:34PM +0100, Ben Dooks wrote:
> On 29/03/14 10:10, Mark Brown wrote:
> >> sound/soc/sh/rcar/scu.c | 4 ++--

> It was against your current development branch which is
> what we having been testing against (due to the large number
> of commits in the rcar area)

It would be easier to tell what you are talking about if you were to
quote some context from what you are replying to...  I'm guessing this
is the file that doesn't exist, the above path not present in linux-next
so I don't know what you mean by my "current development branch".  Are
you *sure* you're not using Linus' tree?

--JKvC8Wn6JllzUPdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOJmZAAoJELSic+t+oim9Br8P/3XCyDb0zIfePrBtt40UolQU
g9nUaoJBnnyexxG30L0k1A9WXppCX6SjwzR7Vj7cD40jyQi7WyZ7BdretzoeAgB/
ykBg+74Pr3y/+LgyevpwagsHoki5LVMywy86Do7wX/dqYyK7BxS6QVxI+/mWQP/7
q/poGqiHPvSv49RQCyQ04VAS2HXEBguw5pD7Ib2+zGYbj9KyaYKdhSIBc0ugKZf6
hrovx+IKCvLMKSuxkSM1XuAdWG5hPWivabcSpDdW4GKNbHJPrTOELpfxXZx9kh3/
trwvk6wpZBp8FVCKoNN6GqUldUjQDiF1Q29YproKPv2b6VnWCLtJQB33VmKerZGi
LxKqaTGyp0a3cNcziy8cL+9CLB3DSY5ttl1lHiENMVSeBOWGGkH3vaxd1jtiKfKV
s4HunmtxOnW7e3PpS7MhCfXcWN3tpYdXDkmZ4TjQHbMpPcdH10dm7gMSm95RaM4f
wsLdvYVCaUwP2ogLV/ywx7L2Az999t3Ly2GmD3kI0mVyncyOCEzVcG5tGXycV7uE
dRCQiJHxIeUX1TweeoMAJEs2tDVgl1Csu+y5GkGCw6FvqxI9fct5LmJCpDAvuYdq
kgCNluDgaVRlLAlebOwGkUNH3V9B7P/kP3wWZX71KoLkT4o5S/oehHt8oPRkeMF+
TsX4uPEGHBgAoRH7B/eX
=lmWo
-----END PGP SIGNATURE-----

--JKvC8Wn6JllzUPdT--
