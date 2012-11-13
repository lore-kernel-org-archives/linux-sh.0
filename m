From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 13 Nov 2012 05:36:53 +0000
Subject: Re: [GIT PULL v3] Renesas ARM-based SoC boards for v3.8 #2
Message-Id: <20121113053651.GB18224@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
List-Id: <linux-sh.vger.kernel.org>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <201211122111.03440.arnd@arndb.de>
In-Reply-To: <201211122111.03440.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2012 at 09:11:03PM +0000, Arnd Bergmann wrote:

> * Always let the person that owns the dependency know that the changes in
>   their tree are also included elsewhere and that things go bad if those
>   changes get rebased after all, or won't make it into the merge window
>   for some reason.

Please never pull anything from me unless there's a signed tag for it,
anything else I won't know about and may be rebased or vanish or
something.

> I have taken Mark on Cc to let him know about the dependency now, and I've
> merged ab6f6d85210c4d0265cf48e9958c04e08595055a (which has only shmobile
> specific ASoC patches) into the next/boards2 branch before merging your
> branch. This is still not perfect because it breaks bisection, but it's
> the best I could do aside from forcing you do do another round-trip.

What's the bisection problem?

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQodxbAAoJELSic+t+oim9wyMQAJGi8h9yoJBgtBEnluZUINfb
XCl4q+tSlNtVZ5MU7PFxygK2qKQGg9rKVLNHhKSBaqRGftS1YjCtXRpt3MNQwiBb
OBr/1r45NqrZRcNokao3iy1vD0XjqSzDKgabF6XDYlRdw/uNtfnIXdMo53c+8rJl
KLMIK7NgZUUSfxAxbCHdsZDvx1C+JZTd4M6peV8vI7GE7da3XFU3hWSQbwVExMlb
y4+cWIg3t4ypNvizdAQHfLrCH2tTlMcDq1zFftd8iNjwwYsJTr1sKH2Yz+IcpeFA
QcWo/up3fT/IttNiTVLc6VwFxWhwsbeH2J4aWMgTvW1qFFduNrkn6zNf36y/6aVX
htFHlsg85f6FrRPpAzOsfkVZ/Jb0OH3NpHDwPw/4m4u9F6oIrJd6HeETNGx6+B2h
mucz5AYHmqJOCHWFbaSirFM0nE2OPs7wlr+qyRhAMP5429kJ7ycQ2yxEedGq94Ex
Ghgn4xPd4Ni76zyF7PXd/+qv1P6c72eymsw6sL+az4RUpiMc8ZGjOEYExeIo0zg4
XIV49+f5ojm8ihW65YzzSYh9dGPGRzYBPCDrJsEGiyK8W5V1TG5LMYhDZcCfk9p1
Wlmw+yu02CQ09YHMoxW//Q14VEUBBokIxQMjtYuEl9HeSIMmS1HDd6o6T502fLEQ
lPiglZ4gsqWHIrmsa6wo
=l8Vi
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
