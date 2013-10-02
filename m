From: Mark Brown <broonie@kernel.org>
Date: Wed, 02 Oct 2013 10:35:14 +0000
Subject: Re: [PATCH 09/10] pwm-backlight: Use an optional power supply
Message-Id: <20131002103514.GB4228@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OwLcNYc0lM97+oe1"
List-Id: <linux-sh.vger.kernel.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-10-git-send-email-treding@nvidia.com>
 <524B17ED.1080806@wwwdotorg.org>
 <20131001205310.GD9201@ulmo.nvidia.com>
 <524B37BF.2090300@wwwdotorg.org>
 <20131001213120.GG9201@ulmo.nvidia.com>
In-Reply-To: <20131001213120.GG9201@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 01, 2013 at 11:31:27PM +0200, Thierry Reding wrote:
> On Tue, Oct 01, 2013 at 02:59:43PM -0600, Stephen Warren wrote:

> > OK, hopefully it (the regulator core) complains about the missing DT
> > property though; I assume you're using regulator_get() not
> > regulator_get_optional(), since the supply really is not optional.

> It doesn't always. There's a pr_warn() in _regulator_get(), but that's
> only for non-DT (since for DT, has_full_constraints is set to true in
> regulator_init_complete()). Actually that would mean that the regulator
> core will complain as long as init isn't complete. But since, like many
> other drivers, pwm-backlight could use deferred probing it's likely to
> end up being probed after init.

So, part of the thing here is that nobody ever bothers actually creating
the supplies even when the device fails to load without them - everyone
is much more keen to complain about needing to do the work than actually
provide the hookup even though it's generally pretty quick and simple to
do so.

That said we probably should still moan, I'll go and do that.

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSS/bfAAoJELSic+t+oim9tR4P/37yy5h4t5uz3CSDqHnHC+au
82G6pkhf0Um4y7jIuX9rZXvca28zjRggqeTgGY6aZe1motZF+Sd7loL493vgbwXX
xZIk62vWPvs8/73JKYm5nlkilya/+iLBQ5aamZ6qoZJVJxgjIADzyDpCQo6eDWbk
Jdrj+6vtpn62AL1E26LBDqdrrb6QhhwYDlJG6hbZCjH08j90/vLvm2SgnQXjXLUM
pzM56HfIDP6y92wOpx8aXCMz1RNA4Iq+nvluhabrxPibb/7JDuV5PGw1hOeIGzLg
Wqf4eyGU3BaflRiU3mfqeJYZeEyrcW//hIvaoB8grF5zSUJMtVSZtWQV60uURqep
+NrvNMb1ues5I17D+hBuLjgD1PA4T1XphkO0rSDZN+tIDTFoTsvdMNDJIR8qLl3y
g9vGPLSi9ZF7TzeBPpt4yjyUo5lXFlSCLHwK/djK3GbdyKPZ92vRwmOGNOdwryTf
ooVENIlNxb8Xnz/5ODcowDtVIlMlZtbRX3UELLknsKVejQn5wxc4O0dD6Zmvq5hZ
Mo5cgvkEXA1H99c5gZpW+1fX3nvQHMBdroYSdUm2hIapqqVMszXmdEYtgwpwRfWX
rGbFKHmFHPeGAXyQTXPmK973alWyhpJxEoVEcgj4uNBrJ8hRUsQY8HAYKcPRU0E8
DCcovqZapyyc8+/F1cGD
=7eyy
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
