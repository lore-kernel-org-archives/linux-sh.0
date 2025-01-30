Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BB19006F;
	Thu, 30 Jan 2025 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226659; cv=none; b=hpR9lMvCsBfQYYErAb1Dx450ogOlZy4qetmV2pVSWs5IzHQ0y8Sa7s7W0vRtTqQWIaFGMjFZB65j0/uYwJNBqvMQLA7Lvm3neyiXYuNR3UDLuMwRbO55p06TEAvB+Fr/WBknHAcC0082xX3PGcoo4Lg7LdySDNis7SQT6HYBM40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226659; c=relaxed/simple;
	bh=0W/KZB5CuGsdEu13FhyCpkZ6ydjmhias7q7P/hgJad0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ISfIL40tCMpLddH8zgDpyLf7oLQFA8/1dmrEkgOQ0uRW41qFkHD8rQnGhIdIFVDSwCDJW3CZ1TimmYXnNSooQJivUbP/jELlJ/jZJs+CifRN9FdV8czBEOFqI+TEACyoL5jatXWQMouYgd/yRxCqT5yHrbQ38qkOgccln/tPoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=C3lGbnZ2; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="C3lGbnZ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k1prBKX6w2tvDpKnxu7xBwWx35yahCWJ8RiT25kaSk0=; t=1738226657; x=1738831457; 
	b=C3lGbnZ2rbVpOfneR5dnj1u5/K2Os9PToFTBPSE/qFCAdiLE8m5ECq6NyoyYZSxUnX3OeCQ9IBs
	zoLTyA6lcRpgXe6TSZQgkili1bxKzFGrudUPPMZ3GL2PU9RKaFDW5rCJsx+9lOHy4BLInmIpIy88v
	1LDnKtQYgoyT/Q5uWZU1tcPjyiMFYndw2/k36vYyZZ2fCI407hlyx+Nh16nlwnhpCbVhUkvR3UlZ3
	pQ5AmOavOWFsdDdO3+cm1o3K+21mlMolEDW4qFwlGhtz6+JsXYG5cexYtHKOpd6cIQ0dEdx4aUbWU
	WHmZlTU4V6wIjLLLo30MwE3G70jqM5K+uneA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tdQ9m-00000000GOX-3Vum; Thu, 30 Jan 2025 09:44:14 +0100
