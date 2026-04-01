Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D5421EF1;
	Wed,  1 Apr 2026 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049924; cv=none; b=ZNGs4jexAYzSH1BkictcGKfkt40Nw3WLdbghSETumOHV4MOl19TtvMvK69ASfLZnivGhzjtljDSqOO7RWX+RA8RcI7zRXDu6G/lkqRapmb4ykLQ8ISEiDU1w6E+c1Uvf25LgssinS/tUMxcaFpIxthD1MYiuTGT5kRRkzYnVeQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049924; c=relaxed/simple;
	bh=qcdL8njuac003n3UP47jx2tPa1gSUDQ8OETu2dnKykU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ke1RkDRwFd/85GGvRn0Y7W+eUoUlCHUEmh5uHmftp0W4E47gU5LcKmUggrnho88ILbHZiDZHDO4g20CykdPfqk4h3SWzRwa3NPEPvK4CPL/gvwJ3XV75Z0YNBiPVLMS5rrcKVYo294ilJOQoicYUVwH2YFNETNtOQYENAXNyAFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=X8S2YI3y; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="X8S2YI3y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ZFLBXUnA3OsuD71wnhgNFssmPRJAe8/52pzXm/xCyyI=; t=1775049922;
	x=1775654722; b=X8S2YI3yNCoh2QI4f/Ph4NBeqDrxUV9qFGQRaihziNA45AbFkfcGF05nAz/w6
	ckalo2bEco/kjEvUZOAFgO7nmoQR1BQSymARqjqUuXpRyMGcISt8e1p+O3DI+A7sjLwyFxB6wA6n8
	3HRRjbXOKWveBASBer5IdA9f6CqbAdt8YdhHVz33jj28C8SWvzNde79DWeTA0bsb1HXbstzHvveF6
	qJ7xWBHabf/x03MWNOl9DF99d/Yn6wblZVf3bv+2gYkyKNsfBg3vOprSMU/kr/SxEdnIxd62apEqF
	OJX0FG4tLbaGlmBZ2/ajaklKiXSW3H30b6zyf+g8l5UJC2yEcA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1w7vZQ-000000009d8-2cN7; Wed, 01 Apr 2026 15:25:20 +0200
Received: from dynamic-077-191-137-043.77.191.pool.telefonica.de ([77.191.137.43] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1w7vZQ-0000000063U-1iS0; Wed, 01 Apr 2026 15:25:20 +0200
Message-ID: <5c20b5c8315b77e014fc60bacbbe7a73c6fe29da.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] arch/sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Zimmermann <tzimmermann@suse.de>, ysato@users.sourceforge.jp, 
	dalias@libc.org, arnd@arndb.de
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Date: Wed, 01 Apr 2026 15:25:19 +0200
In-Reply-To: <20260401083242.214492-1-tzimmermann@suse.de>
References: <20260401083242.214492-1-tzimmermann@suse.de>
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

On Wed, 2026-04-01 at 10:32 +0200, Thomas Zimmermann wrote:
> CONFIG_FIRMWARE_EDID=3Dy depends on X86 or EFI_GENERIC_STUB. Neither is
> true here, so drop the lines from the defconfig files.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  arch/sh/configs/dreamcast_defconfig | 1 -
>  arch/sh/configs/hp6xx_defconfig     | 1 -
>  arch/sh/configs/se7343_defconfig    | 1 -
>  arch/sh/configs/se7780_defconfig    | 1 -
>  4 files changed, 4 deletions(-)
>=20
> diff --git a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dreamc=
ast_defconfig
> index dd58797e8298..b31bf17fe112 100644
> --- a/arch/sh/configs/dreamcast_defconfig
> +++ b/arch/sh/configs/dreamcast_defconfig
> @@ -50,7 +50,6 @@ CONFIG_HW_RANDOM=3Dy
>  CONFIG_WATCHDOG=3Dy
>  CONFIG_SH_WDT=3Dy
>  CONFIG_FB=3Dy
> -CONFIG_FIRMWARE_EDID=3Dy
>  CONFIG_FB_PVR2=3Dy
>  CONFIG_FRAMEBUFFER_CONSOLE=3Dy
>  CONFIG_FONTS=3Dy
> diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defc=
onfig
> index 04a9fcb4342a..b6116a203a27 100644
> --- a/arch/sh/configs/hp6xx_defconfig
> +++ b/arch/sh/configs/hp6xx_defconfig
> @@ -35,7 +35,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=3Dy
>  CONFIG_LEGACY_PTY_COUNT=3D64
>  # CONFIG_HWMON is not set
>  CONFIG_FB=3Dy
> -CONFIG_FIRMWARE_EDID=3Dy
>  CONFIG_FB_HIT=3Dy
>  CONFIG_FB_SH_MOBILE_LCDC=3Dy
>  CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se7343_de=
fconfig
> index 2d4d1f974f14..b3ce8a502787 100644
> --- a/arch/sh/configs/se7343_defconfig
> +++ b/arch/sh/configs/se7343_defconfig
> @@ -57,7 +57,6 @@ CONFIG_I2C=3Dy
>  CONFIG_I2C_SH_MOBILE=3Dy
>  # CONFIG_HWMON is not set
>  CONFIG_FB=3Dy
> -CONFIG_FIRMWARE_EDID=3Dy
>  CONFIG_FB_SH_MOBILE_LCDC=3Dm
>  CONFIG_SOUND=3Dy
>  CONFIG_SND=3Dy
> diff --git a/arch/sh/configs/se7780_defconfig b/arch/sh/configs/se7780_de=
fconfig
> index 13fa6a59b8f1..9e96b000cb99 100644
> --- a/arch/sh/configs/se7780_defconfig
> +++ b/arch/sh/configs/se7780_defconfig
> @@ -60,7 +60,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=3Dy
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_THERMAL=3Dy
>  CONFIG_FB=3Dy
> -CONFIG_FIRMWARE_EDID=3Dy
>  CONFIG_FB_SH_MOBILE_LCDC=3Dm
>  CONFIG_FRAMEBUFFER_CONSOLE=3Dy
>  CONFIG_LOGO=3Dy

Looks good to me.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
