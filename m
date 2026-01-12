Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD43559CB;
	Mon, 12 Jan 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216479; cv=none; b=Po7GPhH0f+qFzZxge8CKlYaZ0smvLh+599Tn0yoRLVMYQ+tjig+FMxxrLvigg9dDQ0UmZwo7llm20BXApJ8Ii5rIUCJJahnEJqZuYTiDmxNxl1oEgrOZ+TgrMLFMAGWAdmJlN7N0FJpqLCY96eJtS+l/JDvhniUyvcmOulhksAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216479; c=relaxed/simple;
	bh=NI3REoR398dEAEBYT8JkVJ2pGCkIGKuqkburlNnO5RY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mt+gSDDPt2DWdldEF1nalyo8K9F9QAhaKqKYq2K/xF34MllR+3SX8cP+nnC73Ult86WCmSK4FUO1WaolUlC5MFNEvjvhgQNHA6Q++0J4t050eW5fXrGt+UqKqY3NDhsQ7hAhXuD6rx413EvjEIjdXfOFwx5k2ohspJ7MgcF2070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=k8MH4Ely; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="k8MH4Ely"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=eq8LqbdJ8FxbdNiGhuVehMtZ1k8xnN9wxZ75PgGT4Ro=; t=1768216475;
	x=1768821275; b=k8MH4ElyEYrYVSFV0VgIV+4Kvjyc9Uv/8KKw+3RSuyGpC9e1rsq5pDh1LSR7z
	CGXIJUcR0XijbubkgPA5P/FJwLoJ6pTxk2pOJjcYydUrJmwOmXBdYkQah40gMYtY7ucer0bPj4KZZ
	GkejIkpDkm6StxfAtRKODRUFKBr5pD2y5O8Nm24w6qLFv9a/rgvmQZG5SeyxQtFkpYpWTc1a4/a1Z
	fl49sVDLBWchgbrDhXvZQWzWrwsojNVoNmLnKt0pX0dBrbnreUn2LoGZHlCB5Jg0tJByKqZYLWXKn
	ME3oR6lUQ0+4peLJDMb4Vckn98dz1Za/UwDvf5hXKccBkoQNtg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vfFsR-00000001H2k-0fsW; Mon, 12 Jan 2026 12:14:27 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vfFsQ-00000003N4I-3vi6; Mon, 12 Jan 2026 12:14:27 +0100
Message-ID: <aacdc1083c37bddfb721b732bdd7019f30b3915c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: remove CONFIG_VSYSCALL reference from UAPI
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 12 Jan 2026 12:14:26 +0100
In-Reply-To: <20260112-uapi-sh-at-sysinfo-ehdr-v1-1-b01dfe98a66a@linutronix.de>
References: 
	<20260112-uapi-sh-at-sysinfo-ehdr-v1-1-b01dfe98a66a@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Thomas,

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

Thanks for your patch!

I don't really know what AT_SYSINFO_EHDR is about. Could you explain the ba=
ckground
a little so that I have a better understanding of what I am reviewing?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
