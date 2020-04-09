From: Mark Brown <broonie@kernel.org>
Date: Thu, 09 Apr 2020 10:53:46 +0000
Subject: Re: [PATCH v2 07/10] clk: Allow the common clk framework to be selectable
Message-Id: <20200409105346.GC5399@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8X7/QrJGcKSMr1RN"
List-Id: <linux-sh.vger.kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org>
 <20200409064416.83340-8-sboyd@kernel.org>
In-Reply-To: <20200409064416.83340-8-sboyd@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, linux-m68k@lists.linux-m68k.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org, Guan Xuetao <gxt@pku.edu.cn>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 08, 2020 at 11:44:13PM -0700, Stephen Boyd wrote:
> Enable build testing and configuration control of the common clk
> framework so that more code coverage and testing can be done on the
> common clk framework across various architectures. This also nicely
> removes the requirement that architectures must select the framework
> when they don't use it in architecture code.

Reviwed-by: Mark Brown <broonie@kernel.org>

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6O/rkACgkQJNaLcl1U
h9C8bAf/SJkvvbTRmpOunw3fAHei1NkJ2RUZ/Ax5l+NwzvC+fSezjkGHKH+2LVOV
6vTimPH4EKoGc/4RRBVRSrlp20QY/mz4/7+/Ojsrfp9KsWdcH167Zd26sYP3kSy2
8jxnHBccoWJ8B9p9YVYslrMb0+y1mjnfLOsBioILN1wa6R2vuv7/JXuu1FmaeYLl
geaZWL7Aw8Knj421ywLqEbg57Zd7M/2ei5gI/plDWIS+UoeuPPPhsUCVkza76DOE
pyvpA21x2ceFOmCTq0O5O2a/WlM8xwfklNLML6wx3NSS02WWiqnAbMS3sZ9Adk50
k7m1LMdfWu/q1CQwp58kVOsZJVWZ4g==
=+bDI
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
