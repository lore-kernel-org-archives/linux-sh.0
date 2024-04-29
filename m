Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480812E7C
	for <linux-sh@vger.kernel.org>; Mon, 29 Apr 2024 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376809; cv=none; b=Zs6K1kxt0q6f+SmAmR6sk1EGSLCNSjfGlmg1boysLQ+UfjDv4/Z/5Q/nRu3YfYHr499thPZ5qxMxigc5bLeAJBbhCIhd6jMV3++6o+vw2A2XeehVe/olFgdU89PbROUX79VgS9fwWehAU6osmL/5nIiKdVMrPvF2XiySTritSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376809; c=relaxed/simple;
	bh=bV0OgeouqCdXMw2QUlhph8G6MXVcjC0yPnDFwEqrCNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cbl8QT4N3CKWmdy08vJiLu89jVKkEDWztqHswbzLEBcWKod5+P5J5c1XlQfxzZaDRbrxvqgCTjLqztuiYweIONgl6dl+K1n14Ilw4ATPzRMgJ/JAUPlOZIRtxs2FI+g/YzXMiMRYe59Bm1wvC4FfdA1oW8JYx/RnvRnUPJTeVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=X3aBQ611; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="X3aBQ611"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tDZuwNJIH5+x096VUQm5yzkiWSplNR8GeyRgiavZf+0=; t=1714376805; x=1714981605; 
	b=X3aBQ611tGKnlsJE50WB/YjsiFb+dKzWGUXqP/GtMYw6IDHl8iJlZ5s3fXONbjISHGMblOVKMhi
	LP9v+o0grgiRbPLQ3XfZCUIkWVYrP+v52v6DqQSGyWwNXQlIBwQL94xffYHzk8/0ubE6m3U84Zfcy
	5846v9AewPn0+X9BK+LfYJhbbEYUyJMYCwWVfRj/A9x6Q7Q0WdTO9RuHMp8xgWfbd9yBkT9BKeWTa
	El5P/gnpxjWeAzCIqRwHkJhd37y7jg1X5cZ2TNpo2Ie81GJkV9UUJcf7taTyX+lOxdim46VEvdT03
	1I+MZbaeSMCAT2Zpsmyh4HfupMrrIpuJWBYQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s1Lij-00000003O8w-2d2a; Mon, 29 Apr 2024 09:46:41 +0200
Received: from dynamic-077-191-138-057.77.191.pool.telefonica.de ([77.191.138.57] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s1Lij-00000001C6l-1myc; Mon, 29 Apr 2024 09:46:41 +0200
Message-ID: <d5f53c4c490d0058956f6a501191107c4b148720.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: boot: Remove sh5 cache handling
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Arnd Bergmann
	 <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org
Date: Mon, 29 Apr 2024 09:46:40 +0200
In-Reply-To: <23e9b3fd0d78e46c9fc1835852ba226aba92c3ca.1713959531.git.geert+renesas@glider.be>
References: 
	<23e9b3fd0d78e46c9fc1835852ba226aba92c3ca.1713959531.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Geert,

On Wed, 2024-04-24 at 13:54 +0200, Geert Uytterhoeven wrote:
> Commit 37744feebc086908 ("sh: remove sh5 support") in v5.8 forgot to
> remove the sh5 cache handling.
>=20
> Suggested-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/sh/boot/compressed/Makefile |  2 +-
>  arch/sh/boot/compressed/cache.c  | 13 -------------
>  arch/sh/boot/compressed/misc.c   |  7 -------
>  3 files changed, 1 insertion(+), 21 deletions(-)
>  delete mode 100644 arch/sh/boot/compressed/cache.c
>=20
> diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/M=
akefile
> index 6c6c791a1d0630e2..54efed53c8918eef 100644
> --- a/arch/sh/boot/compressed/Makefile
> +++ b/arch/sh/boot/compressed/Makefile
> @@ -5,7 +5,7 @@
>  # create a compressed vmlinux image from the original vmlinux
>  #
> =20
> -OBJECTS :=3D head_32.o misc.o cache.o piggy.o \
> +OBJECTS :=3D head_32.o misc.o piggy.o \
>             ashiftrt.o ashldi3.o ashrsi3.o ashlsi3.o lshrsi3.o
> =20
>  targets :=3D vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
> diff --git a/arch/sh/boot/compressed/cache.c b/arch/sh/boot/compressed/ca=
che.c
> deleted file mode 100644
> index 31e04ff4841ed084..0000000000000000
> --- a/arch/sh/boot/compressed/cache.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -int cache_control(unsigned int command)
> -{
> -	volatile unsigned int *p =3D (volatile unsigned int *) 0x80000000;
> -	int i;
> -
> -	for (i =3D 0; i < (32 * 1024); i +=3D 32) {
> -		(void)*p;
> -		p +=3D (32 / sizeof(int));
> -	}
> -
> -	return 0;
> -}
> diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/mis=
c.c
> index ca05c99a3d5b488d..195367d40031f9e9 100644
> --- a/arch/sh/boot/compressed/misc.c
> +++ b/arch/sh/boot/compressed/misc.c
> @@ -26,11 +26,6 @@
>  #undef memcpy
>  #define memzero(s, n)     memset ((s), 0, (n))
> =20
> -/* cache.c */
> -#define CACHE_ENABLE      0
> -#define CACHE_DISABLE     1
> -int cache_control(unsigned int command);
> -
>  extern char input_data[];
>  extern int input_len;
>  static unsigned char *output;
> @@ -139,8 +134,6 @@ void decompress_kernel(void)
>  	free_mem_end_ptr =3D free_mem_ptr + HEAP_SIZE;
> =20
>  	puts("Uncompressing Linux... ");
> -	cache_control(CACHE_ENABLE);
>  	__decompress(input_data, input_len, NULL, NULL, output, 0, NULL, error)=
;
> -	cache_control(CACHE_DISABLE);
>  	puts("Ok, booting the kernel.\n");
>  }

Interesting, looking at boot/compressed/cache.c, it seems that the whole co=
de
is actually a no-op and does nothing but increasing a pointer. So I agree w=
e
should just delete it.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
