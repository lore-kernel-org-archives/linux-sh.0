Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9184C6D;
	Sun, 12 Apr 2026 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775978809; cv=none; b=gbNUc8w9vJI7X601K2h+dkbmTuji78z+0QnLfCt9z8C6w8sF0aO/fntoHWVF9T8JSqqGyGFcr+K/4zDS1pGLfqA//W3aB27EkTL8rqVpVTYccCbNBLtqYG9VxZWaBuB6gAi8YO47+aJRKnoyuQbjLwSaX4dteAs27QqZh4ghU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775978809; c=relaxed/simple;
	bh=bLeuB0//z0b2sHc0ZMU10JtATU1NDcdyJ8w5CTKrxEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDTC2fphFdgeaKBYZ57kM0Bj7ajvzRT5F4ckl4bJOMruHEFpOuW/hUSZsfWKpNcMlKrIHjbQlqcVOnvBNWn8rMpIDREmXKr0DEMLHhFmOoGNqkslymQMC/sdqXFv76HS9b1LXLS8fAvPBkBBN7frnkDx9DTecJCdWjgHawBfTsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ar7bSB9T; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ar7bSB9T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ucBIacQvRMGHn7g7GRkLlPKuW2kJ5H49j9DpagB7Cl0=; t=1775978806;
	x=1776583606; b=ar7bSB9TYaM8B5nNB0/TADaYOSIKwFacbqaDOQTD8ZArCxydAGiy1kB9kdPvy
	SvLmaOn4+WLF2YCRKvpMjz0tLBo2Brbe+cB35e1fAwWqYfgOwO7SXDd/eQmiPjVUIS98wEwmljOKm
	qYjYiioNIVhC/FYlU4C0Uujm2b6SiHpU9f8Gga5MHqpQByBfZp8x6umFlsFcUy6P7gDc1q8D++rIi
	lTHygwwpkfD5x5dVC40JqgITQPGbXkMM+HQURAUre7fl2TY46c4pl9qtRAPGXzUggTMX1cFtd4jhb
	yv3gUb4I41zUSnieRODq+/iFTSzbXe8Ek0epWVleYW4VNau6Ew==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wBpDO-00000002PmN-262A; Sun, 12 Apr 2026 09:26:42 +0200
Received: from dynamic-077-183-202-106.77.183.pool.telefonica.de ([77.183.202.106] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wBpDO-00000001cHX-1CQe; Sun, 12 Apr 2026 09:26:42 +0200
Message-ID: <9415f13219d93fa7541f35609092a562b12ac20c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: remove CONFIG_VSYSCALL reference from UAPI
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 12 Apr 2026 09:26:41 +0200
In-Reply-To: <20260112-uapi-sh-at-sysinfo-ehdr-v1-1-b01dfe98a66a@linutronix.de>
References: 
	<20260112-uapi-sh-at-sysinfo-ehdr-v1-1-b01dfe98a66a@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Mon, 2026-01-12 at 12:02 +0100, Thomas Wei=C3=9Fschuh wrote:
> The definition of AT_SYSINFO_EHDR was gated between CONFIG_VSYSCALL to
> avoid a default gate VMA to be created. However that default gate VMA
> was removed entirely in commit a6c19dfe3994
> ("arm64,ia64,ppc,s390,sh,tile,um,x86,mm: remove default gate area").
>=20
> Remove the now unnecessary conditional.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/sh/include/uapi/asm/auxvec.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/arch/sh/include/uapi/asm/auxvec.h b/arch/sh/include/uapi/asm=
/auxvec.h
> index 8eb47ede7193..63fcc39e2c6a 100644
> --- a/arch/sh/include/uapi/asm/auxvec.h
> +++ b/arch/sh/include/uapi/asm/auxvec.h
> @@ -13,14 +13,10 @@
>   */
>  #define AT_FPUCW		18	/* Used FPU control word.  */
> =20
> -#if defined(CONFIG_VSYSCALL) || !defined(__KERNEL__)
>  /*
> - * Only define this in the vsyscall case, the entry point to
> - * the vsyscall page gets placed here. The kernel will attempt
> - * to build a gate VMA we don't care about otherwise..
> + * The entry point to the vsyscall page gets placed here.
>   */
>  #define AT_SYSINFO_EHDR		33
> -#endif
> =20
>  /*
>   * More complete cache descriptions than AT_[DIU]CACHEBSIZE.  If the
>=20
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20260112-uapi-sh-at-sysinfo-ehdr-f26a12ec5940

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Will pick this up today for v7.1.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
