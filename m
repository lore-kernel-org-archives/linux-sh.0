Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7B523A
	for <linux-sh@vger.kernel.org>; Thu, 11 Apr 2024 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819929; cv=none; b=YpMJSN/C5Osnmz64JqNnruCq0mMU1bx14KNRXv032og5G3DSuE9PKTgIbIxrcMmOUPvbKrFQ90An5lrXHqQi0tOyXdFdID85n3NcMwbHf2ardyqdTcDMyQbu2FQOjytkJ+B/55BOxneExNaIJA/m+o+fDXbNxWgFiA0Q7AdZOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819929; c=relaxed/simple;
	bh=hermbD48WAQog7T1UKecFkk84q4H15xGTOWCn9of5LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h15B43BlD8bVTBIGtNF+qEKym3wArbpT5Tw2vZwVCD7FinNZoK1bBNQDU4l0wmqX64XkpigMqATy7Tq5Pv6jkdT91e6pC1bCP59p/SdbIzYiLPMXdWbT0YG7dihvy1JH7WUPHBu4sDUwgcteMaZ7ltU+YgpkK03mX+j9EupXsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruohf-0006RR-2L; Thu, 11 Apr 2024 09:18:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruoha-00BdsK-6a; Thu, 11 Apr 2024 09:18:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruoha-000PZG-0M;
	Thu, 11 Apr 2024 09:18:30 +0200
Date: Thu, 11 Apr 2024 09:18:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Duoming Zhou <duoming@zju.edu.cn>, linux-sh@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] sh: push-switch: Convert to platform remove callback
 returning void
Message-ID: <fwfwlvyuznwzwejg3iqvnvgolxaqfo3aod5gbydgbwpj5l4xmr@y7fuszpv7kry>
References: <20240306211947.97103-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fupwugdgieizqsvu"
Content-Disposition: inline
In-Reply-To: <20240306211947.97103-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sh@vger.kernel.org


--fupwugdgieizqsvu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[corrected the address of the Pengutronix kernel team in Cc:]

On Wed, Mar 06, 2024 at 10:19:47PM +0100, Uwe Kleine-K=F6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

Apart from Geert's positive review reply I didn't get any feedback on
this patch and it didn't appear in next yet.

As my quest to change the prototype of struct platform_driver::remove
depends on these patches, it would be great if they made it in during
the next merge window.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fupwugdgieizqsvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYXjsUACgkQj4D7WH0S
/k4qAAf/T7b0RcHiZWZXsUFarnZfVBJwf5vfhftNJbAzHvUNOC+4r2ABt+pd43md
9lusIQKMVAiy1Yq6zBobyikl98I0gtQj86fgjX5LlWDpDfJEe6MWoBtk4raEzo6O
Pf74K9RcLncNIRNJcOBhY7QKgj+63FsT2ay7ZFTXKLNkwstuZ7/6AevbonGo9w+V
9KRtC3ovM+DVvcVa/BpEvXahOvo3FSeFlHk2maXdxjOJusvph0kG1/1YzNDHjyDz
MmkKF9QfU/105hGg64tsPGGYmYJjWnd8rqbYYCT9dAZ4LU8BjUBmNVIoM6waXN4z
OBuexQB61n9RUKsErH4N26uKYFF3vg==
=eC12
-----END PGP SIGNATURE-----

--fupwugdgieizqsvu--
