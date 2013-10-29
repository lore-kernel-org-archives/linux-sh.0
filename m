From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 29 Oct 2013 09:43:56 +0000
Subject: Re: [PATCH 03/19] i2c: sh_mobile: Enable the driver on all ARM platforms
Message-Id: <2015733.JNqH7MboLG@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2262444.VxEEmQHS6F"
List-Id: <linux-sh.vger.kernel.org>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383004027-25036-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131029050337.GB2643@katana>
In-Reply-To: <20131029050337.GB2643@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart2262444.VxEEmQHS6F
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Tuesday 29 October 2013 06:03:37 Wolfram Sang wrote:
> On Tue, Oct 29, 2013 at 12:46:51AM +0100, Laurent Pinchart wrote:
> > Renesas ARM platforms are transitioning from single-platform to
> > multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> > driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> > and ARCH_SHMOBILE_MULTI and increase build testing coverage.
> > 
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-i2c@vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> I wonder if those two Kconfig patches couldn't be squashed, but other
> than that:
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thank you. Please feel free to squash the patches together when applying if 
needed.

-- 
Regards,

Laurent Pinchart

--nextPart2262444.VxEEmQHS6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSb4NcAAoJEIkPb2GL7hl1UyAH/28uKvrf5Mt6qVWkpO/jzfDw
SWYHRdiGk6rf5L4aQw1E8wFHCCBXfQJrhidBEmr4BwtJjCfafZypSATQhpoZBmNb
ATxWQB2kzsGDlWR7yri5DDWVfsOUiKo2zHwIsAutVsvxWWKBWWuLKq7eAVctPRAX
uZbejuJC4JIqlEXLTcgUmgvDkVFPZXt1q8WxeNMtoVTkXfAYrN568GrMEa0FGNpx
rgB4TacNzYdChrFamZcYWdcNwn2XNGsNSwPIPnGoSN9IuqWPgVBh+G0uPaMVuPlx
ozIogWsXulK8KaHkjJqXkO6fw2uzCIHNpNdCCeFqFGiTPNc0Um+UBTF7neyWi3M=
=VHgb
-----END PGP SIGNATURE-----

--nextPart2262444.VxEEmQHS6F--

