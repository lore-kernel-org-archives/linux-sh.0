From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 25 Apr 2013 12:27:32 +0000
Subject: Re: [PATCH v2 2/4] sh-pfc: sh73a0: Add VCCQ MC0 regulator
Message-Id: <1698292.2RjPeMUeES@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1584447.hzGuNzEEzM"
List-Id: <linux-sh.vger.kernel.org>
References: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--nextPart1584447.hzGuNzEEzM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 25 April 2013 13:16:49 Mark Brown wrote:
> On Thu, Apr 25, 2013 at 01:18:39PM +0200, Laurent Pinchart wrote:
> > On Thursday 25 April 2013 12:07:18 Mark Brown wrote:
> > > You could use an MMIO regmap providing the performance isn't critical
> > > enough for that to cause problems.
> > 
> > Can you share a regmap object between two separate drivers for two
> > separate
> > platform devices ?
> 
> Yes, this is commonly done with MFDs for example.

I've had a quick look at the code, the regmap is passed through platform data 
to the subdevices. With such an approach I could even pass the lock down to 
the regulator driver (not that it would be a good idea of course).

I'll push the code as-is for now, but I'll this in mind when migrating the PFC 
driver to regmap.

-- 
Regards,

Laurent Pinchart

--nextPart1584447.hzGuNzEEzM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJReSE8AAoJEIkPb2GL7hl1/ZQIAIr28d1ppTBMm0m2gzmu0ERs
G9UFC0otR01TE2bqQWAznhvP4wjuG5pJH7Ht/PkaV0O9fB7FGI1+yvQ1FOfEOoax
AzY+3uFNP/ky7XtN9iGRE/ReCxE4nGZu7RZ3BGXr8PcE+311BuKJ/trcvkGRPcdA
rqgw7tgajldBJzk6fZd6US+eTFTMsmU/wqyTOdZ2gHXba4j7I3XWByKHDWDJ/o6T
W+XOPM0Qp/Ek0CFQC/+36PBFh4AzVszgHnJae0sDo3JQvTQ8PpsEECdiyLuGnEhv
4TX2EAJi9MW/mHSZ7MX7CBA1NefYNoSM3zDRfoKNLifkkTTmn3K+f6kZnm4/+d8=
=hsME
-----END PGP SIGNATURE-----

--nextPart1584447.hzGuNzEEzM--

