Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F7844D02F;
	Tue, 28 Apr 2026 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392519; cv=none; b=QUs+uKq0/GFPyXICZ8RjQnqZ4fSX8S6gC+C6VdBfpLmUcpHa7qmPUmacsgZu8MXgZ9mCISwu/elYnavcxj7+4lJEbWccfB2uybL0UBcD4Ar8rovGYhIxc/a3gwCkxQisaaVeAGYXuvcDypnEaMH2rdpd2JA0emShh+1Ph00JJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392519; c=relaxed/simple;
	bh=kpJ52me/PCvpovg9+A6Ng6f31q/3J7DN+t+o4Vt9iv0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cgg2X6b3xclhOQaS6YbMe6SipKYmjaOHr28H8kgNVE0hXge7t5xjF9iaVWIZ0V6WlWZHhtU5twBLuAGS45TvxibLVXm8KW1jiqYqs9e8g3fxKkoTwUZZFcowe/i8llas0RzfQ3TlxwTFcF1b1g8HhbMYOdJ7yVe4VCSPq9lUH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UsTdvpu+; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UsTdvpu+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=CjukbiUJ6p5lhIplofkjsdwJgFFyi6YItOyBf5ot5Ac=; t=1777392515;
	x=1777997315; b=UsTdvpu+EtHqylNepi82nKbJB1aXT/bO/EDCPJ3B3y6lgBlvZ/MuMREOmxfNg
	xLd9wgfJxKbysrc3qvJg5mUo7aGloaSVDkBHLnKP7VEVJHewBnF5IAPks+/1JjdbdhsMX2KrEUZWw
	0EOA6R8ZLNKF0JO1oNxzOBk4zXvQzwSzwFBDOTrIGGyTEOwxDzzPttxjpy8es4AhQ/c7/iziQxH40
	nHBCUAuRNRLF7hfCFsITf4+m7lJs+eNfHypLXuVFSI32WjB0qSL+uNSPCiXWFFbe1Mbr9KUIm362g
	mGI+lDI57Qlvw2ogoOwrI4yO7OeQmHiQFTuMxdviYVU9fBMoPg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wHkz6-00000003k4L-3uZR; Tue, 28 Apr 2026 18:08:28 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wHkz6-00000001lTA-2zrk; Tue, 28 Apr 2026 18:08:28 +0200
Message-ID: <716fb62be57fd01c68cfed9220da7ebddfa321ae.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: select legacy gpiolib interface
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 28 Apr 2026 18:08:27 +0200
In-Reply-To: <20260428155528.3218943-1-arnd@kernel.org>
References: <20260428155528.3218943-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Arnd,

On Tue, 2026-04-28 at 17:55 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Many board files on sh reference the legacy gpiolib interfaces that
> are becoming optional. To ensure the boards can keep building, select
> CONFIG_GPIOLIB_LEGACY on each of the boards that have one of the
> hardcoded calls.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sh/Kconfig                        | 1 +
>  arch/sh/boards/Kconfig                 | 8 ++++++++
>  arch/sh/boards/mach-highlander/Kconfig | 1 +
>  arch/sh/boards/mach-rsk/Kconfig        | 3 +++
>  4 files changed, 13 insertions(+)
>=20
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index d5795067befa..d60f1d5a94c0 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -462,6 +462,7 @@ config CPU_SUBTYPE_SHX3
>  	select CPU_SHX3
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	select PINCTRL
> =20
>  # SH4AL-DSP Processor Support
> diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
> index 1af93be61b1f..d89b74177233 100644
> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -80,6 +80,7 @@ config SH_7724_SOLUTION_ENGINE
>  	select SOLUTION_ENGINE
>  	depends on CPU_SUBTYPE_SH7724
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	imply SND_SOC_AK4642 if SND_SIMPLE_CARD
>  	help
> @@ -199,6 +200,7 @@ config SH_SH7757LCR
>  	bool "SH7757LCR"
>  	depends on CPU_SUBTYPE_SH7757
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
> =20
>  config SH_SH7785LCR
> @@ -226,6 +228,7 @@ config SH_URQUELL
>  	bool "Urquell"
>  	depends on CPU_SUBTYPE_SH7786
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	select HAVE_PCI
>  	select NO_IOPORT_MAP if !PCI
> =20
> @@ -233,6 +236,7 @@ config SH_MIGOR
>  	bool "Migo-R"
>  	depends on CPU_SUBTYPE_SH7722
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	help
>  	  Select Migo-R if configuring for the SH7722 Migo-R platform
> @@ -242,6 +246,7 @@ config SH_AP325RXA
>  	bool "AP-325RXA"
>  	depends on CPU_SUBTYPE_SH7723
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	help
>  	  Renesas "AP-325RXA" support.
> @@ -251,6 +256,7 @@ config SH_KFR2R09
>  	bool "KFR2R09"
>  	depends on CPU_SUBTYPE_SH7724
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	help
>  	  "Kit For R2R for 2009" support.
> @@ -259,6 +265,7 @@ config SH_ECOVEC
>  	bool "EcoVec"
>  	depends on CPU_SUBTYPE_SH7724
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	imply SND_SOC_DA7210 if SND_SIMPLE_CARD
>  	help
> @@ -329,6 +336,7 @@ config SH_MAGIC_PANEL_R2
>  	bool "Magic Panel R2"
>  	depends on CPU_SUBTYPE_SH7720
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	help
>  	  Select Magic Panel R2 if configuring for Magic Panel R2.
> diff --git a/arch/sh/boards/mach-highlander/Kconfig b/arch/sh/boards/mach=
-highlander/Kconfig
> index b0abd03cac4e..cd3a553ce30c 100644
> --- a/arch/sh/boards/mach-highlander/Kconfig
> +++ b/arch/sh/boards/mach-highlander/Kconfig
> @@ -20,6 +20,7 @@ config SH_R7785RP
>  	bool "R7785RP board support"
>  	depends on CPU_SUBTYPE_SH7785
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
> =20
>  endchoice
> =20
> diff --git a/arch/sh/boards/mach-rsk/Kconfig b/arch/sh/boards/mach-rsk/Kc=
onfig
> index f0299bc4416f..3810937aa5d4 100644
> --- a/arch/sh/boards/mach-rsk/Kconfig
> +++ b/arch/sh/boards/mach-rsk/Kconfig
> @@ -12,16 +12,19 @@ config SH_RSK7201
>  config SH_RSK7203
>  	bool "RSK7203"
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	depends on CPU_SUBTYPE_SH7203
> =20
>  config SH_RSK7264
>  	bool "RSK2+SH7264"
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	depends on CPU_SUBTYPE_SH7264
> =20
>  config SH_RSK7269
>  	bool "RSK2+SH7269"
>  	select GPIOLIB
> +	select GPIOLIB_LEGACY
>  	depends on CPU_SUBTYPE_SH7269
> =20
>  endchoice

Thanks, this looks reasonable from what I can see. Most boards require at l=
east
gpio_request() which is now guarded behind CONFIG_GPIOLIB_LEGACY.

Does this maybe need a Fixes: tag to identify the commit which introduced t=
he new
config option CONFIG_GPIOLIB_LEGACY?

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
