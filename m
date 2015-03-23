From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 23 Mar 2015 09:04:46 +0000
Subject: Re: [PATCH v2 2/4] Documentation: i2c: describe the new slave mode
Message-Id: <20150323090446.GA3743@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
List-Id: <linux-sh.vger.kernel.org>
References: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
 <1427099199-3628-3-git-send-email-wsa@the-dreams.de>
 <20150323084510.GL5664@pengutronix.de>
In-Reply-To: <20150323084510.GL5664-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I don't understand why you want to force a valid pointer here. According
> to my sense of defensive programming I'd say: If the bus driver doesn't
> expect the slave to consume/provide a value, let's pass NULL to notice
> the assumption being wrong. The wording is fine, now.

For me, an OOPS is quite much of a "notice". I assume there will be
non-upstream backends. I am not keen to see devices in the field to OOPS
because the implementation missed a case how to handle the pointer
correctly. Now, the rule of thumb is easy: Always pass the pointer.


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVD9cuAAoJEBQN5MwUoCm22VcQALFPsVf1Hr2uPfhsxBaX9drb
mGwik1ESbsytGeS19KvZw0gcckjznLJFBdjVYVseraCJoubbDmMIuhpEVMvUjfnz
8z0Sk852YMk2nTRXY6quyVNVohTY4ZbWGNa+bVzDwtIfihc93wB+ZhHH2JBRNDYj
Wc8IYpvZoZiIsiB5zrjb2hTZGQoq3oufEZ4cVsSO8w6sPBfxSMQ0fAZSYPq155In
k9S35FXDMEJ0/W00metIXPWpl3pJ4Bt1nYiHI4JCr9Tjz6a7NGKetdh6UC3T1Emg
nRKE+inND53kbvyC75z9qbqUt7GMces8rzveU2uORDbCzWDGOqDesKwugTdt9Lmb
1Hm2om6YbBty1/+sE1lIfHN2Yseb4H3wQFy0Nl7g1dKcmc457EYXgfdY/ec6vKS/
HDwI2Rggbz0zGMHqsgz7FbhDV9sFnQU088XGihmC6nMmJcesztKBNkpnY+7LEfvU
VR2Ycd4xcaGbvrm7sLpUtXX+1hINRxWIvmt12InSfmxjIcLiqhXE2v3pwyYxiW32
C6lCz82La+M1BOMOKYJa9dQ6vI4/O4B8Pzm7oyF/KgSML4dM2+S9YqGqJd9HhTzT
3+pqyaEehOXWtWMLDM3f6oPyFNIB+JJxBWeLwu3klNLVX32RB1pIBat7gRaJ6zFr
usvy/mNHVfDr3OO6aAOv
=SPLx
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
