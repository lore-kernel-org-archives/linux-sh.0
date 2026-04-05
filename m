Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408920E702;
	Sun,  5 Apr 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775398180; cv=none; b=bRwfolgpcauKg5ER5Ulvvi63/vnFhvneTpUec9pCECx6flzXBV7jGF3I2vGMUod4PpcrmmZTE8eDdKtRt3XXpW6l74JxQi4nOi45G4AMvprnJedzgdjnYdFrMJvCZNHXPiPLoyHFsbZd+LAL2S96JWlpUsN/1Iw1iQFjWOXJ8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775398180; c=relaxed/simple;
	bh=hkCvPpMGLsaN0R3+jdNYUu5I1KfnROsow6HQUuiGP5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkRBrVaJwu2naL+92rYnWu2LxI47+zF0IO7SqzF3B17tM59M0eIK2/6c+eHyDKc+cOjRzgebkE4RPcuzgIpjYEHi9m7d2efu1rEO3FjltGAdBKidXlDg0MFqDdka0lHIiqGn1ae/b5uGHX8p3wFeS2gakYuMQOtZ98DaTTCOEaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=FYZtPwCx; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FYZtPwCx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=6QpERGgiRzMpjcYhTLZyZXpXmSyKswYDkegrj4sAT/Y=; t=1775398176;
	x=1776002976; b=FYZtPwCxidWzNVjhd75iK/rK5y9P+S/L4fC3N8UY1L9KP53AkDSpCvhj+W+no
	V0SvEulSa+0n0VTHPk4I/MEJG0WyOpAzbDrg5je83DnH89R1liaffC8JXSRBmS3qk50fv/iEPj+ns
	VPorRjQ3/7RlN+Pcw+vym3ZrNu3/dxvN9yx4v5grZFNlVNZagvPd0j01VCBe53BWWdOGzB6LcGA20
	rbP8tGrKHGNJ98jpo/L0EtIMEhjq3kJKFQYdB2f1DMRrGQv+iLm/ha/enT06uqSJSWQSycvDdVcqH
	tQa5SwPvar6FGJJVhURPWP9JcekRdxWg/x9DfZjD6WMvmqBZMw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1w9OAL-00000003IkK-0wfX; Sun, 05 Apr 2026 16:09:29 +0200
Received: from dynamic-089-012-115-001.89.12.pool.telefonica.de ([89.12.115.1] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1w9OAL-00000001XSM-056t; Sun, 05 Apr 2026 16:09:29 +0200
Message-ID: <8ba12d4bf7836ae11cf48e25bba7db6625687291.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] cdrom: gdrom: fix block I/O and capacity setting
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>, linux-sh@vger.kernel.org, Artur Rojek
	 <contact@artur-rojek.eu>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>, 
	linux-kernel@vger.kernel.org
Date: Sun, 05 Apr 2026 16:09:27 +0200
In-Reply-To: <20260405082330.4104672-1-fuchsfl@gmail.com>
References: <20260405082330.4104672-1-fuchsfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Florian,

On Sun, 2026-04-05 at 10:23 +0200, Florian Fuchs wrote:
> Hi all,
>=20
> This series fixes a gdrom driver Oops due to bad MMIO register access and
> fixes the missing updates of the block layer gendisk capacity that
> prevented ISO9660 mounts from working.
>=20
> The change was tested on real Sega Dreamcast devices (PAL-E, NTSC-J)
> with physical CD-R discs and with GDEMU emulated discs. Before: Oops on
> mount and an unusable drive. After: Successfully able to mount and use
> the inserted medium.
>=20
> Thanks,
> Florian
>=20
> Florian Fuchs (2):
>   cdrom: gdrom: replace port I/O with MMIO accessors
>   cdrom: gdrom: update gendisk capacity on open
>=20
>  drivers/cdrom/gdrom.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
>=20
>=20
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

Thanks a lot for the series! Can you give me any hints on what's the best m=
ethod
these days to boot a Linux kernel on Dreamcast these days? I have the hardw=
are,
but I never tried to boot Linux on it. An emulator might be even better.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
