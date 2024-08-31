Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1EB658
	for <linux-sh@vger.kernel.org>; Sat, 31 Aug 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725127681; cv=none; b=qS0/Z2zqc8MpVd6VNkdmxHKvAAo+eNCgqZQP628ZvPjlmX2Jb/P8LFoGYxo/ORcSlUjqRlb1e2htLS3zlGCRK0LG1Qp50zkDPPRRKuYAcmVc/1Rb1ynyh8Ft/t+IlOc4cd+fekrTXaJzgpifAhJG0EQCFjaSNZmJTjBsrIT1iCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725127681; c=relaxed/simple;
	bh=HeyylVedbLrRLEjM0qHQchG6T0QzQN/z949rKKyCCuk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B7mbMhQv6Iv+Gi0SBLoBLQ0TetIW4O+i4N1pudBiFaxiGP+Phizm1XekM28yHrkcXCrnDgSIuHoe2c4LTUqJa/K2l/wFgvlyqTFpW71v4YhjtfgJsSyeGNYKsseGpMOU3fk76ow+gMsLLSQ7vWZZNDTzgftkztk9G4kbFRaeRkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=a7HeE094; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="a7HeE094"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tkgsnbe0nKUzQ5qKoRkEBmSHC2lresVCplemTzEq/A0=; t=1725127676; x=1725732476; 
	b=a7HeE094lg+S+hfjvytCrKZcV+WyQ3RewSJeKHPR8DdD7jN01iyTkZHc51p72j8ot3zVqq5Z5aK
	yGTqQU/XNGjktB5vUJpezVwCEPZ7F5exu0NhPvE3BxVWLbIEqfy5TZwm6EI98p3qFkS0gK3XRIb6p
	mRmhQH1XqKhNCO1/hLN5z4b8dDw8qg+Y9iMTjwIzbcNHzmp0HInzcQm7grtZ3twiFAgnWvkgnL3ro
	MDBQcebtBBCx3+UlF9TRTXC5dYhaG3Cwnd/4R5Bmv0q1gxeMGPp9owd0NXJZ3MHevDQA3/VJPrhJn
	zeydTDVw+xFJVljcm7eTSgHjKM0bSqOT+Qrw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1skSVm-000000006No-0iNY; Sat, 31 Aug 2024 20:07:46 +0200
Received: from dynamic-078-055-116-117.78.55.pool.telefonica.de ([78.55.116.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1skSVl-00000003r5z-43oP; Sat, 31 Aug 2024 20:07:46 +0200
Message-ID: <ed56d2d52dce9c7bd1ea2b0a6504f2ddb50235b4.camel@physik.fu-berlin.de>
Subject: Re: [PATCH -next v2] sh: intc: replace simple_strtoul to kstrtoul
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Hongbo Li <lihongbo22@huawei.com>, ysato@users.sourceforge.jp, 
	dalias@libc.org, geert@linux-m68k.org
Cc: linux-sh@vger.kernel.org
Date: Sat, 31 Aug 2024 20:07:45 +0200
In-Reply-To: <20240831094310.4148930-1-lihongbo22@huawei.com>
References: <20240831094310.4148930-1-lihongbo22@huawei.com>
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

Hello Hongo,

thanks for your patch!

On Sat, 2024-08-31 at 17:43 +0800, Hongbo Li wrote:
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
> v2:
>   - Pass the error code returned by kstrtoul() suggested by Geert.
>=20
> v1: https://lore.kernel.org/all/98c7b473-0b2b-4e47-83f6-35d9f417bb01@huaw=
ei.com/T/
> ---
>  drivers/sh/intc/userimask.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
> index abe9091827cd..5d7801b76715 100644
> --- a/drivers/sh/intc/userimask.c
> +++ b/drivers/sh/intc/userimask.c
> @@ -32,8 +32,10 @@ store_intc_userimask(struct device *dev,
>  		     const char *buf, size_t count)
>  {
>  	unsigned long level;
> +	int ret =3D kstrtoul(buf, 10, &level);

Could you separate declaration and assignment here to make it more consiste=
nt
with the rest of the code?

> -	level =3D simple_strtoul(buf, NULL, 10);
> +	if (ret !=3D 0)
> +		return ret;
> =20
>  	/*
>  	 * Minimal acceptable IRQ levels are in the 2 - 16 range, but

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
