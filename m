Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A892620DE;
	Tue, 11 Mar 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714119; cv=none; b=J5xKgJgxMxGvrJ4zbelJCiDJ6DYtBNVIWh1OiA7+3JIA5ej2lkCqb9LvG4IPBJIBgTdrWr3aUlO0L3C9rDvruSJpyDlB5RkkIHxIRxQsRGDDFtCCDN+IbFMNtZeCi+tKbynaJd+Utl9KGz/8ZOdpXw851HbXfjriuwIiqqbFN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714119; c=relaxed/simple;
	bh=8OvrgAK4xLIsj/a5xMSNqnZecSF2BxEBWVyv2PJU1S0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bvz7PpVvGYCFSPB7iq00bruvuTnfPWUgKZoeu1v8UkI12t9ejJ2BnOZdB40xB5XyPCft4bVUlY/HFzwxHf36jB+cGSHkrWyllPU2450dZFFz5DVbGjq86q0vBfQIizo7UzpLskjfjO5+KVUClf03Hn7i1gzGRVfEwQR88PoIHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=U7VHwfyu; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="U7VHwfyu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R3woneJO94f1gjNyTPFSTl76l/9HRC9Xkhxbfr4CZns=; t=1741714115; x=1742318915; 
	b=U7VHwfyupwOFyw20uc9uuDauMO1mGrRB5Z8aLaxTS/cSJ+jPjhfW7rv1hdhM1L227JcwLYGdsQH
	w1hhvRDcQGmpdcIxZtVH7/G5BglqRL/1NvrLjir1ARYBfaagC5XzEFrTAGLderdUOmFbV+ZJl8RJT
	62NTvkxvk+WVvEj2TCegeq2RPym+MXjYjwqtOq0jtN1EXVVcS3kh5WcMDvycA5t7D3CUXgyQA/qbo
	5U5c7q0LDYz4PGQoIGrElT6bp1CNDnJfD3HpBEj7Awi7LzUc2uJrT/a1p7j3mdbjJbf7QuteV/WAp
	MiBXtThUWqEP/d7SKaDgHPgKiSNtBnlGMdnw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ts3Ow-00000002kOR-0zL9; Tue, 11 Mar 2025 18:28:22 +0100
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ts3Ow-00000002LtA-01Xk; Tue, 11 Mar 2025 18:28:22 +0100
Message-ID: <5365422a9715376c76a89e255c978fc39064e243.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Artur Rojek <contact@artur-rojek.eu>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Uros
 Bizjak	 <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne"	
 <jeff@coresemi.io>, Rob Landley <rob@landley.net>,
 linux-sh@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 11 Mar 2025 18:28:21 +0100
In-Reply-To: <20250216175545.35079-2-contact@artur-rojek.eu>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
	 <20250216175545.35079-2-contact@artur-rojek.eu>
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

Hi Artur,

I'm currently trying to review this patch, but I'm not 100% sure how it
this change helps grows the .bss section, see below. Maybe you can help
me understand what's happening.

On Sun, 2025-02-16 at 18:55 +0100, Artur Rojek wrote:
> J2 based devices expect to find a devicetree blob at the end of the bss
> section. As of a77725a9a3c5, libfdt enforces 8-byte alignment for the
> dtb, causing J2 devices to fail early in sh_fdt_init.
>=20
> As J2 loader firmware calculates the dtb location based on the kernel
> image .bss section size, rather than the __bss_stop symbol offset, the
> required alignment can't be enforced with BSS_SECTION(0, PAGE_SIZE, 8).
> Instead, inline modified version of the above macro, which grows .bss
> by the required size.
>=20
> While this change affects all existing SH boards, it should be benign on
> platforms which don't need this alignment.
>=20
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  arch/sh/kernel/vmlinux.lds.S | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
> index 9644fe187a3f..008c30289eaa 100644
> --- a/arch/sh/kernel/vmlinux.lds.S
> +++ b/arch/sh/kernel/vmlinux.lds.S
> @@ -71,7 +71,20 @@ SECTIONS
> =20
>  	. =3D ALIGN(PAGE_SIZE);
>  	__init_end =3D .;
> -	BSS_SECTION(0, PAGE_SIZE, 4)
> +	__bss_start =3D .;
> +	SBSS(0)
> +	. =3D ALIGN(PAGE_SIZE);

What this effectively does is removing ". =3D ALIGN(sbss_align);" first fro=
m BSS_SECTION().

Then it inserts ". =3D ALIGN(PAGE_SIZE);" after the "SBSS(0)".

If I understand this correctly, SBSS() inserts a zero-padding and if I'm no=
t mistaken,
inserting ". =3D ALIGN(PAGE_SIZE);" will cause this padding to grow to at l=
east PAGE_SIZE
due the alignment.

Is this correct?

> +	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
> +		BSS_FIRST_SECTIONS
> +		. =3D ALIGN(PAGE_SIZE);
> +		*(.bss..page_aligned)
> +		. =3D ALIGN(PAGE_SIZE);
> +		*(.dynbss)
> +		*(BSS_MAIN)
> +		*(COMMON)
> +		. =3D ALIGN(8);

If my understanding above is correct, why do we will need an additional ". =
=3D ALIGN(8)"
here?

> +	}
> +	__bss_stop =3D .;
>  	_end =3D . ;
> =20
>  	STABS_DEBUG

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
