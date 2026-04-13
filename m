Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481352288CB
	for <linux-sh@vger.kernel.org>; Mon, 13 Apr 2026 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065488; cv=none; b=IO79bm5TWUV5KAvwFn7h8yVuIQQew08PliX7NL1JgnAK1shAoep1UOjVTa3WI7ykm1nFxVoDbvvWTVCK8U0iIzQVw0av30hPScxW1thHhRjxGYiEjN+UmydZXp/0poj0TWjJUSKQCooqFWFsnPHM30zF3yPU6j6d10nJ4GZ54NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065488; c=relaxed/simple;
	bh=KNkkABbndnxCNtVuXT6IkozEz0XVv0k+irch//1jJD4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pf2YVju0F1nwveKkpNaUfGsWYP0diIkkYU+jsMEBc4/6iMWq9oP9iwvOhlInHRcU5ZkYSbMTDyVuteumIoOJs9b8Judx/2G2wcyDhzytrnQJZg7R4heljkM/1YBbF3hM+ILB8rYd1y4qWMcp5iQA4ExIR8r1UaXV5oFwWx1AvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ZUdSnY3f; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ZUdSnY3f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3NRKg+X70w+bs9dJtQxcBsh/42zOSg1VzH57lZOv+uE=; t=1776065486;
	x=1776670286; b=ZUdSnY3flvdLkXdbqQkCt7VlBkV5gEFYM9/WUCWJ5frKz3DqGk6yhSuwSmfAE
	6IpI2/LsGPTfoCY+GF1OTEk7CGqy14VnedfvWT96QYoTTnB/9Zftctuj0BbcBbkz3VE+3N5n2Vyst
	63ruXM2ygAL7DVcEBqAezctpl2phEfk6HvJotONSZF7erSHyloM3WW71jHUAvvlwlfdayafSL6RiO
	Zw8UQgC2/FEhBShu/nlM5FeBXqv977B+17OeNjDKDY1RfLS6WUoOz552e9ujPZVT+lyDzVIvFXnQK
	46cfCco+o0EBaBEAq1KVIWijPWN+OIKmIW47n5Cn0bJGKgcdyg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wCBlT-00000003jm6-47EX; Mon, 13 Apr 2026 09:31:24 +0200
Received: from dynamic-093-128-043-080.93.128.pool.telefonica.de ([93.128.43.80] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wCBlT-00000001Bb2-3Am4; Mon, 13 Apr 2026 09:31:23 +0200
Message-ID: <7f1993d2161dc50bbb5cf5c1d6db0aef0d5c4f1d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] arch: sh: Include <linux/io.h> in dac.h
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Zimmermann <tzimmermann@suse.de>, ysato@users.sourceforge.jp, 
	dalias@libc.org, lee@kernel.org, danielt@kernel.org, simona.vetter@ffwll.ch
Cc: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel test
 robot <lkp@intel.com>, Jingoo Han <jingoohan1@gmail.com>
Date: Mon, 13 Apr 2026 09:31:23 +0200
In-Reply-To: <20251028170913.16711-1-tzimmermann@suse.de>
References: <20251028170913.16711-1-tzimmermann@suse.de>
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

On Tue, 2025-10-28 at 18:07 +0100, Thomas Zimmermann wrote:
> Include <linux/io.h> to avoid depending on <linux/backlight.h> for
> including it. Declares __raw_readb() and __raw_writeb().
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510282206.wI0HrqcK-lkp@i=
ntel.com/
> Fixes: 243ce64b2b37 ("backlight: Do not include <linux/fb.h> in header fi=
le")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Daniel Thompson (RISCstar) <danielt@kernel.org>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <danielt@kernel.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
> This is fallout from a recent cleanup of the backlight header file. I don=
't
> have the option of building or testing this change, though.
> ---
>  arch/sh/include/cpu-sh3/cpu/dac.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/sh/include/cpu-sh3/cpu/dac.h b/arch/sh/include/cpu-sh3/=
cpu/dac.h
> index fd02331608a8..323ec8570bcd 100644
> --- a/arch/sh/include/cpu-sh3/cpu/dac.h
> +++ b/arch/sh/include/cpu-sh3/cpu/dac.h
> @@ -2,6 +2,8 @@
>  #ifndef __ASM_CPU_SH3_DAC_H
>  #define __ASM_CPU_SH3_DAC_H
> =20
> +#include <linux/io.h>
> +
>  /*
>   * Copyright (C) 2003  Andriy Skulysh
>   */

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Will pick this up today for v7.1.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
