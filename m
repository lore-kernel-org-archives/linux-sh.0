Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66405148832;
	Thu, 30 Jan 2025 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225930; cv=none; b=vFHoFW4XzxcrWvFZlDNaJAiTyFkO7KPLJnQeFkdHRW+Ddz5OYYK1xYttr43STCo/uEt2xPJj+PNXj5gRVtBf00G5JhmEasDJ9wdbcfhKzQBzUAFJXEVo4klw66Slj0kDnf4oPN+H0OtN/HxWCFMSvkYxOhbwP1l50a7gAPxiZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225930; c=relaxed/simple;
	bh=ch0mvzHl7BtRiR+ehcr7+FmBj2pnIcAvO/xV3NS3aMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aQQ0sRkxvZEDM8mszL+s9TiJ5CEcxFCQOURnRdy8DmZ9gG9+QusQuVYO27TUpguP812QAe2Ff5atHN7TncV6HHiaVP5S9FugdKN2GW6x9MaeMY83hvPFKcvzuQNHZQVS/hibRVTWnd+j1cookQoHXOrYqSvEeVGW79zlV3yAvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=N4wWQj1C; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="N4wWQj1C"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ul7+mqvJN+pEzAZI3KgN5ZCGEQWBECJtRWmuoSN3Ln4=; t=1738225928; x=1738830728; 
	b=N4wWQj1CVi//bhpXC8PV5L+bUKBmL80KHPjuqUOoawTe7V6K6OVYvIXc16w+xNz78ripc3zvwr/
	k02CJ5y90yUFc/fgPiBL414I4VGo6bn0+LhQZt1wrAkGMj3o6qPabYxjdLHXqVVONsJKU/pglJFqk
	VL+SwhkwuYIhKQrD5ctuNl1aRBKs12R8XSB6QRiPvuEazi6fH3+rLC2mjL35Hd2zquDzWCmLyfpoI
	y+wZvvVj8KD3LRqHY6xk2XfjUjg96OSNIIhfI6uCwADXg5+UlH6I30Q6fMvUz9TZWoBEj1v8BDfSf
	bhbHxyFpb1irtNy3+iXoYFERSNxusqgEHu6Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tdPy1-00000000CAQ-29Q6; Thu, 30 Jan 2025 09:32:05 +0100
Received: from p5dc55198.dip0.t-ipconnect.de ([93.197.81.152] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tdPy1-00000001jkB-17z8; Thu, 30 Jan 2025 09:32:05 +0100
Message-ID: <3ec5a6621cabddad686f727d20b725ed9658dddd.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Remove memset_io from sh specific code
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Julian Vetter <julian@outer-limits.org>, Arnd Bergmann <arnd@arndb.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 30 Jan 2025 09:32:04 +0100
In-Reply-To: <20241204164020.48361-1-julian@outer-limits.org>
References: <20241204164020.48361-1-julian@outer-limits.org>
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

On Wed, 2024-12-04 at 17:40 +0100, Julian Vetter wrote:
> Remove memset_io from sh specific code and fall back to the new
> implementation from lib/iomem_copy.c. It uses word accesses if the
> buffer is aligned and only falls back to byte accesses for potentially
> unaligned parts of a buffer (i.e., at the beginning and end).
>=20
> Signed-off-by: Julian Vetter <julian@outer-limits.org>
> ---
>  arch/sh/include/asm/io.h |  2 --
>  arch/sh/kernel/io.c      | 14 --------------
>  2 files changed, 16 deletions(-)
>=20
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index cf5eab840d57..3771bfa984af 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -269,12 +269,10 @@ __BUILD_IOPORT_STRING(q, u64)
>  #define IO_SPACE_LIMIT 0xffffffff
> =20
>  /* We really want to try and get these to memcpy etc */
> -#define memset_io memset_io
>  #define memcpy_fromio memcpy_fromio
>  #define memcpy_toio memcpy_toio
>  void memcpy_fromio(void *, const volatile void __iomem *, unsigned long)=
;
>  void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
> -void memset_io(volatile void __iomem *, int, unsigned long);
> =20
>  /* Quad-word real-mode I/O, don't ask.. */
>  unsigned long long peek_real_address_q(unsigned long long addr);
> diff --git a/arch/sh/kernel/io.c b/arch/sh/kernel/io.c
> index da22f3b32d30..16e963bab595 100644
> --- a/arch/sh/kernel/io.c
> +++ b/arch/sh/kernel/io.c
> @@ -95,17 +95,3 @@ void memcpy_toio(volatile void __iomem *to, const void=
 *from, unsigned long coun
>  	mb();
>  }
>  EXPORT_SYMBOL(memcpy_toio);
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

Looks good to me. I looked up the generic implementation in lib/iomem_copy.=
c and
it looks much better than the sh-specific implementation due to the smarter
use of conditional word-long memset.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
