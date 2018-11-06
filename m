From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Nov 2018 18:26:50 +0000
Subject: Re: [PATCH] sh: Provide prototypes for PCI I/O mapping in asm/io.h
Message-Id: <20181106182650.GI31950@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Az4VpBrmI9+OyhK/"
List-Id: <linux-sh.vger.kernel.org>
References: <20181106175142.27988-1-broonie@kernel.org>
 <CAMuHMdVYK0SwkTDKrU+bfmCiQ2N5qERuGcqoaXzAsn-aPcCW=w@mail.gmail.com>
In-Reply-To: <CAMuHMdVYK0SwkTDKrU+bfmCiQ2N5qERuGcqoaXzAsn-aPcCW=w@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--Az4VpBrmI9+OyhK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2018 at 07:21:41PM +0100, Geert Uytterhoeven wrote:

> > +#include <asm-generic/pci_iomap.h>

> Is this sufficient?

> include/asm-generic/pci_iomap.h provides the dummies if CONFIG_PCI=n and
> CONFIG_GENERIC_PCI_IOMAP=y, while arch/sh/Kconfig selects GENERIC_PCI_IOMAP
> only if PCI is enabled. Hence it's not set in the failing config
> (sh/allyesconfig).

Ah, possibly not - IIRC I minimized the config when testing but I
could've got the GENERIC_PCI_IOMAP=y.

> Probably SH should select GENERIC_PCI_IOMAP unconditionally, like most other
> architectures do (alpha and powerpc select it conditionally, though)?

I'd be surprised if it had a strong reason not to.

--Az4VpBrmI9+OyhK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvh3OkACgkQJNaLcl1U
h9CKVwf+J+aejeLw8Rk9RF3JtSHhUwN5wGi1xkCxKFxGbeH6IXrJ15eb9xKd969o
wlte3j0iKbDuc4Oioq46oNIKr+qh5L01uozQFIqL3o8BdF1K4HiX4B4r5Ob0juxK
qSDjd4X9W7dEgTVbokxy6dtTI8lYUn/kIq8nTWU8OBvBgEZLsUVfRbvaWN7eTABx
nN5NWQTq4Q2qbcltN34JQ3lvUFe95SLmRPYnTo+x6i2c9hikH3Z1T22Orz4/3v36
20THn3Oc879rTMJFAzhJsY/mArNyrVZ00xRKPoLl6chEIpbblx/zQq67q7XF/Zsm
H9LR8dPRUFc7hGNEgxefCTfurtWyMQ==
=2v0p
-----END PGP SIGNATURE-----

--Az4VpBrmI9+OyhK/--
