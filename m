Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31636D50B
	for <linux-sh@vger.kernel.org>; Thu, 19 Mar 2026 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930484; cv=pass; b=hmPuCnGPAh8INQ3YUrdxXCBH9q4/UOdrIzRYw9vEHaw7xiUEW/yv9TarUzJsfvr37rpvIcRiG79Et9W9Vw7b3Aly/VH/caAk9hiUY4PjL2B9QBkllTZTMTIk12YAtF5rEusW7qAlsyo8vTHuNy84ccwyzp1lDmWhcKYnAW6s8Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930484; c=relaxed/simple;
	bh=x6wZk7AvpBRTPYt5th9R3ycT2p5XdAgtnR98fAb1EOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXna/wBdy4eBxFf1JLy4UFyJtgEtLV6abAxXicPEixGUZBavhqcd6R9jMhNXFvoB5uW9sxYrdAQGpcI2avEbuQyPooz/cWHZtu9MRz69+ICzSzGUCCPWCO2dirVkTof2I0JKhg1u1ZdeyvGaUABCdvkZTuFSDc1wEITD8RgB4sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcCKrhoY; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcCKrhoY"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-662b5bf4b10so2003305a12.1
        for <linux-sh@vger.kernel.org>; Thu, 19 Mar 2026 07:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773930479; cv=none;
        d=google.com; s=arc-20240605;
        b=ig/XQ4tb6c8zrOuR2i4qUB8Dw+nrO9S1Mmu0Xyz3GZ5nE4tNaRW+G49pP2FsOEgO8+
         F5GPKZ4cg0CRe1q3TUN8a/fUbz6aSqY6WG7e9FZ7KpVBSu/HCm1OtPhP6oT4GrwS+dHw
         jNrBo/TZU4logt6mZaAFGZwgrE/7k4KZTmwvnN0OuqnY1/Zx+YrZ3flX4GZ4JfNZ9xTw
         P0pnBzyJPKQ7Mir9eHtkoA+H/CtT7gPB75hD+IJf3kBAnW/ITlz8BDsWKBlQytg+g6e0
         jMe2v3Y+Xj58DQP3hhMNEJVua6WYc9g4gRKlZPP9qrR/TXUa1dmr5Pp0NNS4XIAenTBq
         nmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        fh=vHG+qMhqI0eWa0UKa8nkk8OBQmRYBiXYqwLqRIEIoUs=;
        b=hQDdJ7zljRYAUwGcfFhgyAYwHXfIkY+5CtvdA2dFTnarIPIquBMJgL49Cr6UCYqAYV
         aGpp2NTx0Plh7LvRFl8clSWS3Os1Z/7WYhsjjbHa9IPAzfkDqGlkYPlQpSaerdnAcxZZ
         PIQzjXg0l8AIgMNt0zKcZUsbu66oSS4wzGNq8heYiBYdNqeISeHC/vmDJKrjRG36Erg7
         IzAIrAbCbXRY+Il6gST9MXa/P6yyrbk/MdYoLscYttrJYmlKAMaMuZM7X8P70KV3jEsM
         vExqPb+1Mv7qJqVq9su1VH+KllRkgtfCpgab6u3Jv5IX2FYSJA2pSUw7ECnPOBuEYumc
         lWqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773930479; x=1774535279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        b=kcCKrhoYX+8CZszcDQbuZD6T4DnxTVx1KFlZ0Jph2pEsT7DV9Mnj1YT1bYrXCuAa+S
         hpDAfQ1xXxUjFpI++GUXCzaWS1y6BSStTwjGD+OnOBciNoZ7Xp1VqamSGoaSAqSZ1u5R
         945g+zKdeorBhg1AKG/Bb90H6R2LtDirpwrPvj5Oh9WzuAiCQSN2EnknkZHTKsbab/zB
         fnD79VSfUGwENxCYTTrjL7dnOT3K9jltAF8JDxfu2vpVHutMN4ta0fP0qdP80PoqOA/o
         HPeL/1Ukubwi4cdQoCwu31uFJ5Bte1R3lZPg/JzllRmeny1zCPKEmeQumCaUrIAZcRJw
         +4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930479; x=1774535279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEYdsi/UQnV1ulkUEVFM3uerucLpRLXH0M0xgNStZdI=;
        b=kK0lhiIm8hxlVs9V7yRuTynMxXtk/emncDUVRN7dUDF4wgV57/MziXmROFsyqGYk3p
         idHI/+HxPtvRXy8j6rvT8H1Ry3lggqHIGSbQXZPin7LixpcTEJIAtNJhcv9f7QiAAVsj
         EZomqn7WPAN43kRrrATV0ZcfpZk4fGDwfAU1zefqimH+U9qNFQo84DtMjMGIIS+JsgR+
         4wQuD0e/9Dfma5prY7pWIYnDA8u1JE4PtJXcjJ8B0Mi/ov0ONas8ImZi9wuxsb+jgM60
         n5EVswm+uXc2ZXtavDbd5684vsaraQ1mjAwoTKw2TTTyHUD4gNZAPXzqsIFB3JW7Grot
         PktA==
