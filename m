From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 03 Oct 2014 00:13:58 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: switch from scif to scifa
Message-Id: <20141003001358.GA1323@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
List-Id: <linux-sh.vger.kernel.org>
References: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

> Which datasheet you are mentioned about ?
> I checked Lager board datasheet rev0.09 and it said debug interface is SCIF0 and SCIF1.

V0.12D. On Page 22, the headline says "Debug Interface (SCIF0)", true.
However, the wires are named SCIFA0_TXD/RXD. Same for SCIF(A)1. On Page
2, as well. Check Y30 and AA29, they are named SCIFA0/A1.

Kind regards,

   Wolfram


--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULepFAAoJEBQN5MwUoCm2riEP/1znM8NU3ZVWYO0llDjhSCLS
DPkxJAuU3Qk929f58ODltmx4t90dnMM6+NxWfil+6ecd+Mb2Hh01glKQK9/KJAy7
s38pgFL31gS1KCjjnXcBGwG+JbFzam8+ERIcmWodlFUHtXYD5FjUsyUdPd3t6TLY
G7vGIpOydvYSZHqb8qAASo3lVhVKX5zUGPeuacCBD2Y5dR+Lx+CQmCx0HYlD47XW
uyabE9jSk1kubXa40+cBAlLNaF2j+cdO1oJhyDUsfNYMy5NNmFvkzwXAHvsR9c5E
tvDHNN+Xex/tPMafVqnJdz4J7I4H+lCrWTFrEmEFvxHok55/zK8pqKsCixII4o0g
1b9UQ2WKvbGFvO6kPyoN7vGptfoGridLHRFqq8+zy1S81Wc5l9rZ2oE0T3MDdevC
+SCgLiLOEQEaoJtOrmy2l57ZU1HjONXIOvZUgLpQ0FksGeSEa3fQLza4QYWMZ94P
PEuav589FgiyIJAZBBTold5cJ/GNjFe/CJ8Sqycxj5ijQZ7il9r9VDUeR+bsy286
hsWSOQtWvN1Ce/TXjmeyxxIKjndUQEmsv31NauqW3sM2Z4x8uN0L34vf+zkP4NR4
fYMZrOCVcbJ5JSUb60tGx0qvfYu5kIrTMM6P12N0QVh0sueSgjzejqIJEjd9+TTk
7Eg9TJ4u03Tg2PjJBuiM
=cgoM
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
