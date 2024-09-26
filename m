Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E529474
	for <linux-sh@vger.kernel.org>; Thu, 26 Sep 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353586; cv=none; b=nb+btFW4J4P0W/cdkZOdU6CDQnjdPkkldl/OMGZLnIYap28EWe0yVAcX1cEbRpN6AFNJqGzw+UNYMXGKd58hLmjIyXk4YjX2CyP/K08p0grsakDikTS7LzrVOwRHWWq731f8hkiCreWwKRHFEwkuuesOLxrVibuJrhdHsanCfng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353586; c=relaxed/simple;
	bh=Fvb7ERbtMe0R8fm5xDOHj9mOCZNhPUeIKklgkBgAbis=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EsLrf64knSMl4eHyatyX4UrAVBGEgTg2Qbmq5nrqIiEnSmEIb8NQQKYOKdU1YJL3Pe3t2lbZmOde7/JynigL/Hs83jXZWN7j0/xoxtOTIF8eBabAukLvLdClqsOCWlhhvFcHhvy16jJH02XIUG8JdXNypMPrcmDfN27kCLSkF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=CmXxrRnF; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="CmXxrRnF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WQ4iGy3BP3shX65zmw8+uGLw29l/A15FpqeCBFcYozA=; t=1727353583; x=1727958383; 
	b=CmXxrRnFMKKcjKorLOVK7eo877pCSPApad1UN64JoZ82idLrDbeErTA3MnIuVEiuE7Q8wv5BkHj
	F7ur0ENcVMxXdUMhwJ4mm/eQ8duym1+/2q4gpe4A+6IGPbKnJiaCwN/oaBK5PVdynrCBrG3k043yl
	DL2ckYLSbvKtmGmilY8EKIp2FNPVCFMq90cCftN8WQxUIfxO58sJB6CkhT9iXtXRCtvpQ/mlUTXWA
	dJhpO41eicyf1K4mNOuY4u/HuQyPiiAWGyFx7bSuF24esHj6WlIK6a+hBKdMUsnqYucqo3HDxLGPB
	vMMmOQHf9YHO0t0vYsknmebA2lsha1Vnxz4A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1stnZd-00000001gm6-2urn; Thu, 26 Sep 2024 14:26:21 +0200
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1stnZd-00000003ICi-23ag; Thu, 26 Sep 2024 14:26:21 +0200
Message-ID: <95401772af7f0d8ce83e608463b245fca9e565f4.camel@physik.fu-berlin.de>
Subject: Re: [PATCH -next] sh: Remove obsoleted declarations for
 make_maskreg_irq and irq_mask_register
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, dalias@libc.org
Date: Thu, 26 Sep 2024 14:26:20 +0200
In-Reply-To: <20240824120609.2519181-1-cuigaosheng1@huawei.com>
References: <20240824120609.2519181-1-cuigaosheng1@huawei.com>
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

On Sat, 2024-08-24 at 20:06 +0800, Gaosheng Cui wrote:
> The make_maskreg_irq() and irq_mask_register have been removed since
> commit 5a4053b23262 ("sh: Kill off dead boards."), and now they are
> useless, so remove them.
>=20
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  arch/sh/include/asm/irq.h | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
> index 0f384b1f45ca..53fc18a3d4c2 100644
> --- a/arch/sh/include/asm/irq.h
> +++ b/arch/sh/include/asm/irq.h
> @@ -13,12 +13,6 @@
>   */
>  #define NO_IRQ_IGNORE		((unsigned int)-1)
> =20
> -/*
> - * Simple Mask Register Support
> - */
> -extern void make_maskreg_irq(unsigned int irq);
> -extern unsigned short *irq_mask_register;
> -
>  /*
>   * PINT IRQs
>   */

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks for catching this. Will pick this up later today.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
