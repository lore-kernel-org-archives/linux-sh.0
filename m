From: Mark Brown <broonie@kernel.org>
Date: Wed, 18 Mar 2015 10:51:16 +0000
Subject: Re: [PATCH] spi: sh-msiof: Fix limit maximum word transfer size of FIFO size
Message-Id: <20150318105116.GA2869@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
List-Id: <linux-sh.vger.kernel.org>
References: <1426127476-18456-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <CAMuHMdXmr7QH8jSkyH2q6xCise7ew5YzyAFc6Zb0psHZt3mGrg@mail.gmail.com>
 <CABMQnVK=-okU4L8vCnY15Vpwy9uCoOLzmnOPkpxj4=U6JXzSOg@mail.gmail.com>
 <CAMuHMdWVRCpF72tS7pQc-cwSMTU-mbqJWtjPtjDSe8YNo-dpqw@mail.gmail.com>
 <5508F607.7010104@renesas.com>
In-Reply-To: <5508F607.7010104-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2015 at 12:50:31PM +0900, Nobuhiro Iwamatsu wrote:
> (2015/03/16 16:50), Geert Uytterhoeven wrote:

> I see. I understood about this.
> Sorry, my bad.

> Mark, if you do not apply this patch to your repository, could you ignore this?

OK, I'll drop it.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCVidAAoJECTWi3JdVIfQFXIH/jQGjPPZS1MRk9Qk81DG5FlI
XDVxq+dVWMNSeq7JiGQ/xEYocZEYJiIz9lvjU6u4/JgK1nH/FWP6NT/iUp0zX3uc
fcJRmdU3XD9fJaMnfmK6+8Ofh7yf57AbQan5vv831ZDCqcRkg4aQA92K2pSaRL4p
KU6Kf4dn+PV0OGDSvicXsWmGc+ULUoeDFHFUHtgbBx1qT6mk4xS/hFZQy07vCN6x
GmCqlAwPgHrgX8H/Jhc+05AOv9NX2AOLsZH+8cTOh5ymMSZswRveTM8w5ztqTDQE
cxE5PL97gYxm2JGmQnth1zkNFqeOjnjrhZDjCp5NYtkUAvVJH6L8xSTd3TvavwA=
=4gm/
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