Received: from p5dc55198.dip0.t-ipconnect.de ([93.197.81.152] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tdQ9m-00000001mGz-2TUM; Thu, 30 Jan 2025 09:44:14 +0100
Message-ID: <8c4279dd244eed4b1a6ef7e2ea6dafac0b5fc79e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Remove IO memcpy and memset from sh code
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Julian Vetter <julian@outer-limits.org>, Arnd Bergmann <arnd@arndb.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 30 Jan 2025 09:44:13 +0100
In-Reply-To: <20250128101306.1475491-1-julian@outer-limits.org>
References: <20250128101306.1475491-1-julian@outer-limits.org>
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

Hi Julian,

On Tue, 2025-01-28 at 11:13 +0100, Julian Vetter wrote:
> Remove IO memcpy and memset from sh specific code and fall back to the
> new implementations from lib/iomem_copy.c. They use word accesses if the
> buffers are aligned and only fall back to byte accesses for potentially
> unaligned parts of a buffer.
>=20
> Signed-off-by: Julian Vetter <julian@outer-limits.org>
> ---
> Changes for V2:
> - Removed also SH4 specific memcpy_fromio code
> ---
>  arch/sh/include/asm/io.h |   8 ---
>  arch/sh/kernel/io.c      | 111 ---------------------------------------
>  2 files changed, 119 deletions(-)
>  delete mode 100644 arch/sh/kernel/io.c
>=20
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index cf5eab840d57..1e33a1c8b72d 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -268,14 +268,6 @@ __BUILD_IOPORT_STRING(q, u64)
> =20
>  #define IO_SPACE_LIMIT 0xffffffff
> =20
> -/* We really want to try and get these to memcpy etc */
> -#define memset_io memset_io
> -#define memcpy_fromio memcpy_fromio
> -#define memcpy_toio memcpy_toio
> -void memcpy_fromio(void *, const volatile void __iomem *, unsigned long)=
;
> -void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
> -void memset_io(volatile void __iomem *, int, unsigned long);
> -
>  /* Quad-word real-mode I/O, don't ask.. */
>  unsigned long long peek_real_address_q(unsigned long long addr);
>  unsigned long long poke_real_address_q(unsigned long long addr,
> diff --git a/arch/sh/kernel/io.c b/arch/sh/kernel/io.c
> deleted file mode 100644
> index da22f3b32d30..000000000000
> --- a/arch/sh/kernel/io.c
> +++ /dev/null
> @@ -1,111 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * arch/sh/kernel/io.c - Machine independent I/O functions.
> - *
> - * Copyright (C) 2000 - 2009  Stuart Menefy
> - * Copyright (C) 2005  Paul Mundt
> - */
> -#include <linux/module.h>
> -#include <linux/pci.h>
> -#include <asm/machvec.h>
> -#include <asm/io.h>
> -
> -/*
> - * Copy data from IO memory space to "real" memory space.
> - */
> -void memcpy_fromio(void *to, const volatile void __iomem *from, unsigned=
 long count)
> -{
> -	/*
> -	 * Would it be worthwhile doing byte and long transfers first
> -	 * to try and get aligned?
> -	 */
> -#ifdef CONFIG_CPU_SH4
> -	if ((count >=3D 0x20) &&
> -	     (((u32)to & 0x1f) =3D=3D 0) && (((u32)from & 0x3) =3D=3D 0)) {
> -		int tmp2, tmp3, tmp4, tmp5, tmp6;
> -
> -		__asm__ __volatile__(
> -			"1:			\n\t"
> -			"mov.l	@%7+, r0	\n\t"
> -			"mov.l	@%7+, %2	\n\t"
> -			"movca.l r0, @%0	\n\t"
> -			"mov.l	@%7+, %3	\n\t"
> -			"mov.l	@%7+, %4	\n\t"
> -			"mov.l	@%7+, %5	\n\t"
> -			"mov.l	@%7+, %6	\n\t"
> -			"mov.l	@%7+, r7	\n\t"
> -			"mov.l	@%7+, r0	\n\t"
> -			"mov.l	%2, @(0x04,%0)	\n\t"
> -			"mov	#0x20, %2	\n\t"
> -			"mov.l	%3, @(0x08,%0)	\n\t"
> -			"sub	%2, %1		\n\t"
> -			"mov.l	%4, @(0x0c,%0)	\n\t"
> -			"cmp/hi	%1, %2		! T if 32 > count	\n\t"
> -			"mov.l	%5, @(0x10,%0)	\n\t"
> -			"mov.l	%6, @(0x14,%0)	\n\t"
> -			"mov.l	r7, @(0x18,%0)	\n\t"
> -			"mov.l	r0, @(0x1c,%0)	\n\t"
> -			"bf.s	1b		\n\t"
> -			" add	#0x20, %0	\n\t"
> -			: "=3D&r" (to), "=3D&r" (count),
> -			  "=3D&r" (tmp2), "=3D&r" (tmp3), "=3D&r" (tmp4),
> -			  "=3D&r" (tmp5), "=3D&r" (tmp6), "=3D&r" (from)
> -			: "7"(from), "0" (to), "1" (count)
> -			: "r0", "r7", "t", "memory");
> -	}
> -#endif
> -
> -	if ((((u32)to | (u32)from) & 0x3) =3D=3D 0) {
> -		for (; count > 3; count -=3D 4) {
> -			*(u32 *)to =3D *(volatile u32 *)from;
> -			to +=3D 4;
> -			from +=3D 4;
> -		}
> -	}
> -
> -	for (; count > 0; count--) {
> -		*(u8 *)to =3D *(volatile u8 *)from;
> -		to++;
> -		from++;
> -	}
> -
> -	mb();
> -}
> -EXPORT_SYMBOL(memcpy_fromio);
> -
> -/*
> - * Copy data from "real" memory space to IO memory space.
> - */
> -void memcpy_toio(volatile void __iomem *to, const void *from, unsigned l=
ong count)
> -{
> -	if ((((u32)to | (u32)from) & 0x3) =3D=3D 0) {
> -		for ( ; count > 3; count -=3D 4) {
> -			*(volatile u32 *)to =3D *(u32 *)from;
> -			to +=3D 4;
> -			from +=3D 4;
> -		}
> -	}
> -
> -	for (; count > 0; count--) {
> -		*(volatile u8 *)to =3D *(u8 *)from;
> -		to++;
> -		from++;
> -	}
> -
> -	mb();
> -}
> -EXPORT_SYMBOL(memcpy_toio);
> -
> -/*
> - * "memset" on IO memory space.
> - * This needs to be optimized.
> - */
> -void memset_io(volatile void __iomem *dst, int c, unsigned long count)
> -{
> -        while (count) {
> -                count--;
> -                writeb(c, dst);
> -                dst++;
> -        }
> -}
> -EXPORT_SYMBOL(memset_io);

I'm not sure that I understand the motivation to remove hand-optimized sh4 =
assembler
code for memset and drop it in favor of potentially slower generic C code. =
What is
the reasoning behind this?

Also, it seems that this patch would make your other patch

	"sh: Remove memset_io from sh specific code"

obsolete.

Geert, do you have any opinions on this patch?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
