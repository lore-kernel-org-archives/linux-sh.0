Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADE1531C1
	for <linux-sh@vger.kernel.org>; Fri, 30 Aug 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005775; cv=none; b=Nk4RSusI6zZTUk4bicoYSwK2GXX+gjkSeEGf97OH8DclB80rGCF98ellzw83yCNpKG3ys9cdUWQBbpSgZ6Z5GrJqdj/qkvR3Q73zS+BUakXXhvu7BlAwgQtVi9RfF9VpT8JdGcMXBx0ArwgxRQXem5j07i75jBdNvyxlwYA5p/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005775; c=relaxed/simple;
	bh=EUJnuqvYUip9AQlxMsVRo6TfLLgD5FPy2fu5pH57aOw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KyPDJJxrCLd1MsgLYuCmJ2k5go2GDoV7voHROmSDHgXLBhhBvA6tYkXfS1mc5y6BEETIIrGPNDzxetmhcvu+XymBQqFRW2qb3yYSq2NRe10kYIMpNJK8yyIMUxqzqZI0HnFyVbNCbf7/c7xBMY4loD5Qt7NdpKitlKvx+uvcYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=QM2YGM7P; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="QM2YGM7P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MWRFUvwWUc6JbK4Fsiae0UkNOGoEhP1zp0ba1Lhfm2g=; t=1725005771; x=1725610571; 
	b=QM2YGM7PfmNZhEPtvT577z9Lh67K5oURc1fUL3eEqkmzGKXbWdr/g5daEZSTnqq+AmpeQrFIa3Q
	03A5T64GRMhCTkQR7cUcwhCGmg1XFzwSLh6LM1Pzgtvw/RYdIcU2cOHbme7RQ5Rp6bxI1og/RHp65
	cCFO7uwQDiiSWzodXzFEg1zvHkCz/0Xu9joZ++Lr4DoDxvDSCxzqX91PBtsUhi1pPu6ni3vMCQw5O
	RRYHsXHz2xfBARNNbszVk2xebIQLGsYAsEpjxQTv/f7h9/5EbSYqiqoyD00z31qLvQui9OXUW7D0i
	He4uBPZjeZf1zvlCltC1T0yz2vtdQ2eXDFlQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sjwna-00000000NZM-1QZW; Fri, 30 Aug 2024 10:16:02 +0200
Received: from p5b13a591.dip0.t-ipconnect.de ([91.19.165.145] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sjwna-00000003kGp-0bGq; Fri, 30 Aug 2024 10:16:02 +0200
Message-ID: <fe98fdea503e036c8d1e49b354b3921a592febd4.camel@physik.fu-berlin.de>
Subject: Re: [PATCH -next] sh: intc: replace simple_strtoul to kstrtoul
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Hongbo Li <lihongbo22@huawei.com>, ysato@users.sourceforge.jp, 
	dalias@libc.org, linux-sh@vger.kernel.org
Date: Fri, 30 Aug 2024 10:16:01 +0200
In-Reply-To: <20240830080401.3545399-1-lihongbo22@huawei.com>
References: <20240830080401.3545399-1-lihongbo22@huawei.com>
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

Hi Hongbo,

On Fri, 2024-08-30 at 16:04 +0800, Hongbo Li wrote:
> The function simple_strtoul performs no error checking
> in scenarios where the input value overflows the intended
> output variable.
>=20
> We can replace the use of the simple_strtoul with the safer
> alternatives kstrtoul. For fail case, we also print the extra
> message.
>=20
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  drivers/sh/intc/userimask.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
> index abe9091827cd..c9892338fc22 100644
> --- a/drivers/sh/intc/userimask.c
> +++ b/drivers/sh/intc/userimask.c
> @@ -33,7 +33,8 @@ store_intc_userimask(struct device *dev,
>  {
>  	unsigned long level;
> =20
> -	level =3D simple_strtoul(buf, NULL, 10);
> +	if (kstrtoul(buf, 10, &level))
> +		return -EINVAL;
> =20
>  	/*
>  	 * Minimal acceptable IRQ levels are in the 2 - 16 range, but

Thanks for your patch. I will try to review it and the other pending patche=
s
for sh-linux over the weekend.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
