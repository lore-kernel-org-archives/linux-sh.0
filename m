Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23F199931;
	Sun,  3 May 2026 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777818856; cv=none; b=NxzIYd58owA4Njtvo0GlT0GCutaHA+rpv1Ig9OCUdtiyWvy0+8zotJyuCvtmuzcCUbR84oAiXH505uFJwmI+fAvmRLIeWEDyE5WRm+AbadKp/3QYqbNhNIXFS+cbj5Ra+8xMoT/iqDKJtkHkpacWAZX+CPCu3Fk4jILCdqx2Xxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777818856; c=relaxed/simple;
	bh=5mijpzeXUp0nARvDkmWxIPsvJT6UAdbGJmo7nJ3ANHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QpkNfbvPS32Dqo62B9Td83Zt099cnv9jTVF36GvNLRlLIeZGwYc/UOWPR9x/hI9Zt8WeSY1mUtpQMAnx9myiaoO2HNB8YrUDn9dcDCR7kv9XNpz0Xo9l6qBZtEbq7qVkweKedZ/bMhbJ3Jx1iUTElGm4E5tPUkd4oeasfhUGLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=RapSNa8J; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="RapSNa8J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=7P9KZV0Wb/AUHnKWYFgkpkhT1o2rfhdFuoqlUP8QvMU=; t=1777818853;
	x=1778423653; b=RapSNa8Jno+HfsrT8vr+kXADzYnFkc1R7vWkjg7SjB/UQZSXScnGkV9RGtU5K
	z0+1nzNWglmvdB7xMazCRfLqtco+mosqetw/N2932vdPLHY+XixhBu41xLaUIoCjrAuhv/wuiLJeU
	NR0+1Hy2DSFskbpvKCLkDRl0JMf05L84ib1S7ODiwQPo4RdtQvWVDXmtU9TCKephJPhAVUVbl/PrY
	cjwNimQU0v92dfPLlf/Ff1r36/u4q4IO/olKXayPZ21gSBpF15Gnau6roE3FIwWK1eK/74U4woC0j
	Lil3TqH5xP7EuSKgm/aObMi87aXiA77kvpCZNi1mu5W7R5PuEA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wJXta-00000002kDZ-3FBS; Sun, 03 May 2026 16:34:10 +0200
Received: from dynamic-077-183-073-066.77.183.pool.telefonica.de ([77.183.73.66] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wJXta-00000003kPg-2K6v; Sun, 03 May 2026 16:34:10 +0200
Message-ID: <d9fb7ed01fb79585f64f7f87f56f40290838f3ea.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: fix fallout from ZERO_PAGE consolidation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, Thomas Wei?schuh	
 <thomas.weissschuh@linutronix.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, 	linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org
Date: Sun, 03 May 2026 16:34:09 +0200
In-Reply-To: <20260417103208.1217010-1-rppt@kernel.org>
References: <20260417103208.1217010-1-rppt@kernel.org>
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

Hi,

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

I can't test the patch myself now as my custom J2 toolchain is choking on b=
uilding
the latest kernel from git. But the change looks good to me, so I'm going t=
o merge
it now and send another PR to Linus.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
