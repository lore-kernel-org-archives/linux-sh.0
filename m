From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 13 Jun 2013 15:39:15 +0000
Subject: Re: [PATCH v3 1/5] pwm: Add Renesas TPU PWM driver
Message-Id: <2443882.iHzYTamhi6@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1558713.3lfVaIhsMj"
List-Id: <linux-sh.vger.kernel.org>
References: <1370958344-19470-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1370958344-19470-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130612102223.GC30841@mithrandir>
In-Reply-To: <20130612102223.GC30841@mithrandir>
To: Thierry Reding <thierry.reding@gmail.com>, linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>


--nextPart1558713.3lfVaIhsMj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Wednesday 12 June 2013 12:22:24 Thierry Reding wrote:
> On Tue, Jun 11, 2013 at 03:45:40PM +0200, Laurent Pinchart wrote:
> [...]
> 
> > +static struct platform_driver tpu_driver = {
> > +	.probe		= tpu_probe,
> > +	.remove		= tpu_remove,
> > +	.driver		= {
> > +		.name	= "renesas_tpu_pwm",
> 
> You agreed to rename this to "renesas-tpu-pwm" after my review of v2.
> Can you please fix that in the next version. It's the only remaining
> issue: as I said, the other minor quibbles can be fixed up in a
> subsequent patch.

My bad, that slipped through the cracks. I'll submit v4.

-- 
Regards,

Laurent Pinchart

--nextPart1558713.3lfVaIhsMj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQEcBAABAgAGBQJRueejAAoJEIkPb2GL7hl1DfsH/RYYEYqZf/GJLFJpn6NysMVT
rivkUAaXA0QgaUBSik63PTc61peFpnqPfqCq6ceBf7NGK6i0MmzR+fVlyFPaLr1C
16l8l2hrYBVVzxnCMiIAu1mN1t2cAUWvsjjJcVkSbgn7uKcd9p6CUNNl3KbffYEb
C71WM+Ri+EIeK0wdgNoJopxtKsZPvFMQ5agJ6ovwHIrDzxDsekkmH8P0826bUyFl
tk3Nz7/LhFKm78EmHD77zcCdC5a82+BHNiFvfd8Qy8Ukv0VU8936KfrJiRCvGrhl
WqK9T3JhaM5LwO42NWt6iipeamAFMbM3ygH1371JPo/Qaimk6AOlreDjblSL3j4=
=f033
-----END PGP SIGNATURE-----

--nextPart1558713.3lfVaIhsMj--

