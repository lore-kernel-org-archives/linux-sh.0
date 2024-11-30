Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4A13C3F2;
	Sat, 30 Nov 2024 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732970273; cv=none; b=syeGGmQIQVevUzRY+QUa/+YkHEgvUfnZlPRNATaWmI3JfNG7NVKmsQi569tW1NoIbTyED9znW/5D9k4n07fGcq98btkSQZhyJunRLtNQRUdx5G2CiUybDcRo0otz0r140sAJMlTQu7yRgK84hdQkyF1lE1gX/ba8KotCRzmdc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732970273; c=relaxed/simple;
	bh=cqmwpE05jcRxahXQsGJddxblblVsKmdf3yv5j1OMS5E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jxH4LP7rwatSK/gzG7FUIFAaOTmXVf8z4pKEgp1a07mqFbWwfsHuHIGIlwMpY1x3IcWf1mEnH4Ps9491oTWagtHefs6RgHjuUs/2GLpPBWTV+4V0DJsoYtBsD2WxwGywjJeJ02mdJvk/wPJIdeMaJ0hUwBZJ/Ofm4ruvjK/Tq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=WMzOClkf; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="WMzOClkf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8ThFtq2aKx05po/IQguAUwmmTNf7jjwGpVPevN1GAa8=; t=1732970270; x=1733575070; 
	b=WMzOClkfAlwO3dl1duymNhTUYW+dFeFDqOdwTGYwWnuc8kB+ybZsxIc8XcWaXzfgT+2IyH98cg4
	ysqDLL3Nv0tdQ0HWlppa6Q4ltDiW5jD9ZwDwjHV3/RJr3C95ZcBw9rNgJFiyhKxkdeqoJmp/l+b6b
	M5Ho3iW7LkLcntDH3Y5lzzU98Rw4Bbtj5aLIbipzQioV56aQ89S1SHHvaUEIIYAXTSOuIOT1Jm+5V
	ecsmGv2s+GoRiHoabfnxlD4WKbzG+v+IjI2Ln/bcyQnhWqffQ673s5s6Gw9VILuuEZiJzlLyYCZ69
	z47yP6J/4oO+Xgx6tIVkPfzV85lfex3G/1yg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tHMjI-000000042Nj-3qVI; Sat, 30 Nov 2024 13:37:44 +0100
Received: from dynamic-078-054-081-111.78.54.pool.telefonica.de ([78.54.81.111] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tHMjI-00000001S6a-2xWa; Sat, 30 Nov 2024 13:37:44 +0100
Message-ID: <b24df2978b61101e34a6b7116c942a1b0d6bc434.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: use after free in register_intc_controller()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dan Carpenter <dan.carpenter@linaro.org>, Magnus Damm
	 <magnus.damm@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  "Ricardo B. Marliere"	 <ricardo@marliere.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  Paul Mundt
 <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	kernel-janitors@vger.kernel.org
Date: Sat, 30 Nov 2024 13:37:44 +0100
In-Reply-To: <45ff88d1-b687-43f4-a022-4e07930cd2d0@stanley.mountain>
References: <45ff88d1-b687-43f4-a022-4e07930cd2d0@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Wed, 2024-10-23 at 11:41 +0300, Dan Carpenter wrote:
> In the error handling, for this function, we kfree(d) without ever
> removing it from the &intc_list which would lead to a use after free.  To
> fix this, lets only add it to the list after everything has succeeded.
>=20
> Fixes: 2dcec7a988a1 ("sh: intc: set_irq_wake() support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This patch is highly speculative and I am not able to test it.  Please,
> review with care.
>=20
>  drivers/sh/intc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> index 74350b5871dc..ea571eeb3078 100644
> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c
> @@ -209,7 +209,6 @@ int __init register_intc_controller(struct intc_desc =
*desc)
>  		goto err0;
> =20
>  	INIT_LIST_HEAD(&d->list);
> -	list_add_tail(&d->list, &intc_list);
> =20
>  	raw_spin_lock_init(&d->lock);
>  	INIT_RADIX_TREE(&d->tree, GFP_ATOMIC);
> @@ -369,6 +368,7 @@ int __init register_intc_controller(struct intc_desc =
*desc)
> =20
>  	d->skip_suspend =3D desc->skip_syscore_suspend;
> =20
> +	list_add_tail(&d->list, &intc_list);
>  	nr_intc_controllers++;
> =20
>  	return 0;

I think this approach is more sensible than the one suggested by Ridong Che=
n
and I'm therefor egoing to pick this one over the other solution.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
