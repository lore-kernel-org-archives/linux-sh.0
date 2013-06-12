From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 12 Jun 2013 10:22:24 +0000
Subject: Re: [PATCH v3 1/5] pwm: Add Renesas TPU PWM driver
Message-Id: <20130612102223.GC30841@mithrandir>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sHrvAb52M6C8blB9"
List-Id: <linux-sh.vger.kernel.org>
References: <1370958344-19470-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1370958344-19470-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1370958344-19470-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2013 at 03:45:40PM +0200, Laurent Pinchart wrote:
[...]
> +static struct platform_driver tpu_driver = {
> +	.probe		= tpu_probe,
> +	.remove		= tpu_remove,
> +	.driver		= {
> +		.name	= "renesas_tpu_pwm",

You agreed to rename this to "renesas-tpu-pwm" after my review of v2.
Can you please fix that in the next version. It's the only remaining
issue: as I said, the other minor quibbles can be fixed up in a
subsequent patch.

Thierry

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuEvfAAoJEN0jrNd/PrOhW7wP/24moo3K7aqpOmXtEFmheHMw
3sF8RW0wnZqoqr3sxrYYfazVN5152yiecFwR32IGkaJaEklfNqMlsumtEdxZX/Ee
0kQE5EtdIGUOsk5piaRXN8UpDNmrcxDCUcavSAfETp17X1T74ZGa2XwaY1GFpXTd
iexnOAbyqoE+G8yeTo0z2VUUYrSVeOAujs2SMyV2739Ua6lBtcbozpYuFje6cfIU
Vi2uk15YphvJ8Tjg3THKREB1w5Bj8zwLb80ODNvDfcOVp0+QAuBkjUDVXmrqkXl9
okTH9M1cJ71E+mJ5hKwDdhCIGoYQ0bQ2vq01wG0DbLX0K3gqxZQ2gVDSIe30ojqg
tN+eYhrDqkl77TNM9gtnQL9vvP5NF9GqnAkrtZI9G2ZnldVfqHGwxNYVh8NuBZ6l
PwlDLQWkNCpVkIBReXQkkDUhOKKRALxdSI4F/Ja7kXFdaR+dIYWBPikja0y52ni7
Be7ja487HbuWApFFusqT2LWtQpCewtAJP6FdtfhERx4PArwuFTvdBn5HbIXG07kI
96gYtoQRkTEw+YuIDUHnBvssf6nJ0Kd5l573MZIU/badZGSVfJXTsZAJKv+9M2t2
IDZtySrY61ZwjEnbI5ezpfILzXU7vMnCS+qGazK159vijjfm6BA9f2a2VFGp2ZBb
MDz7azahSduOdI9XHpMu
=agby
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
