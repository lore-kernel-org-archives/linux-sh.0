From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 03 Jul 2015 16:00:22 +0000
Subject: Re: Possible regression due to "tick: broadcast: Prevent livelock from event handler"
Message-Id: <20150703160022.GE19284@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Oiv9uiLrevHtW1RS"
List-Id: <linux-sh.vger.kernel.org>
References: <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
 <alpine.DEB.2.11.1507031640060.3916@nanos>
 <20150703150951.GC19284@katana>
 <alpine.DEB.2.11.1507031721390.3916@nanos>
 <20150703154036.GD19284@katana>
 <alpine.DEB.2.11.1507031746550.3916@nanos>
In-Reply-To: <alpine.DEB.2.11.1507031746550.3916@nanos>
To: linux-arm-kernel@lists.infradead.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Can you try the patch below, whether it makes a difference?

It doesn't. Board locks again.

> -	clockevents_config_and_register(ced, 1, 2, 0xffffffff);
> +	clockevents_config_and_register(ced, 1, 100, 0xffffffff);

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlrGWAAoJEBQN5MwUoCm21o0QAIZ5rOUPImum8F8BV2f937+U
W7W7jsunX+wZS6Dk/ksSlEb+mjOthKSVhHouZYdMhu5sUxCFAQDz6lrCwf2CqXBA
aM2q2PJkO5/yPsNLQK5a/Vhlosww0yIQN1z0+ZkDPzq0OpJuvhJZZK1X/fEXm0zA
j58QNPY0lFAaJ3K3TRVzA7Kn+bOFWMi2accdtmZluurQQhWrwWBfHWYj/7Qtrmfq
CVIdDdqPd/XssuxxE7slL8NmOn80Z5nKq3X7zglQKi/QGFPmgZXrVIU0LPHWoA/E
jCF1WhUiSrRMm2P33mF3fBzYCQvvqqjie5kmNXjWiF44+gNaCqut66abvoouPVLZ
MciQghmZNdl4nJZ3yEwdvX7Na4u2WoCBvLqwZUa87gGx7O3QW+KDkIUc2seP79RF
wKENWGZNo0YsFl2BmSFHCvfpUVLRvZjAcTcWbPQfIfzfzUNt4EU641TkBwuWVM4l
shew26BLGaz1spNF0BadB+f3qDyMmj2+gD1sbFPb7QYr7u2z9e6FMdSslhYFs3yu
sV9zJbDOmloLQDr6fF+a9JlOV2UsBpBc2XMEYbFJmmh+9PCv+y1rh0k+Wn5vBMrP
2Yk/xcZZ2oQHsi8gyFv6ywUavOKU3/njON+Z6djKYw8XU/lYMhnvZbL1azmQINuN
MZfoXpb5N+85VuEapNgA
=w7WN
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
