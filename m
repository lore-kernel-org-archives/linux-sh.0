Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA8268C5A
	for <linux-sh@vger.kernel.org>; Thu, 13 Mar 2025 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884094; cv=none; b=gWXJghbQcar/oTQydI0lMafZ7ON/bjGCmMfJjLblOqs2HdkvcZFMgBIXvvCON6VgmHUeaH7TcCwG+P0mH9PtEutaisyJjzeGzZvgY2UKe8hQOnAI/PJSUyyWBGGpIdVH1DweII5Fei1YTse18I47vbgbisUkJygJOAzQdmAzXYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884094; c=relaxed/simple;
	bh=NBDdDxNGDvQP5bA9D+gvZA4DOkX78hxDa702jREZMkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0ytiXnzXwDtS3S7ReBaAhHp58OGvUTXT/hCT/FReSf5UbGTDO97gX/Quhup6sF51GZE/LMsPdWBlrU1eCIqb5K4anF8WwRod70H7sAhw6Kqq+55bG2dhQnWdnQ+bbNt8BbUd7kqMwklgpIzR/JVfptnH0Ocy67ZTKdNFyDzUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXRqYXfE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXRqYXfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741884091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AOuWXnGYR13C3EsQl2M3GLqAI/OrlKtR5FIj9y6Kyo=;
	b=dXRqYXfEHjUkDhGCNuqXYsnq0hVY+hOQ8PDqkoU8pVkdRsM29ioHmpv6zUKcv0pCk5E1Vl
	U9Wr0xMDRNpZio1hjBoZ0Yi1g6Z7pcinCEbd0nbBFinglitH7aMf0n+tBKce1aRSfDDD7g
	axj3mjCHHuBpJ/lLVNPf2MEocxSeIp0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-n-VMIBWvMQy1TZ69TT5Jqw-1; Thu, 13 Mar 2025 12:41:12 -0400
X-MC-Unique: n-VMIBWvMQy1TZ69TT5Jqw-1
X-Mimecast-MFC-AGG-ID: n-VMIBWvMQy1TZ69TT5Jqw_1741884072
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso2098697a91.2
        for <linux-sh@vger.kernel.org>; Thu, 13 Mar 2025 09:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884071; x=1742488871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AOuWXnGYR13C3EsQl2M3GLqAI/OrlKtR5FIj9y6Kyo=;
        b=rV8E9k+Vr962aICSbFEtEtXE+w4KQUWyUbMm5uPCayb8o6c3ODpSXvZjxtnr/B0X1/
         sic2EZ2X9Yh+s2XEws02GcDsYEGkDHnSalncibNzTKmCH6L7c2AWfTs+DTNcU1FAGFSh
         qNxMLICkJtV3wIwEsEeRDZpAhVPaupNjayYSeMG/jdxWOMjhQyHyE2yfj7mc6Ta3JiMb
         mrywKszL46lTdcGKRpLsnNtooionyVvuig08oKIp2CXAtnyhIaezxxrWKlFLuCUNoRyP
         1d0/OVcn3LLK4FYjUnbd+nwPaDuOI5h6mI7kvATJ2E/PKYJz+fdHb0f27sNaoOAswV8B
         31nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo3j6RZfzq+5QcpTD62CTfiBZA6KqZJiW0M4XPPSYuXozBpLn/OS0B/zHP3uWuTiEVdgXUpY22Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcz7WFOYj3Cyelma73OSSm3iXicL44mxwvWyq9TnArMJQx90Z2
	9vIdseKL3pyp/ffCP6MtcK7TUQVPZ5K5o4TGBZeVeoThpeoyaybyI6K8M2WQTaR+7zIZeqWlujJ
	M1/lnhyqQ+p+QN+iJ9NWtVrUPPzrBLAhW91GQUUAvf0UJ/VdhZ+ioUlCe3lKSG+7qOBNVmPWwZJ
	TZD229n6zLfzzWHE+uikx834GaOIRiWUw=
