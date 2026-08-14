Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901F388E4E;
	Fri, 14 Aug 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696346; cv=none; b=BCN+zmLnNlpSJmywWfFNy4coFytMxi7u7nKW66iZ7pe+shoAJd1sCc1Vc6zkKIuXKtNMZLBKxHdMmdUOdQxqhBLOKrwsuDSvsoRQF8v71zDqZOiL8F+e6tffVY/aieDs29uh7tzlbDFhmKl8TIADHefJE1S/QfS3PNsJEPGin2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696346; c=relaxed/simple;
	bh=Peaq6ctNzHzv8JJ9ujttvHpltwUzYBz+55XEWu5AIEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+cXV6Ri6kxS6Xq6KH526ZQeS2VLbCROHvKJt8NDvMnB433E6JHE+Z1dAZt11PP/XI1g/lcOmvcs7hhRVGvIDkLups/5BW3wGNnEZEs8GqA7Cpya6ZS+zMYyBethA8bk1S0l0OULCAhUgDdeu/9AbUnXkRPcrHWy74SauuBeGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=WnDKHc1f; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="WnDKHc1f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Q4o+wrfizkniP5jGzqnJyvRj8CprzgxwBR9U6Ez3AVs=; t=1786696335;
	x=1787301135; b=WnDKHc1fmnnUtkRPamB04m/fUGYclp4ru3V+YPInsU89R4iZ59SAn29801lDv
	krIBNF9jdRtV2bmoB4Z0LIhQTabzaN2JWsb0bsalqPsgQl6i4JGQnzyt/xRRiiLfZxcbOqySu4E9i
	wnu7mPNs+IZfL4peoa6brFCe04DhxKaZqdgchDvamBg0OMlsvdSLyUX1aBmCV+mvdgpmfwED/+T9B
	KQHnc7LIncCysVl57le0vTpTVJVMyWR74L6VCCIC2luk9O7+MUPtrV9BNCt03whnRITxys+snKl7z
	oB8snripqibI9Um3Lj59dNBHbGijDl5rgBT6W49doRpHyCI2nw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wunKi-00000002Jnf-2QBA; Fri, 14 Aug 2026 10:32:08 +0200
Received: from p5dc558fe.dip0.t-ipconnect.de ([93.197.88.254] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wunKi-00000001vah-1UhM; Fri, 14 Aug 2026 10:32:08 +0200
Message-ID: <70e13d954ec47a3b523e37f06b0f5889f61db9e7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: defconfig: enable the current M66592 UDC symbol
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-sh@vger.kernel.org, 	linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 14 Aug 2026 10:32:07 +0200
In-Reply-To: <20260814075531.15446-1-pengpeng@iscas.ac.cn>
References: <20260814075531.15446-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Pengpeng,

On Fri, 2026-08-14 at 15:55 +0800, Pengpeng Hou wrote:
> The M66592 UDC provider is built under CONFIG_USB_M66592. Several
> SuperH defconfigs still enable the removed CONFIG_USB_GADGET_M66592
> symbol.
>=20
> Replace the stale entries with the current provider symbol.
>=20
> Assisted-by: Codex:gpt-5
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v1: https://lore.kernel.org/all/20260624081843.7864-1-pengp=
eng@iscas.ac.cn/
> - no source-code changes
> - rebase all three affected SuperH defconfigs
> - add the USB maintainers and list omitted from the first submission
> - add the coding-assistant disclosure
>=20
> The Kconfig/provider mapping was reviewed statically; no SuperH kernel
> build was performed.
>=20
>  arch/sh/configs/migor_defconfig   | 2 +-
>  arch/sh/configs/sdk7786_defconfig | 2 +-
>  arch/sh/configs/shx3_defconfig    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defc=
onfig
> index 1d9d543eef4c..bde70f3bf857 100644
> --- a/arch/sh/configs/migor_defconfig
> +++ b/arch/sh/configs/migor_defconfig
> @@ -72,7 +72,7 @@ CONFIG_LOGO=3Dy
>  # CONFIG_LOGO_LINUX_VGA16 is not set
>  # CONFIG_LOGO_LINUX_CLUT224 is not set
>  CONFIG_USB_GADGET=3Dy
> -CONFIG_USB_GADGET_M66592=3Dy
> +CONFIG_USB_M66592=3Dy
>  CONFIG_USB_G_SERIAL=3Dm
>  CONFIG_RTC_CLASS=3Dy
>  CONFIG_RTC_DRV_RS5C372=3Dy
> diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_=
defconfig
> index d6fa3a422e24..d40be415dcb9 100644
> --- a/arch/sh/configs/sdk7786_defconfig
> +++ b/arch/sh/configs/sdk7786_defconfig
> @@ -147,7 +147,7 @@ CONFIG_USB_MON=3Dy
>  CONFIG_USB_OHCI_HCD=3Dy
>  CONFIG_USB_STORAGE=3Dy
>  CONFIG_USB_GADGET=3Dy
> -CONFIG_USB_GADGET_M66592=3Dy
> +CONFIG_USB_M66592=3Dy
>  CONFIG_RTC_CLASS=3Dy
>  CONFIG_RTC_DRV_MAX6900=3Dy
>  CONFIG_RTC_DRV_SH=3Dy
> diff --git a/arch/sh/configs/shx3_defconfig b/arch/sh/configs/shx3_defcon=
fig
> index 0cb69a0b92cb..d7496ea9a9fc 100644
> --- a/arch/sh/configs/shx3_defconfig
> +++ b/arch/sh/configs/shx3_defconfig
> @@ -79,7 +79,7 @@ CONFIG_USB=3Dy
>  CONFIG_USB_MON=3Dy
>  CONFIG_USB_R8A66597_HCD=3Dm
>  CONFIG_USB_GADGET=3Dy
> -CONFIG_USB_GADGET_M66592=3Dy
> +CONFIG_USB_M66592=3Dy
>  CONFIG_RTC_CLASS=3Dy
>  CONFIG_RTC_DRV_SH=3Dy
>  CONFIG_UIO=3Dm

Thanks for catching this!

Would it be possible to add a Fixes tag? I assume it should reference the
commit that dropped CONFIG_USB_GADGET_M66592 and forgot to update the confi=
gs.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
