Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08466263C8C;
	Sun, 19 Apr 2026 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776619073; cv=none; b=Uy6elufMQh5vCmfO594k6VVimsoiwYUXi17PrRiWLUNVbyzUW3Z393zrSbvddd+X9K/m3Wx77pXGFXav7RJeKwltR9HEWaEuylyOlPriNPL2JVAPC5iE7WgFEd4XjcDpfiBfaDsVtEB6aYxSlwDrMZtoZUh2grOHh+HemEKVfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776619073; c=relaxed/simple;
	bh=ZorxSBM7MjtoSa0ef51N1NdlHRkgAzNSbwAkkmkLKLU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OmOdzeRiusxJgQVynGJ6O7Mc3ebfrcsSbmnyiNEIjBdClIEJFjcWJKe61rXgF+LzI4T4qaxbwo/MSp4YDmToP24jYX1+9HC541T3jDUtXdthtdeLeX2FB9ABo/H2upoDrnYAMZlwuokcky0iOaHRLy0lVsZuH8OnyvhLIDTKZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 103A93ED5C;
	Sun, 19 Apr 2026 17:17:47 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Apr 2026 19:17:47 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gdrom: use strscpy in probe_gdrom_{setupcd,setupdisk}
In-Reply-To: <20260417140349.554098-3-thorsten.blum@linux.dev>
References: <20260417140349.554098-3-thorsten.blum@linux.dev>
Message-ID: <3c586ec9ba35dab3a8ec1a3bfb80e55b@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Cause: dmFkZTEBDTopw/qSFkhPlV2PPeoyMGkfXEMe/v8xf1rb2CSYZHduS4UA1VZFq+mwNmnUb4nJaWCDwSsuanNoJ5am6uR++G6kuYD84QPmHgbPt/kQeHCy710/uYfGpbKUfUUUC8g46O/5oWDQMBYH0zk+/YPBvM9yoDezeRrYajKMVlKZ22qSfX392GPGtkqSP0TtPAbPCK5WucjOln9AneKTGnAk1piPj3t8xH6styeRaELKDW0ZJLG+GUJNE7+g3tF+jkhyUXoaOJkz2mzhwyczkJN2rx7i0QZiPcpyl46yxbzivCEztoSp9QVCqoIPpHiHJ03bDsY8oDelZznJVPU+oDUFCZ5qnawRhThpG4h8P0jg22pI875gcRou0Yvh0iovJkGOxr0JSGcKhqE/pl0KyGg/uYVWY3dYs9h5thC3U5MfX/jhSPs+doMHfjufuvDqqcIZGLR1WTqXOIYvRfWzSU5d1xjFOwpLXkSrHlwQdumnJpCpZrfEZdGaPT3xLWIuZ2jo+ywyxvfoUUyG9iUv5/jl5535DCwSgl/3FnFee9AhB+zUfV34hdKZg4PZSKXfTtFL6DtdNpzpK02bmtlwcPHTaRtyHmoMe03UaPXsP7kPCXMad0HmThzXFZwXT99BPI3RHG3hKxffqZCaCSmuICvRqhgdS5D4Z2f0PvyvoFdCdQ
X-GND-State: clean
X-GND-Score: -100

On 2026-04-17 16:03, Thorsten Blum wrote:
> strcpy() has been deprecated¹ because it performs no bounds checking on
> the destination buffer, which can lead to buffer overflows.
> 
> While the current code works correctly, replace strcpy() with the safer
> strscpy() to follow secure coding best practices.
> 
> ¹ https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Hey Thorsten,

tested on real hardware. LGTM.

Acked-by: Artur Rojek <contact@artur-rojek.eu>

> ---
> Compile-tested only.  Adding arch/sh/ maintainers since that's the only
> platform where this driver can be used.
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> ---
>  drivers/cdrom/gdrom.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index 4ba4dd06cbf4..5768dc1aebc0 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/cdrom.h>
>  #include <linux/bio.h>
> @@ -708,7 +709,7 @@ static void probe_gdrom_setupcd(void)
>  {
>  	gd.cd_info->ops = &gdrom_ops;
>  	gd.cd_info->capacity = 1;
> -	strcpy(gd.cd_info->name, GDROM_DEV_NAME);
> +	strscpy(gd.cd_info->name, GDROM_DEV_NAME);
>  	gd.cd_info->mask = CDC_CLOSE_TRAY|CDC_OPEN_TRAY|CDC_LOCK|
>  		CDC_SELECT_DISC;
>  }
> @@ -719,7 +720,7 @@ static void probe_gdrom_setupdisk(void)
>  	gd.disk->first_minor = 1;
>  	gd.disk->minors = 1;
>  	gd.disk->flags |= GENHD_FL_NO_PART;
> -	strcpy(gd.disk->disk_name, GDROM_DEV_NAME);
> +	strscpy(gd.disk->disk_name, GDROM_DEV_NAME);
>  }
> 
>  static int probe_gdrom_setupqueue(void)