X-Forwarded-Encrypted: i=1; AJvYcCXyzxA7+utvXziDQJwBx27mGvkWmELKXfU7PSlrbV4mqjvAHvf51mx9BY2pljtISoAv+vuxvi4I6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfU6T5y6K/ImbuugZ4wbITWTV9FxJwDzJZgjnCThD7tVJoQiLC
	84KJu8Exu8IY/lIcdyMbbgeLlCsc5R9vnyRXqMVQQ9IM8HS4XIM7TpMt9LGhONlF/YEAswYlE5s
	JdbKWyARqsRdkQZCtvl45l9pvyr46dvc=
X-Gm-Gg: ATEYQzz6YJ8A0eNSyYOsYYcr4+TfTOr50fdiEV0b4691fS661+Nj9TJRoD81YGaxK5p
	blgiv6UxpHsarftIP1xbML+Qjq7ikM7CD3j2rGhIby3yWhdpMwIflRxDx0b+1tUOeMVi08NfUAI
	c9YdWG/EvAocauN9It0/Bt7PVtdlh/bAwocMeyqMCBidopXWbtySN5Ivb3KXFd3CHNbuz0ex4Je
	DKsVayv54IN7DLawd4cbxEr6Y2Drs/+hwT52S0xff45R442rU8mDHl4CWZ13A76fTZCmaLPDdSk
	3jgSA1AxWw==
X-Received: by 2002:a17:906:ee83:b0:b96:db93:5d0e with SMTP id
 a640c23a62f3a-b97f4ab7799mr545864466b.41.1773930478856; Thu, 19 Mar 2026
 07:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-7-a11f03ba2ca8@linutronix.de>
From: Andy Chiu <andybnac@gmail.com>
Date: Thu, 19 Mar 2026 09:27:47 -0500
X-Gm-Features: AaiRm52wQD6uRKulnt1Y_ioaRFL-b1bqEKDLHZMA0LYwV13CAWHAV79Bf5laR-o
Message-ID: <CAFTtA3O74BTJz8d87CJFQpa8Sub_ouKyyAB8cTXUxd=BnUzS7Q@mail.gmail.com>
Subject: Re: [PATCH 07/15] RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 6:27=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>
> Move the symbol to a kernel-internal header.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
>  arch/riscv/include/asm/auxvec.h      | 13 +++++++++++++
>  arch/riscv/include/uapi/asm/auxvec.h |  2 --
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/auxvec.h b/arch/riscv/include/asm/aux=
vec.h
> new file mode 100644
> index 000000000000..fb4233445276
> --- /dev/null
> +++ b/arch/riscv/include/asm/auxvec.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 2015 Regents of the University of California
> + */
> +
> +#ifndef _ASM_RISCV_AUXVEC_H
> +#define _ASM_RISCV_AUXVEC_H
> +
> +/* entries in ARCH_DLINFO */
> +#define AT_VECTOR_SIZE_ARCH    10
> +
> +#endif /* _UAPI_ASM_RISCV_AUXVEC_H */
> diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/ua=
pi/asm/auxvec.h
> index 95050ebe9ad0..0a725f2aa2e7 100644
> --- a/arch/riscv/include/uapi/asm/auxvec.h
> +++ b/arch/riscv/include/uapi/asm/auxvec.h
> @@ -33,8 +33,6 @@
>  #define AT_L3_CACHESIZE                46
>  #define AT_L3_CACHEGEOMETRY    47
>
> -/* entries in ARCH_DLINFO */
> -#define AT_VECTOR_SIZE_ARCH    10
>  #define AT_MINSIGSTKSZ         51
>
>  #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
>
> --
> 2.53.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
