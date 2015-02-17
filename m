From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Feb 2015 14:01:10 +0000
Subject: Re: [PATCH/RFC 2/2] regulator: da9210: Add optional interrupt support
Message-Id: <20150217140110.GV9110@finisterre.sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AHVSF3we4xtO5oi5"
List-Id: <linux-sh.vger.kernel.org>
References: <1424175072-14643-1-git-send-email-geert+renesas@glider.be>
 <1424175072-14643-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1424175072-14643-2-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Steve Twiss <stwiss.opensource@diasemi.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org


--AHVSF3we4xtO5oi5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 17, 2015 at 01:11:12PM +0100, Geert Uytterhoeven wrote:

>   - Does there exist any regulator notifier event that corresponds to
>     DA9210_E_VMAX?

What does that mean, I might be able to tell you?  I guess it might be
an over voltage event...

> +	error = regmap_read(chip->regmap, DA9210_REG_EVENT_B, &val);
> +	if (error < 0)
> +		goto error_i2c;

...

> +	if (val) {
> +		/* Clear all events */
> +		error = regmap_write(chip->regmap, DA9210_REG_EVENT_B, val);
> +		if (error < 0)
> +			goto error_i2c;
> +
> +		ret = IRQ_HANDLED;
> +	}

It's generally better to only acknowledge unmasked sources for
defensiveness and improved diagnostics.  Not super critical though.

--AHVSF3we4xtO5oi5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU40mlAAoJECTWi3JdVIfQeQsH/0PwI1etk4K6l0kXnY5fkKeH
UwkGpbr7H2G4TA08uBDQVZe3SW982Br/j/s4OqB6oEDkxxcxa6KYjle9hVahvG1G
TWYh1ifMatIgUF92nq5mA/cd8KmWSFhJ7VoOimMSbpe0huLGe2pboHjhHq4i60ZD
ukhWPqGwW96f2JOi3MsY9klnnD0xabrUc06FNp8JlLJ4P9pIzlPjYLiYdIBrZhhp
xtD+PNl3hNqEoU4fTdfaavjesF0tuyLfrBaWfS83wvD5ry6aAd7F9OTG9znj37Td
pEXFhnLgnFTPKHTQjgUDgc/ZoAgYvKTJ917kUK6ONgHPzlcR4r2w63LeqiTnAZw=
=xRtY
-----END PGP SIGNATURE-----

--AHVSF3we4xtO5oi5--
