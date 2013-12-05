From: Mark Brown <broonie@kernel.org>
Date: Thu, 05 Dec 2013 00:09:28 +0000
Subject: Re: [PATCH 1/2] regulator: gpio-regulator: Add required regulator-type property
Message-Id: <20131205000928.GI29268@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LWVQOr/QoF/fPPTS"
List-Id: <linux-sh.vger.kernel.org>
References: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385653493-9952-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385653493-9952-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org


--LWVQOr/QoF/fPPTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 04:44:52PM +0100, Laurent Pinchart wrote:
> The gpio-regulator driver requires the regulator-type property to be
> present. Document it as required in the DT bindings.

It does?  That seems needless.  It should just default to voltage and
provide a way override to current, though frankly I'd be astonished to
see a GPIO controlled current regulator at all so I'm not sure I'd even
bother writing the code for that until someone needs it.  As it is this
will most likely just be noise in the DT files and wasted cycles parsing
the property.

Please CC maintainers...

--LWVQOr/QoF/fPPTS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSn8Q1AAoJELSic+t+oim9sAEP/3brra8hpJDMVRmc6VT9yh9n
KXD9IsLt9wYuRGa3xFy6tJ3lQgBRUQwV90GQNOjVQJIaxuiNJJl9RiWsOw+JjPbo
tcJqcuNT1KZeJc5eq+7SOljJeXW3INDVaJqLjStOw2Z2tFJGDBvDQ8ljYSlz7KwR
0pbXEXlpSuut/mB+gIBJn5tbc/bAtZsWfJOOTUAD4zoPGWdPUJbGGvz8D3SO/zeu
99iX06b5vLnb3glHUPr1mgtbGRWK3vD0nBRzDhwi3+A/B+ikK4QrCSgAR88stigw
PGSAkg4SEHt5hq2cxzYuToRS/Fhza0XbMY02Dpz59ASmUDRtQaB5WxcG1EHpGp9Y
b3zfvHDym1anCNC9IzcYiBebcFLMcpsC4hr1l2NV8394Lrm7omQflL4fmPFRzN7F
rbHl3O86MzW4MTEX+G0ojOcTRzaQhDpVsLoviXRAD3nCw6ka5vGlO++5FRDij5mJ
l/IlGfUNg8gB2PPsK/fLeMbCq4+7OXwH5chf44PV8garBiFutghebiJ5/DlAoVhJ
SF13MmOobeHdEURsyeTRrFHHcb9Hp2sNvv8ajSe09YHWDS0fSKc2z2G4DFUCQT28
QPQYlQVbXZGLbf5VBU3qSXPo6Q8DzI1SnP4vzDsHsBng9+x7MbEN6HGBDwF1VLtB
i+ZjKJZZhvis5MVd6aSO
=tNJ+
-----END PGP SIGNATURE-----

--LWVQOr/QoF/fPPTS--
