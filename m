Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC510958
	for <linux-sh@vger.kernel.org>; Thu,  2 May 2024 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645961; cv=none; b=iPZn0jzOXmfb9Gl1nW9prxueJ2c98BSuCa1WsMDZjad6kW/cBAGqLetIiGKIl3Y6D3wJGi/SKfntBcu2Jx5lwXwTLZTUrg9ctsXkV12gXK1H5OZtFXkAQ3rTYCzvZZPda/nzGwJIa5tAcNDXnNR5djCATKA/691+UUjMhZGM9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645961; c=relaxed/simple;
	bh=ZyC+pLjt/buTsbpXrxgxo49EIcqv3I7Q7KWyx04mcxM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t9UbEh3mXmNf3Jf9jayk15EvErMCVolgp9xgje0LgqUTAL7xe/YfBtWWd1z8Q06eZ1FNdfBY5hQ68JJ8zWhsOvQe+G5zJW7f/4JwA4r6xcVx1zvLIlqvEhz3lpruYUMfiBwsZZZW2s1YEsOPRWH4Lnzt4IH4dz7z5DHCHks+ijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=XIs6ae0u; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="XIs6ae0u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DbzXbEcL1ewg6WJqsWYeLrpxduJtJWQpoY2AwPSMPMI=; t=1714645959; x=1715250759; 
	b=XIs6ae0ujmtic5Q69jOnasaJfdnevnycZvKPNKpsd1YA1T0pQHlfdz4cv8VIegvPm6A0wHa/pGv
	v2Pd+o7kGHisKCEr/7i2xEQ0/OR9zFu4LXRxsEv62BXXzIOWsH4P5NiHPLRaRcZnAyguEF3dMWzlm
	oVkn14bwSwKR/lR4acL1L8MVZepzJmvtT40XFUU9yfYswib9Hr/uEXcyBAdMaYbt2GZ4EI6TakwkW
	XEgvrojAp5CCV54uYMomDmAvqt+XjPIawKx7MMmEEBy+W99S12VdwBF36qMWQwnyI2h6kiVk5OdOU
	RI4YN2MgVBqVA+jNvc6YXiQDgR3b/zYwVJAg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2Tjw-000000020bu-17hK; Thu, 02 May 2024 12:32:36 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2Tjw-0000000089p-0GVj; Thu, 02 May 2024 12:32:36 +0200
Message-ID: <eabe30da5daa45793fe798a202940f3d60d7ef4b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: boot: Remove sh5 cache handling
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Arnd Bergmann
	 <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org
Date: Thu, 02 May 2024 12:32:35 +0200
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

Applied to my sh-linux tree in the for-next branch.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
