Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984339C015;
	Wed,  1 Apr 2026 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033204; cv=none; b=OZ4wyQQtMwLznexpIGFMPF7dPUpekOLzcwbsa4ii4b5BfGuFX9Pog4uq2dAPJGOA8zq7T2w01AwTLXkusl+y7KcL6dij2tauMwEUCs4/Jila9vwgyMCf87MDihRGLWRsMWi7sB4VU81BOJs3LgaW5pdDKBwE9r9YtMLw6DT0ACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033204; c=relaxed/simple;
	bh=3TrryCYuaMcN3ZTDTtmrm9abis+czzQACrQDa8EeOKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bA3Bl6oKSD+/NJeoAX9QeYTrMOWFj1sEz5CMyiC2/2T1pisYQORQA5yCEJ7+Ca5mcwTRR2sjOllMUOpKtfWrJyvStOOMLNT8jGRXGBWbCrBVKHhwLilCqcg6WoOVLbcIdvmhbaiH4pLosb2dcihRIQuYzf8KCtuXDJOzGek7Yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ThIGWxSz; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ThIGWxSz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=mbS4sdBdy5EpZUWgeIqN0btTGaVpVymgwhUYntphOuU=; t=1775033201;
	x=1775638001; b=ThIGWxSzD8A/5d9v8k1KwXw5rlNplplEuR6X+IfeIvw2smWO9+D0KIAWBrYyx
	bbu2VLUfmDO0ZTfpebwSP98IahzKb0KxXF3y4cJxdJBq9jQQrZ5iLMU2Wcq7D9wV9OSEtzKYqz+eQ
	OJB/VC7mApqche+9ZMXYiARdUU4uS8/STaMFaVmKn1nhEzqvE3ad1aQ+qGpMA42gkCecxwe6jejgB
	S1zkRcR04A/oH33SgylaPIMlpSgQQeesvpJcjxy2W7TJxqurgFlmLnFusCpY6CdHgmvTFPIdrmi5J
	6rJInFQ4x7UwMovSPqOkAJNFaYvqxtygjjZeMTMNWDSezE6Tqw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1w7rDc-000000024ZE-0O6N; Wed, 01 Apr 2026 10:46:32 +0200
Received: from tmo-086-60.customers.d1-online.com ([80.187.86.60] helo=[172.20.10.2])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1w7rDb-00000003bOL-2glH; Wed, 01 Apr 2026 10:46:32 +0200
Message-ID: <b7c978f9728c1a1197e90a98bcec5e8e4dc7e7ec.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] arch/sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Zimmermann <tzimmermann@suse.de>, ysato@users.sourceforge.jp, 
	dalias@libc.org, arnd@arndb.de
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Date: Wed, 01 Apr 2026 10:46:29 +0200
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

Hi Thomas,

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

Thanks for catching this! I wonder where this configuration entry comes fro=
m though.

My SH7785LCR board does have a DVI output as well as a Silicon Motion SM-50=
1 video
chip though, so I think it should be able to perform EDID in general. Or is=
 the
protocol actually tied to the x86 architecture? What about monitors on a Po=
werPC
workstation, for example? Does EDID not work there at all?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