X-Gm-Gg: ASbGncukeiRxuzgSuA+Ce0lsKVnQScXc+3+Tht0g3b+R47f0xC4WWrXmBESqHsUN4NS
	VhOZiJd102gI0nE1ka52Bj2tNhMMGP0pkxaD7BqlpQLiZRjiKC0t6+dvcegLOgBv4dEk9WZE=
X-Received: by 2002:a17:90b:2812:b0:2fe:6942:370e with SMTP id 98e67ed59e1d1-3014e814787mr282593a91.7.1741884071600;
        Thu, 13 Mar 2025 09:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZSR0GKOgpT9qIwRRXIxVMEVNcO4hzEa3HpTc2cVefBnUNShY5U2qKEnTkHJXaXXzQjc2Wb29JilB9GlX1pNU=
X-Received: by 2002:a17:90b:2812:b0:2fe:6942:370e with SMTP id
 98e67ed59e1d1-3014e814787mr282561a91.7.1741884071208; Thu, 13 Mar 2025
 09:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313114329.284104-1-acarmina@redhat.com> <20250313114329.284104-8-acarmina@redhat.com>
 <20250313122503.GA7438@willie-the-truck>
In-Reply-To: <20250313122503.GA7438@willie-the-truck>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Thu, 13 Mar 2025 17:40:59 +0100
X-Gm-Features: AQ5f1JoRjBn0wYL3TNCgo2Be9gEw3kQ3UV-S3_DQ-XzPf4lVXAvFHPCcZEOjQyQ
Message-ID: <CAGegRW5r3V2-_44-X353vS-GZwDYG=SVwc6MzSGE8GdFQuFoKA@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] arm64: Add support for suppressing warning backtraces
To: Will Deacon <will@kernel.org>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
	Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>, 
	Arthur Grillo <arthurgrillo@riseup.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Guenter Roeck <linux@roeck-us.net>, Alessandro Carminati <alessandro.carminati@gmail.com>, 
	Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	loongarch@lists.linux.dev, x86@kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VL1z1S0haJnvcT7hjcNnerRgOKeN1mvlMOncD2Ki-jM_1741884072
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Will,

On Thu, Mar 13, 2025 at 1:25=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Thu, Mar 13, 2025 at 11:43:22AM +0000, Alessandro Carminati wrote:
> > diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.=
h
> > index 28be048db3f6..044c5e24a17d 100644
> > --- a/arch/arm64/include/asm/bug.h
> > +++ b/arch/arm64/include/asm/bug.h
> > @@ -11,8 +11,14 @@
> >
> >  #include <asm/asm-bug.h>
> >
> > +#ifdef HAVE_BUG_FUNCTION
> > +# define __BUG_FUNC  __func__
> > +#else
> > +# define __BUG_FUNC  NULL
> > +#endif
> > +
> >  #define __BUG_FLAGS(flags)                           \
> > -     asm volatile (__stringify(ASM_BUG_FLAGS(flags)));
> > +     asm volatile (__stringify(ASM_BUG_FLAGS(flags, %c0)) : : "i" (__B=
UG_FUNC));
>
> Why is 'i' the right asm constraint to use here? It seems a bit odd to
> use that for a pointer.

I received this code as legacy from a previous version.
In my review, I considered the case when HAVE_BUG_FUNCTION is defined:
Here, __BUG_FUNC is defined as __func__, which is the name of the
current function as a string literal.
Using the constraint "i" seems appropriate to me in this case.

However, when HAVE_BUG_FUNCTION is not defined:
__BUG_FUNC is defined as NULL. Initially, I considered it literal 0,
but after investigating your concern, I found:

```
$ echo -E "#include <stdio.h>\n#include <stddef.h>\nint main()
{\nreturn 0;\n}" | aarch64-linux-gnu-gcc -E -dM - | grep NULL
#define NULL ((void *)0)
```

I realized that NULL is actually a pointer that is not a link time
symbol, and using the "i" constraint with NULL may result in undefined
behavior.

Would the following alternative definition for __BUG_FUNC be more convincin=
g?

```
#ifdef HAVE_BUG_FUNCTION
    #define __BUG_FUNC __func__
#else
    #define __BUG_FUNC (uintptr_t)0
#endif
```
Let me know your thoughts.

>
> Will
>



--
---
172

