Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952093B38A2;
	Fri, 17 Apr 2026 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423426; cv=none; b=bcp/GubX05/y1FECxDDd0osJVXjrs4PM/PJdV7eAZzjXwOwqp0dAG2qZV8nczxgEQNfAnaPU+MpJRkSSPerC5n8+d8RU+o59IIE+fSEfZSKOR/EL/krFtp3ktCuXwdCbuGmqBuTnSxT7P8BDAkR9laOXiySuNWe3ESKljMjwlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423426; c=relaxed/simple;
	bh=7ydKaLKzxMiFvVzu3vZ/Ac09qhhGCTLk8JZdACFvJcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZA6jNLBt7qb6pYwtlKJt4RJlEYYCJdzgxJraRSFoh8urTpDXhjcqZ2Hw1VGkdhDkzphmBH8qOsleJnHbxKLwm1lHSnAlhwYFYXJTkzrZmBI3hvlbETKlTVPkpY85Ll9lNI0baIkShVLTYQIAL4NHvMwi9ReSYLxdKD/j90dtcAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Gc67/NVJ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Gc67/NVJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9kZOZBrf0duAQyfRkgP92q+z7mcpvYzoR/SB4aFEmBw=; t=1776423423;
	x=1777028223; b=Gc67/NVJhwD7NAkN0pjYUNLMdFQhvDJA1XqfssX355UXgXvCQRmqlzZZImUIn
	MAhc8rdKnO20iPPdicSK/TdMGW5oejJviTSGQz/uWyvXnBfNTvLhlbfbHzPsM2+jM9dTvpziBnYG+
	JSclknxjtbuaCPcsMTVaPHwScGR2yHZCwdX+qDAsdU5NHd7prkfD8sv80H7CT7ba23k78m1K+ObJA
	Z3Pml09vuyQVYBSOmd3uzve2qJi/tMhLfOCEDFYo/ARRLuVS/BJNgG1zC7ny7Srh14ysn002NfwJf
	PhFVeXMZMhYXuX+kluVtvuQakT8TyyLns92hekZ1iQgc1SymKQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wDgsb-00000001QXf-1YmG; Fri, 17 Apr 2026 12:56:57 +0200
Received: from dynamic-002-245-058-104.2.245.pool.telefonica.de ([2.245.58.104] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wDgsb-000000011Pb-0dmK; Fri, 17 Apr 2026 12:56:57 +0200
Message-ID: <30ff5e1e6c0c3d4e0fb3b6f36a5372ed6bf45d19.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: fix fallout from ZERO_PAGE consolidation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, Thomas Wei?schuh	
 <thomas.weissschuh@linutronix.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, 	linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org
Date: Fri, 17 Apr 2026 12:56:56 +0200
In-Reply-To: <20260417103208.1217010-1-rppt@kernel.org>
References: <20260417103208.1217010-1-rppt@kernel.org>
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

Hi Mike,

On Fri, 2026-04-17 at 13:32 +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>=20
> Consolidation of empty_zero_page declarations broke boot on sh.
>=20
> sh stores its initial boot parameters in a page reserved in
> arch/sh/kernel/head_32.S. Before commit 6215d9f4470f ("arch, mm:
> consolidate empty_zero_page") this page was referenced in C code as an
> array and after that commit it is referenced as a pointer.
>=20
> This causes wrong code generation and boot hang.
>=20
> Declare boot_params_page as an array to fix the issue.
>=20
> Reported-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Tested-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Fixes: 6215d9f4470f ("arch, mm: consolidate empty_zero_page")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/sh/include/asm/setup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
> index 63c9efc06348..8488f76b48b4 100644
> --- a/arch/sh/include/asm/setup.h
> +++ b/arch/sh/include/asm/setup.h
> @@ -7,7 +7,7 @@
>  /*
>   * This is set up by the setup-routine at boot-time
>   */
> -extern unsigned char *boot_params_page;
> +extern unsigned char boot_params_page[];
>  #define PARAM boot_params_page
> =20
>  #define MOUNT_ROOT_RDONLY (*(unsigned long *) (PARAM+0x000))
>=20
> base-commit: 43cfbdda5af60ffc6272a7b8c5c37d1d0a181ca9

Thanks, I'll try to test this patch this weekend and will pick it up for v7=
.1.
I have already collected a number of patches for v7.1 with my Reviewed-by.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
