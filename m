From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 25 Apr 2013 11:18:39 +0000
Subject: Re: [PATCH v2 2/4] sh-pfc: sh73a0: Add VCCQ MC0 regulator
Message-Id: <15713760.5A9H5VW8ra@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart18227579.3C2yeeD6u1"
List-Id: <linux-sh.vger.kernel.org>
References: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--nextPart18227579.3C2yeeD6u1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Mark,

On Thursday 25 April 2013 12:07:18 Mark Brown wrote:
> On Thu, Apr 25, 2013 at 12:00:26AM +0200, Laurent Pinchart wrote:
> > As the same register is also used for pin control purposes there is no
> > way to achieve atomic read/write sequences with a separate regulator
> > driver. We thus need to implement the regulator here.
> 
> You could use an MMIO regmap providing the performance isn't critical
> enough for that to cause problems.

Can you share a regmap object between two separate drivers for two separate 
platform devices ?

> But this looks basically OK if we can't do that for some reason.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thank you.

-- 
Regards,

Laurent Pinchart

--nextPart18227579.3C2yeeD6u1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJReREWAAoJEIkPb2GL7hl10ogH+wVLixMjPhmQEA2UdLhKLDGx
1O6qPfvgKiaDxZTg/4ZVJtkDnjGuy+nW/zUnqTBwNL58yvfSwM254JajV3wPevf7
tfVc+X5o3s/4kucn6AGrZi6hkklu9ZXRigUZBcju2ZQhWOYT7rLPB1fYNYLmll2A
r37syEKBlQs2r8yuetpz34ftqGVhk4dDDhLfsX2BfW4Otwp0r94/6i5VgTewex67
FVDhhocLiXJxocjiGgsPxaOyePFARMJ9YxHzpNDSiFPU7ecjY7Wq7ckD8nexbPI/
+g6sbCFj1TI4+TD0RpWkiC+dw724FP6cx8dVrhxue/pIk7E38NnSrPSEC7YHfNo=
=Bq3K
-----END PGP SIGNATURE-----

--nextPart18227579.3C2yeeD6u1--

