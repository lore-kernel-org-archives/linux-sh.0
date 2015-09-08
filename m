From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 08 Sep 2015 10:53:56 +0000
Subject: Re: [PATCH 0/9] i2c: rcar: tackle race conditions in the driver
Message-Id: <20150908105356.GA15793@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <5464456.UnsMOS3MTx@avalon>
 <20150903204000.GB1574@katana>
 <CANqRtoRo7jemt52=mcmu=mf5dGsqwWKWA5aBYd7L=vFas6d+NQ@mail.gmail.com>
 <20150905073143.GA1616@katana>
 <CANqRtoRs=f=07B=HSLCVg5G4rnhxj6Heod+spYwxHiKFLZqFWg@mail.gmail.com>
In-Reply-To: <CANqRtoRs=f=07B=HSLCVg5G4rnhxj6Heod+spYwxHiKFLZqFWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Yes, now a HD-ready TV is hooked up. It should give you something over
> EDID. Let me know when you're done and I'll move things back.

'No EDID data' says bootlog. Also, all 0 when reading that i2c client
address afterwards. I don't see or sense anything suspicious with the
I2C transfers itself from remote.

And could you maybe install a local TFTP server on your next images? :)


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV7r5EAAoJEBQN5MwUoCm2fFgP/1WlG4AK5SOGWuqdqegmqW0r
1ZdjhNz1NQjQBW1m+fmuUZOa+53ChxfqTQkMVZu9ZY0/cfmmPk/An+FLpBhb78xM
GZrthu8tvdCA5ZrDbN27Y57pgnUGiKWokzZCyPvBtnsQFsTJotU3IvTqGMELWqm6
oSdHq7vYIGUEiSfHUg4p+egamVXolIapKQt8ER+CvXlUAb4BENP7OIcQ9zuNndoO
h+jYGGuh/8DSxDpdLrzpl0j1PzGF5TR/2tJRbzYUrg+TUdMM/mQUBpOeyhB7amSA
LQTNc44Dkz2CeonPWlqX8SOqILzq36Ay3ZaWA3Hg33JJT+B592iCbkGwih9rVudg
zilV8ethcVQmpVS77Z2sGXIZXoHqAOjWpo7E9mFZodS3OGpnfUa/E5ou2DOgVtQG
Opca5AiJhk/NVSp265zKV0vXNTdL9cFq3XDXqYwbzMy5NxUadTD1MHJhn1f76zug
LlrILf2nuAzPdHkzrz3koe9bbM+309PMFZ/5YjfjBP/9Ehi8XuH0sk+aPUH52kGN
K5Ij+BESZop6gd53XV0nl1EhAP+9oC+xjq/LhvykESHsTsT0ik9hKaaZtCm21r7e
a5Lt7pVPp0CG94gXDoL+mnLwK27ZnEFmHklp/XgkhRftKbAIDErnqxp8IMtG3aCK
cxzHdtShCzaowuWnnZF4
=wNn0
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
