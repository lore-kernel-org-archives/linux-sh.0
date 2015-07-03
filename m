From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 03 Jul 2015 15:40:36 +0000
Subject: Re: Possible regression due to "tick: broadcast: Prevent livelock from event handler"
Message-Id: <20150703154036.GD19284@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fXStkuK2IQBfcDe+"
List-Id: <linux-sh.vger.kernel.org>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <alpine.DEB.2.11.1507031511180.3916@nanos>
 <20150703133245.GA19284@katana>
 <alpine.DEB.2.11.1507031612410.3916@nanos>
 <20150703143703.GB19284@katana>
 <alpine.DEB.2.11.1507031640060.3916@nanos>
 <20150703150951.GC19284@katana>
 <alpine.DEB.2.11.1507031721390.3916@nanos>
In-Reply-To: <alpine.DEB.2.11.1507031721390.3916@nanos>
To: linux-arm-kernel@lists.infradead.org


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Ok. One more check please. Does nohz=off on the command line fix/hide
> the issue as well?

Yes, it does. It boots to the prompt then.


--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlqzzAAoJEBQN5MwUoCm29SYQAIjfM0iGFIczkVMuDJ6qQHpM
aeDJ8w/W49WFceHbbxQimRTeWU6AmMkAy3EKL+5psTvOiW9UlmhXu2YLVM407Ww0
7WCxcTw7HpB1cY0y/bO5L2bswzkMweHi/f7oafByP0SsYSxD2E40f5RPxV1EgR+7
L8HCw+s0hUM31Qg8aTDnosva2jroQgpwKsyKEYyZj2QI744tS/igBduhWhgL3KTw
NJIhFKUCf3WVF7oGTNiBNiSkJG1BKLKP5JniJPcKB2MDdi3WR40Hj+1JkoFUz2+I
25uML9GvsfNHqlsju83X5cCav0+G+FWXcd37Yq/lvgYOqBRjnNq6T6YCIwiLFYre
HHvco/D9iCp8GS+eKpdiOQjxvnmCWHvfrQLgZxjgYJAysYSlfatexC3py1Txq/kY
8cYVeS02Fg50eb2eaw5KaKf9InbPGghFnO7m2Ts6in1l1UlHlnJV9I76daujR42j
BdTZfPEwDCos3IEDdjAXUveyYuj8Zw0/v9+lK46JcsGF7KlxWlIdYOqbCA1db7zF
9uHSAzKdub/IAO0D0QlD1kFGdv8g3w0fgP1bU6QUDSeQqiEnpJJHQGYtK/YstTXq
JG/zK3kvxn+58dpYpvP/f9OQZBJB1dDiGosfjFCLeLDpHBYP/bMvFxrD5VFK7rJZ
TdOyHUEW8/iSRcJvNuSQ
=5R/z
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--
