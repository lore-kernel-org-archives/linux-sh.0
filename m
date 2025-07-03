Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298902F2705;
	Thu,  3 Jul 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566879; cv=none; b=JvUrKuFNrSC4iX2NxNcIcDQVRpD+6Cp9dAaT7N+sGZfIgXSON6X2D0fGOLRAz1YyS1c8WlHL6ayjJHL9PJYpmhwAFg5PALDFAuDECiXg90GTuLYhnl3P6bQ1VuIedCbzjjsIuIIUt+EwSAv5BveD9SOe9U17FdBFLQ13fjWcTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566879; c=relaxed/simple;
	bh=BRfL2TOlEvi6pyY9teEBUUixQwvNjrah6DozVzUrims=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RmairYsSoimgvzAWEUz0QJ9O8JjsrnnfomG/sO4tHFInY53uJi2WN0VBoTa/LP9Cr8qmln4j6xolZHgdWMtt8/Y3dGG9nTxiyTee9sccMokfAGoJIfGZo4rFAWgbcl5Kwi4LChxis3w9wRR3d5HsF4h2fnfBDV1h+qxit+N46i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=KGcLeWik; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="KGcLeWik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1751566875;
	bh=BRfL2TOlEvi6pyY9teEBUUixQwvNjrah6DozVzUrims=;
	h=Date:From:Cc:Subject:From;
	b=KGcLeWikW8A1oI6CQXXbdC3x5cs5PerEHmfc24KQ9SzrlpJ6xmPDwiC3UAyr0rIhv
	 luJeYWGiLEOoT9Z4D57CiJTAK7cKk0zH/eokCHP+4PRYlUkaZLvldk5kG4fqW/RsN6
	 xbP1aTOyBCKZuOt7mg0UT9Cqiy7gbHejVBOn/By2PoKBDkMrTrqlaqE/l0ApasE1XQ
	 2OTs8Md4LuMp8GkCOlYmdySEnrqCNi555wA+/3pKmRb7qBg2Gn/5EFKoX4wjztXp5v
	 VqbGISurlEMk0uafeIm4ARBRWGPHvC1josYmy6ItvTeVS2R0QLh9FgpzWQ3xUbLB6o
	 dmCuc0oDzShbA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id F14CE6B2;
	Thu,  3 Jul 2025 20:21:14 +0200 (CEST)
Date: Thu, 3 Jul 2025 20:21:14 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] SH: pci-sh7780: fix "for a while" typo
Message-ID: <7dtq2gt7vellawns5uqak3j22fzubp5n4qqpo75bzofdpgalsi@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="midcd5sg5rny2et5"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--midcd5sg5rny2et5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnr=
ufop6tch@tarta.nabijaczleweli.xyz/t/#u

 arch/sh/drivers/pci/pci-sh7780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7=
780.c
index 9a624a6ee354..f41d6939a3d9 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -153,7 +153,7 @@ static irqreturn_t sh7780_pci_serr_irq(int irq, void *d=
ev_id)
 	/* Deassert SERR */
 	__raw_writel(SH4_PCIINTM_SDIM, hose->reg_base + SH4_PCIINTM);
=20
-	/* Back off the IRQ for awhile */
+	/* Back off the IRQ for a while */
 	disable_irq_nosync(irq);
 	hose->serr_timer.expires =3D jiffies + HZ;
 	add_timer(&hose->serr_timer);
--=20
2.39.5

--midcd5sg5rny2et5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmhmyhoACgkQvP0LAY0m
WPHhjQ//aNPSeoMHM2y4omDzecqKl6AjM5PSZDUwBzjPb4hjv6Kj/0zr3dBjS4Tg
+FHtf3v8jFJ+sCK1/H56jRXkhUofzMSn41O7398fT22OV15htd+zw/K2pazxf0YU
fMNHmf3S2SiWKaIvyo0rw7VEEiDBhdjVlM+gxzhqCk5Sw8JEs//S1yipR4J6DvNC
D9V83n9915c1kmL/AiGFxMcWmXixGStPSI44nHzloSwvdIjDlX+Ly6UHSECQZsVs
CxVW8iDnJZjF+qUce9qffZVCM2D53JKlvB6pdrD6GLItgG0R0J2wQAmyNGTt1vjc
0++6OLcVGMi77IsF89QNUMLDh5pv8zCmx9h8PlQqofp4XhUWpzwh5odxeYUkxaxp
kp17DmJaJCSilcBk/BSv3XsCHEFqpd5/Ol3hQpKT3lDTyptaNb2uehF/m0W4vai3
L31hu1tCI/DQ8EDuHSMZ0SPD+t7jh8NYCMWUHmLWEO29fH1xAs3FqCrgJXsyB++S
PqibSX6wttFaRkQgus6vTk0PDI7al0u/JZBkbekWMte5PHpg11cUN4/X/0S8G+Za
Gxu6Ey7j3xoenAjvCF6tg72aiyv9JKlZYm0h29fMbUiiX46oig87fm3LFUez4/qt
rVSWaCNEaC55BQJiNmDueilZ+jJUNrnnrXbkSOsm2nQ5Qk2+v60=
=F85i
-----END PGP SIGNATURE-----

--midcd5sg5rny2et5--
