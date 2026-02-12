Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053212CDBE;
	Thu, 12 Feb 2026 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924968; cv=none; b=osCR2mOOrjhFN03CMYk1rEWJiVzC8AsJUCftjepaEC2A7eS4lEEb5Y7ZBj1cFvj/I+2L6NDYYOdPBQCIpIvV4dEB/lge+FxAOjsLLImaUvhPu3V3Fo2Eukk1e5N0bMUKzIHaTPz77so8NRxcbPvJ43A74QCabpF3bl0anr0JnNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924968; c=relaxed/simple;
	bh=KfM+s7SQ5SKmSdgaEY85eOdeH7XQXBEc6rghbA0pOck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVO4iOwZYPYyU6aKvtj94Tp42ngwAk/L4nXbuAYIYxQGZdLOS/cytE5E+e5i7plc836iBOALP6RedRj1OMnyHMmPyltqhLXBAEIoWrFsIemn7slhKT89W8yHmRYpfTUxmqA1YqTiWSudYpm1bVhqeg0PBsso9xEKJqAMSy9dqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=kF9mpu5I; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="kF9mpu5I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=G731gbEE0iHKq8x1F16GTxZVd65HOZV//8C8CP5y4RE=; t=1770924965;
	x=1771529765; b=kF9mpu5IuBJLiOIJtz+/MdzDhRzcIORSkHpcERSgjyEZj+rP0L+3a5Nht2lJ3
	ejN8Kd1fOBjjt4Z/3LPz/cxCXOilErz1rR6Lq/tteDasaxGP6f1ntzCNq6uxZ6ZIJ5DlbJ8Nl45ku
	IT5aSgLHa2z/A13bi12x9Paa/aIyEpKsHPYoLYIcVWGSeSIVkhCvmq7MfplMbeBwjydDjvk+CFFEw
	WZ5YJLXo1Zg6mwLLpLEx+bqMPu88fwX13jVFNV7LB0i96Ltd1tTpda4W0HEQU6bfCAmmK26PaZHxz
	fNelwV+/HQ4kCVEiehDj8tVPL/HNBYZjWuSHaGh9WUgKu+9kng==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vqcTk-00000002Bpd-2Hq5; Thu, 12 Feb 2026 20:35:56 +0100
Received: from dynamic-078-054-121-229.78.54.pool.telefonica.de ([78.54.121.229] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vqcTk-00000003yOD-1Llg; Thu, 12 Feb 2026 20:35:56 +0100
Message-ID: <aa9b1e8c41a3160ea51616e959986880e565f726.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: fix typo in SPDX license id lines
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Tim Bird <tim.bird@sony.com>, brgl@kernel.org,
 ysato@users.sourceforge.jp, 	dalias@libc.org
Cc: linux-spdx@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 12 Feb 2026 20:35:55 +0100
In-Reply-To: <20260212192845.3724287-1-tim.bird@sony.com>
References: <20260212192845.3724287-1-tim.bird@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Tim,

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

Thanks for your patch! Those changes are trivial enough to pick them up eas=
ily.

Being an old-school Sony fan, I'm honored to have someone from the company
contribute to my kernel tree ;-).

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
