Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F414B94F
	for <linux-sh@vger.kernel.org>; Thu, 26 Sep 2024 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353343; cv=none; b=OV2AL6J/OE5jyGiCXd+Euz0c2q4mV2Eh2XhkwsOaboQ6f+RFiVfEsVPfQUCMID4Vr6J91Q1X8YK2kgru4f20w6g5EHUFwdqtBgH2dnqLb1hHQdvLAYB4nwfte27eHUokBDbqAIrYMnKzdpdC5a5nEDn6Ra/tvfSSV4STmgEgXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353343; c=relaxed/simple;
	bh=goJxZQuqTHh6YoI/0CAGACqHn9CRRuFy7rc03XHSGVE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eInZ+AHYGLjvT6VIgq2oSdah3eSLrWyV8zQ34DFdb0kdi9mNU/aTvsgXiV6YyDTPfFwkLNxv3F8+YCTscX4P15tUNw/+IjYSpTvA7jj1F64Mx3e/CIlyvW2MJMxMsF53dlswbmRBv+iWoM0VmAQlbkTtEsr+4+p6F6it7A1yFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=lICQan9n; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="lICQan9n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zMbOfIf61xBcycJSwIBD1PhshMM6l+ifc8m/oNxY5U8=; t=1727353339; x=1727958139; 
	b=lICQan9nYdTC1r+7ZmY2+v5DPHsFr0/xDaZ4pYpj1hetNx8r7pD3NupsMjVuKqLzY4GFYP9Lu0E
	5J2a7OCbQhAIduxSVbmhWwINJn5GEeFFkfTjBHbGzKYmwNWW369+FVrdnjJZq9V+3teoXJdUbr4q0
	FWgNxR33rld575aJRSIDQVAJXzUHZHStbjyYfDQ6JSNqgqr6E6ujCWZxM5HanuL9vm9PM2qGuIoqs
	KKVrogyXiiT7Ra+Wg3xDkM4UrD1lNPr5qVZjJ2sBt8inU0fB1I4rxdCxpHTZBYDBIvKeR28h9Jaan
	YfFaZCvpHW3LzqZSgXyk+Gy8L+nmkel4WaLA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1stnVb-00000001f0I-03FV; Thu, 26 Sep 2024 14:22:11 +0200
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1stnVa-00000003HZX-3DHC; Thu, 26 Sep 2024 14:22:10 +0200
Message-ID: <399afcfa62ead32000837c6276d1243263449880.camel@physik.fu-berlin.de>
Subject: Re: [PATCH -next v3] sh: intc: replace simple_strtoul to kstrtoul
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org
Date: Thu, 26 Sep 2024 14:22:09 +0200
In-Reply-To: <20240902024534.2288168-1-lihongbo22@huawei.com>
References: <20240902024534.2288168-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Mon, 2024-09-02 at 10:45 +0800, Hongbo Li wrote:
> The function simple_strtoul performs no error checking
> in scenarios where the input value overflows the intended
> output variable.
>=20
> We can replace the use of the simple_strtoul with the safer
> alternatives kstrtoul. For fail case, we also print the extra
> message.
>=20
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>=20
> ---
> v3:
>   - Separate declaration and assignment to make it more consistent.
>=20
> v2: https://lore.kernel.org/all/20240831094310.4148930-1-lihongbo22@huawe=
i.com/T/
>   - Pass the error code returned by kstrtoul() suggested by Geert.
>=20
> v1: https://lore.kernel.org/all/98c7b473-0b2b-4e47-83f6-35d9f417bb01@huaw=
ei.com/T/
> ---
>  drivers/sh/intc/userimask.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
> index abe9091827cd..a363f77881d1 100644
> --- a/drivers/sh/intc/userimask.c
> +++ b/drivers/sh/intc/userimask.c
> @@ -32,8 +32,11 @@ store_intc_userimask(struct device *dev,
>  		     const char *buf, size_t count)
>  {
>  	unsigned long level;
> +	int ret;
> =20
> -	level =3D simple_strtoul(buf, NULL, 10);
> +	ret =3D kstrtoul(buf, 10, &level);
> +	if (ret !=3D 0)
> +		return ret;
> =20
>  	/*
>  	 * Minimal acceptable IRQ levels are in the 2 - 16 range, but

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks, I will pick this up later today. Sorry for being super late.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
