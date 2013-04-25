From: Mark Brown <broonie@kernel.org>
Date: Thu, 25 Apr 2013 11:07:18 +0000
Subject: Re: [PATCH v2 2/4] sh-pfc: sh73a0: Add VCCQ MC0 regulator
Message-Id: <20130425110718.GS5019@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5UN41tlPsqEEbq75"
List-Id: <linux-sh.vger.kernel.org>
References: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--5UN41tlPsqEEbq75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2013 at 12:00:26AM +0200, Laurent Pinchart wrote:

> As the same register is also used for pin control purposes there is no
> way to achieve atomic read/write sequences with a separate regulator
> driver. We thus need to implement the regulator here.

You could use an MMIO regmap providing the performance isn't critical
enough for that to cause problems.

But this looks basically OK if we can't do that for some reason.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--5UN41tlPsqEEbq75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJReQ5fAAoJELSic+t+oim9j7YP/0f7eILtVUI4e2x3njsxdnZ1
nVlIjYbFHpbnueYHwRAauDz5z2JIiGuUerTBjgCYUs4ZWHFqus0nBNo8dwz2QD89
MRRaZaKzttcLgXPLdEJUP0ugP9YdTvuc2YXTRpyWCjC/u3bSS7JihsK6h/v/t0l0
O7P1qm58gCW9xbwHqEJIdcp6A/7oelydVE2eTcz3eHXbHNpuoGgNG0a7z2C4D8o9
X6wH3KPUZwpwWn4adqfm1+3uIKEmxCX8PpmFUuyPxNNRLn94OWTQLDtnoKIiwbg4
X1l5u5P+edeoRKut8DcCi0u7MVBZIFEt7N+hDiRedjOkwBQXZotOpMHVgXpqh4Fo
c7owDHVmX+i37xcsEda4nDyAlOkNiAEzSDtOJUAzeNzOrXny12iSRcMRPur8c08e
Ub35V8WS6JG2ExJhdOSTxeVF+TOIiiRx4iAhErUXTfJcZLb7YLCvJYruzI3jGW22
M2rJlbFEVhujBCjyVBj7hiiCG6AXha0Yv3wgyfSqPtBMP6dmnJ6AyKV9+TER/EAV
JzVY8A9pySC2DGz/wAxFnYYTZeZs8pVIqBN8WdGFV1arPr13bVEStkg9YgOZQaiP
HbHwW4x1SrulNTvOhOPcjW3Fsv3Pv+dY44vzk1lBqLKDc37JbepMFrRSThjfNXbw
XtNFg6Z5Tc+DBSsEQsiQ
=vJnB
-----END PGP SIGNATURE-----

--5UN41tlPsqEEbq75--
