From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 17 Dec 2014 18:28:47 +0000
Subject: Re: [PATCH 1/2] i2c: sh_mobile: refactor DMA setup
Message-Id: <20141217182847.GC3981@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YD3LsXFS42OYHhNZ"
List-Id: <linux-sh.vger.kernel.org>
References: <1418733086-26324-1-git-send-email-wsa@the-dreams.de>
 <1418733086-26324-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1418733086-26324-2-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2014 at 01:31:25PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Refactor DMA setup to keep the errno so we can implement better
> deferred probe support in the next step.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkcteAAoJEBQN5MwUoCm2GDIQAKb/OLsoXJauOynOnYMtMqxi
LjNmz5icBtEO55ou3y5FTBERbU4zJyyuhpO2S0QxJZllVe/6Ht0xdfggUrC40axy
ql5bYhbQmFVfCKrVsOUGYumrk3zv0Q2JVIWbRRT2/CG6nq139F208xy7zSsi8nDt
pQ84m+nNG5P5JjO3GfwOfUqfh1HNCldtiBct5urYHhpIqd0xXmH/4Y2UoTgxoqlB
Iu1xQCAEeQaTAibvjURlPDuEG4gWZkP83tJqDR/uENk0lZt5ijvBli5b8jUKXvbd
TK8vrv5sp5o+M3fV04HDViL60JMKwOQxNXNxa4nqh1UJvSGKmfoS+OyKMGzsDn83
QGRMxlLA/vcuPtBzKnLTi7W7y0HW4f9xcPWjH4Q5OgItmCPPkxptgWdiazw705RX
webtMyOzePi6PH3W4buo+9LPp4UL+pJyzowg3m1G4YEB/IXkHiMBSKnMYvClbGGr
wm7R/1vYUS+G+ff7SnG1BaOZWvmzwYkqqd0TO4ATQhFhIYqYCrJF7vFN/1tkQM3x
uglauMXIZQR5cC+7rWaKf0D13biSy3t2IL7E8mJgz0kdlRMbOU2gBughvnkGWo9B
R6cPdTlT0kRMzeDDcooJmfPRXAYoUBRr7CNJuBhjSXPUBC8c+YQEx7oU0v14AICs
yLlIJtGWrGRFCslqKtgR
=hAhU
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
