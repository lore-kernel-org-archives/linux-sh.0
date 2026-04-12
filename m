Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA24C6D;
	Sun, 12 Apr 2026 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775978711; cv=none; b=c82db3deMuTxTKZDwHrlsvQLpe2jvftIm31duxI6/Hyu2QxSDAsm24ZT5Mv86SDYOXFgq+KKSCZn8cQU/Tx61mqJufZEE94OSbKc99+RKtZG3c50R1dCA48q4tEIh2p2Cy+ZFHBI+UwowN16cm38IXejKQd1002f/NlOGz1qC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775978711; c=relaxed/simple;
	bh=KJsr1YqqTdCWbLYAx/Plk3TQyfMPqg42DSwROZ8KIrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nvxgXYHx6ljkdxE5yPM6p+0F4QQI0XZfAuE0FwvEx7WAyywmODk+UyaGJMqpvdjPN6/EGfvhdtemoUw0cfaNj4bZxGk7Ltqo9iXBIp2b/uVwsfjPhVix4gC2H7SwFEc/p18Tu/qbDT1xzf+IH4j+q2i1zGb5KQfXeek7QGhQkgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=F62r756o; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="F62r756o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=jfVjbSTuHMgZw25idDG4tZArUthYcDzY80TaAyOA0h0=; t=1775978708;
	x=1776583508; b=F62r756ocbn48VjS3EVUxYXJLNGJ6u7+j1YECx5Efp+xNDq9FUsauToOzjpcA
	pD5YV7zgDnfYDdRm79InQWWZHyklnU7web/ab5BC00IJ8Y9C3fmljYE1U997gWhRplcZSx5nEOc8u
	aQCHWUn5/Lvp7D3evuAA2DQJpG8uIuluifApUlIUurASUAYRSKhd39+/bHTQI5z/w4wuGZXZ+lB8I
	yoWqMNGjAWEBseizkwWZf0MBrYy7lGJZjPQIIEEBuZq2yxerNqtfqkvn1gXNskE9KwMBkMExXxtzW
	KI7gq6hEVlVJHy4PlubadaHheQ6gBIkTkqpIMwac0enZCy0HoQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wBpBh-00000002PX4-3Yoz; Sun, 12 Apr 2026 09:24:57 +0200
Received: from dynamic-077-183-202-106.77.183.pool.telefonica.de ([77.183.202.106] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wBpBh-00000001c0J-2Dpo; Sun, 12 Apr 2026 09:24:57 +0200
Message-ID: <b87eb8c7085973f20e6ee7f4c8cdf33d99a84102.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: fix typo in SPDX license id lines
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Tim Bird <tim.bird@sony.com>, brgl@kernel.org,
 ysato@users.sourceforge.jp, 	dalias@libc.org
Cc: linux-spdx@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 12 Apr 2026 09:24:56 +0200
In-Reply-To: <20260212192845.3724287-1-tim.bird@sony.com>
References: <20260212192845.3724287-1-tim.bird@sony.com>
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

On Thu, 2026-02-12 at 12:28 -0700, Tim Bird wrote:
> platform_early.[ch] have an extra - in their SPDX-License-Identifier
> lines.  Use the correct (single-dash) syntax for these lines.
>=20
> Signed-off-by: Tim Bird <tim.bird@sony.com>
> ---
>  arch/sh/drivers/platform_early.c     | 2 +-
>  arch/sh/include/asm/platform_early.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_=
early.c
> index 143747c45206..1c2a571a8ab8 100644
> --- a/arch/sh/drivers/platform_early.c
> +++ b/arch/sh/drivers/platform_early.c
> @@ -1,4 +1,4 @@
> -// SPDX--License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0
> =20
>  #include <asm/platform_early.h>
>  #include <linux/mod_devicetable.h>
> diff --git a/arch/sh/include/asm/platform_early.h b/arch/sh/include/asm/p=
latform_early.h
> index fc802137c37d..00b6e6dc4ac4 100644
> --- a/arch/sh/include/asm/platform_early.h
> +++ b/arch/sh/include/asm/platform_early.h
> @@ -1,4 +1,4 @@
> -/* SPDX--License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 */
> =20
>  #ifndef __PLATFORM_EARLY__
>  #define __PLATFORM_EARLY__

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Will pick this up today for v7.1.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
