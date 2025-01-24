Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F6219A7D;
	Fri, 24 Jan 2025 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737708310; cv=none; b=IgPfHmmjA8vPmIp8FBMROoDJLwmaIrvhT7SYVSazvtke4G/HYSoLH3rAXM2Q8vQ+uUxanhLILlhq3I5RglV0O7ks66biBjByGJZFuJgf99mEh+72c5ilZNZMGB2wF3yhSp9nfTTMgJzmbnhkznxfaQyAJmv7kK32bKUzRwW4VMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737708310; c=relaxed/simple;
	bh=3fOchPggFdiuRNK5zAIwZWnOp/YX/A9OD4g8Femio20=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYKCgFrj20yXLogFDQMIDxna2m9cF2jbiX7utFUifIOvHbELUSMLqLxBOfEyNUP5nynEOVeQaUS4QfZVbVY+jPGKTETFT7GUI6XBr5+q0hPlVjB4wzLCyhvragi5jDkvWf+OOKboa4SNxgwugRxgjx2z60YRXG3jYhL5bi403w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=n6xmObWG; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="n6xmObWG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SxNXNJO+yvBE22Y6LWWxRPUZkiNzYZgjkURWIH0wWxU=; t=1737708306; x=1738313106; 
	b=n6xmObWGyQ6cwX6IZqTZnbhvgkMBWgBH4FrpCVsIldowsBFxfkt5haVrdfx8vGWm3+200MU8hKH
	FzDWJx5j0cfaLMQ78UA911H6defSJXb+/EnRVFyS9qdbfEO6ErE/PyIHOdo+JrnziDplR3c5+kwVu
	7FwBaj5tpcaSIb2+HjGtj1sKdHWdL0HtLE4YrSo32+09odXoXHr1w5KAX57ZI9OyTnyIALIUEleJe
	0Tfhth9o1c8rwJRyhAYsb4zs3/3h3H5wI89MJpzY3yFCfHkS6Ajy5XUKx3SNpHmUHIDXTHm9aXtig
	SwbNoxO5FhqbXAYYGVuZLqu9Gxfeejw2jxCQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tbFJH-00000003wSF-1M7g; Fri, 24 Jan 2025 09:45:03 +0100
Received: from p5dc55cec.dip0.t-ipconnect.de ([93.197.92.236] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tbFJH-00000002AAp-0KTd; Fri, 24 Jan 2025 09:45:03 +0100
Message-ID: <1ce6cda91aaeb86133d37729eff86c7df567de42.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: boards: Use imply to enable hardware with complex
 dependencies
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-sound@vger.kernel.org, kernel test robot
	 <lkp@intel.com>
Date: Fri, 24 Jan 2025 09:45:02 +0100
In-Reply-To: <8329d88cecc1e419f6a0f3f215695d3cfcb549aa.1737707880.git.geert+renesas@glider.be>
References: 
	<8329d88cecc1e419f6a0f3f215695d3cfcb549aa.1737707880.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Geert,

On Fri, 2025-01-24 at 09:39 +0100, Geert Uytterhoeven wrote:
> If CONFIG_I2C=3Dn:
>=20
>     WARNING: unmet direct dependencies detected for SND_SOC_AK4642
>       Depends on [n]: SOUND [=3Dy] && SND [=3Dy] && SND_SOC [=3Dy] && I2C=
 [=3Dn]
>       Selected by [y]:
>       - SH_7724_SOLUTION_ENGINE [=3Dy] && CPU_SUBTYPE_SH7724 [=3Dy] && SN=
D_SIMPLE_CARD [=3Dy]
>=20
>     WARNING: unmet direct dependencies detected for SND_SOC_DA7210
>       Depends on [n]: SOUND [=3Dy] && SND [=3Dy] && SND_SOC [=3Dy] && SND=
_SOC_I2C_AND_SPI [=3Dn]
>       Selected by [y]:
>       - SH_ECOVEC [=3Dy] && CPU_SUBTYPE_SH7724 [=3Dy] && SND_SIMPLE_CARD =
[=3Dy]
>=20
> Fix this by replacing select by imply, instead of adding a dependency on
> I2C.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501240836.OvXqmANX-lkp@i=
ntel.com/
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/sh/boards/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
> index 46387fd040adeaac..cac265e3e7de926d 100644
> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -73,8 +73,8 @@ config SH_7724_SOLUTION_ENGINE
>  	select SOLUTION_ENGINE
>  	depends on CPU_SUBTYPE_SH7724
>  	select GPIOLIB
> -	select SND_SOC_AK4642 if SND_SIMPLE_CARD
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
> +	imply SND_SOC_AK4642 if SND_SIMPLE_CARD
>  	help
>  	  Select 7724 SolutionEngine if configuring for a Hitachi SH7724
>  	  evaluation board.
> @@ -252,8 +252,8 @@ config SH_ECOVEC
>  	bool "EcoVec"
>  	depends on CPU_SUBTYPE_SH7724
>  	select GPIOLIB
> -	select SND_SOC_DA7210 if SND_SIMPLE_CARD
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
> +	imply SND_SOC_DA7210 if SND_SIMPLE_CARD
>  	help
>  	  Renesas "R0P7724LC0011/21RL (EcoVec)" support.
> =20

Looks like a reasonable change to me.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
