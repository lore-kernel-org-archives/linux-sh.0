Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D51BC2A;
	Sat,  5 Apr 2025 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743874743; cv=none; b=Sc5TJPE6T7kWZTSg5/s8pvUsEH/Hcj5IwVYyqC2e9JnFgjelVCbIi4cYmg9fXxEl/tObKvTn7WtiYFRbbqQ+/qw8gNQgpAAXxdalWhckXzLDzDYYF4K378f5lXecw9ucXc5sZ8DOuDN4soYlGOuSXjx0ICJQYgNnWVT/A9fajQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743874743; c=relaxed/simple;
	bh=gX0ZLQEjnzU3TBvfxOtgjXwaDdYCJbrEpsKU8RAV1no=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hn04jAVc6F/eflHwsfiIpwCt491qb3Ju9vueiifR2+uTSNBlf1jo+fyasLBbYLJlmsgypbZN9a5uyFV9/Gpj1PxCkWElAkJK1Qn6ApJR1RO/vYnrCn6mL+pzBNI3rp68S9bd1VNyvHs3UEdXnCu50DxxTr0HnBIAKLEPguoFDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=gdgzTirl; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="gdgzTirl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WX9E6DgiY2D01qB2SzZpeJfoy+tNUxzhlIlzO5bFJoo=; t=1743874740; x=1744479540; 
	b=gdgzTirlr0KTpdqDC2l0cw8SQJcaK50iVN76+6fo+0p9Fd70DoSG8zmIoIizdM5/198wzCYBJB1
	EzgpLiodz/zcNI1XJp5nXiX+/5bp26mcIGx1+BUeIzKY5zFl7lcmrQ8cDd95gTyvYVTbG6pYqxd6F
	KQILRl2OFOlztXPFTN8wH0BWYiBZOAjh3t2NZAsc6MFn3G8DGcW8ZT9hM2peHwsMqRMMMo1saUOsh
	JsV8aei0Xqe25bHVESi2GR45qwrXwv04U1ZU302zVzROr4Jq5qNnHYd9ypEcJtp7+JGF97AlFyJzG
	pvSGuuIvAVCK5C6DGgT7LIbl/Ma/r+iJGcJg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u17Tq-000000045Ay-0u8m; Sat, 05 Apr 2025 19:38:54 +0200
Received: from dynamic-002-242-014-214.2.242.pool.telefonica.de ([2.242.14.214] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u17Tp-00000000dWk-48nP; Sat, 05 Apr 2025 19:38:54 +0200
Message-ID: <a3faf6820b43cca25c3384d0248f494be7312598.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Artur Rojek <contact@artur-rojek.eu>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Daniel Lezcano
	 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Uros
 Bizjak	 <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "D . Jeff Dionne"	
 <jeff@coresemi.io>, Rob Landley <rob@landley.net>,
 linux-sh@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Sat, 05 Apr 2025 19:38:53 +0200
In-Reply-To: <20250216175545.35079-2-contact@artur-rojek.eu>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
	 <20250216175545.35079-2-contact@artur-rojek.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Artur,

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
> +	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
> +		BSS_FIRST_SECTIONS
> +		. =3D ALIGN(PAGE_SIZE);
> +		*(.bss..page_aligned)
> +		. =3D ALIGN(PAGE_SIZE);
> +		*(.dynbss)
> +		*(BSS_MAIN)
> +		*(COMMON)
> +		. =3D ALIGN(8);
> +	}
> +	__bss_stop =3D .;
>  	_end =3D . ;
> =20
>  	STABS_DEBUG

I'll pick this up for now since Uros has confirmed that the compiler
won't just use SBSS without breaking the ABI, so I think to use this
fix for now.

If it breaks in the future, we can change it again.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
