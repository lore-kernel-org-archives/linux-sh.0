From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 18 Dec 2015 14:04:12 +0000
Subject: Re: [PATCH 2/4] PCI: rcar: Support runtime PM link state L1 handling in pcie-rcar
Message-Id: <20151218140412.GA4595@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
List-Id: <linux-sh.vger.kernel.org>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
 <1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
 <20151217133058.GA20372@katana>
 <PS1PR06MB1180304088ECF5384C497E40F5E10@PS1PR06MB1180.apcprd06.prod.outlook.com>
In-Reply-To: <PS1PR06MB1180304088ECF5384C497E40F5E10@PS1PR06MB1180.apcprd06.prod.outlook.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Since the hardware doesn't support hot plug, I believe this loop will
> always exit very quickly. Unless someone has taken a hammer to the HW
> of course.

I know what you mean. But since readl_poll_timeout() makes it easy, we
should better be safe than sorry.


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWdBJcAAoJEBQN5MwUoCm2P98P/itXIA4IUCuSnXGY2nNkaTjG
BypZWShL5PNzfO/jtGfFWeSDPDfJ6U20H260PBEUZYEbzpjNZZtmGwlGvHrd5Ffg
gqHJpVXM3ItMHiWBXGaTCCOAon+1xtC/0GbhhYoo8KLNvoJDHT+I9R5+dd41aM7B
gimySGQovxXlmReIALpZP6F6MXaMBh9H9RwGRJ631FVxCnT4bCr+GydXCuRy0CIn
pGIyOeWf5OIlbRrXrp6dethnxTfmGhkFuSfL1pcYdyEGJCEoOgtiKyvG9QSCzCuW
t5ND5nXtY4TI2nRhHgjBAxOSH+G3+qxm1MFrYo/whDobQ/46QFItpFvAO27dAWYU
+JnDeKe4OtatcdWIy8EwuwvDaRG8wycVegq0oWhbMiLQz0xpz1+1VRB8XdqVFNZh
KTO7E1sKMYru3ufwzq951UT3uDpIoRwtRq0WWbZsL1JVJ5SYyQLzqLCn3mcAfuTL
5/TmicI5+iVm0gjMr5xF5/3WfP6O1J2K+sNe7gvbO/oEazduBz7vKDONN9Eizyvc
pCeD++OsDvo9neWADs7Z8yZ50QOx7q/VYqxrthTd23Ke4ZGBdQRwKTl13ycyoiRy
2ex4MkqJhSMedGizgQCVcxUbIn/RLvlnj0McqQl/NAuFPTRYnAm2QLk5/YGAlTmI
gTa9zMiHqrE+WgVWCa61
=A05p
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
