Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC12F49EA;
	Thu,  3 Jul 2025 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566877; cv=none; b=Do2JDGL34bpYfv4CUERRMgxD16J6hAh4WpACQiR/zoNp0N7HcxbRnHk71XuktpVVBV5zQfGEurt9lWEQy6xKv4T93XgcvXDJC7aIgWDZ4kneH4bTSBiNY5u2QDe9v4yGsJsXNDMGbd4F4YdiVZHYybr7J1/8+2LxDUTt53hwK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566877; c=relaxed/simple;
	bh=kXwT/s0L5R6gAhPEfqhTtCjkK8xv0I33n8EXErGeCzM=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iz+SUhW1lBdS0cUz7sj/AKf8wvb307LYqqE1CM3oiHHIBdghEb5YtfKd7VLi4MeU0vG2StUFGxwiED9T346jwrQvRnhumcn/VdBBi/1f397wfStyVy1QG94FErKlA6scSeAJRMUyVtbn7q7pW5Emf2ctLidvcJ9G8xR2F94S3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=dYn0dijK; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="dYn0dijK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1751566873;
	bh=kXwT/s0L5R6gAhPEfqhTtCjkK8xv0I33n8EXErGeCzM=;
	h=Date:From:Cc:Subject:From;
	b=dYn0dijKsAkgyFidrZEa0/TJKuUk569QDaJK4RBckvVrtLOkC0QyqKl7y2sL5Nnir
	 8Uh3K7HNeg4GFhIw9j/5CnFLHmJTEDeBhC2/r8lY4TJJzs7eM1gI1vipxgLAsPVzQr
	 ChYvERcVr9Ytnpka06tUYRkELV3KCHX4PBRKtIdXY9Shw3KYUdL7Yn4YAAcWkwrM4n
	 Owtp1Qvi6M9X6qsKHDkBstK+f0PDXN92N8YEyu6LrWZ5936hRT6D4fy2hpKsdamOWG
	 WoVz++6S72bgxbym+s8WU+YM23ZU7y3riC4XLmzZtHcHpm425Lrwl6/dGAp+YDdqcN
	 +SB8bEWCjErWw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id EF4296B0;
	Thu,  3 Jul 2025 20:21:12 +0200 (CEST)
Date: Thu, 3 Jul 2025 20:21:12 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] sh: pci: fix "for a while" typo
Message-ID: <3e6k63aup4ct5xoczgczidfl6maklylotkfoe5uk5ofsw4f7mq@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="axd6yuzfxszgml4s"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--axd6yuzfxszgml4s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
v1: https://lore.kernel.org/lkml/h2ieddqja5jfrnuh3mvlxt6njrvp352t5rfzp2cvnr=
ufop6tch@tarta.nabijaczleweli.xyz/t/#u

 arch/sh/drivers/pci/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
index 9633b6147a05..f95004c67e6c 100644
--- a/arch/sh/drivers/pci/common.c
+++ b/arch/sh/drivers/pci/common.c
@@ -148,7 +148,7 @@ unsigned int pcibios_handle_status_errors(unsigned long=
 addr,
=20
 		cmd |=3D PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY;
=20
-		/* Now back off of the IRQ for awhile */
+		/* Now back off of the IRQ for a while */
 		if (hose->err_irq) {
 			disable_irq_nosync(hose->err_irq);
 			hose->err_timer.expires =3D jiffies + HZ;
--=20
2.39.5

--axd6yuzfxszgml4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmhmyhgACgkQvP0LAY0m
WPFFTA/+KZnugNFpgSftVNjcw5VlUqy09vUiJShA1H32HKTD0my1HW3LsRRbDTmi
Ef5ouYOPWYlnka7hFPdqGwPiIRGlgg5dFz2sQjJFNB5Fke2UwxyDpfSDHuxkg5ON
hiBE60IhLYgHT+bNFu/FzTkUprpcTzUrSdG4lB+7DA0KMfVvS2vHyXNl4k1aBNdn
6Dhl0vgva3FWeTrdbOmtmnH+qrfMbIEBE3bBebVyBp1jXY6BkDFArTxMoFkUXTlH
QYbqH5O/AVogvXPFZLkWylbbVIvaOhPTNQiLmIqpMy9nrWLDA2P6JZ/jUFo5UyO6
1nmgOHEmxz/DdyXKWtSrnVT1/rI/twS7DmyDxpk72kLVOySCk+vcq3kFtqyZPFA7
UT4ZgFWFno+kMK4oOXZzAjvQej58g7/QroYgVJy9FUEXF4GFIdOTm44SIL+HxfuZ
/iUhgVy2z/NhHywBJvbWf6tJcNEFee1naZOqAWzhhgOzoB/scV+rYobd4aheOb/Y
QMeMgXA818CBwW027YB1cPNZ5brclmKp9RHUWiFldDgzjpUBGydFd9PpuoMD50Ef
ebaAQ3Xa/TyXHYNRG3veJ/N8oO86qrBryYB2Bp3NVtiWBXUN+2MAPPLheDPPqaAV
dBZ2yqiVgCngsiR/THOjlgZiMoXh2vvq/NJ5ZJlIQ9W70KmQKDk=
=993V
-----END PGP SIGNATURE-----

--axd6yuzfxszgml4s--
