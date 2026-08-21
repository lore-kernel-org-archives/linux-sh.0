Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666A3AAF5A
	for <linux-sh@vger.kernel.org>; Fri, 21 Aug 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297828; cv=none; b=u9oUq15OznxvlEAZGpEsZ8WabqWUYO/fYylWyIgMUo5QMA6+S1ofUjtBVznVSGkoIO2ACPdMshnEXoXqbKe7edS/+lRaMIgJBfcXNNOmIocsX4EsG4a4rkhNsH4BikZqCtqZajnqD6TEzjiy6KidDEQgp7vClx+pomZapOPiHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297828; c=relaxed/simple;
	bh=GCjeeH4gPGLPIfKsaG5xaGeOjvO4t9Nhl/Zgc2w0nJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ov8F+WCjsWxZg+pmN28toGC8nvdOEmv2DBWdS54K8aMOAbjBERcgTj7PStu/MMBEwiRqJo7z3riurvofmODH7iCHjqsAcNgfZxz7T/S0imePcUNmoxs6w/mZG3xi4HcIfVNxASdvh9TvoySyebaZxuytaK+KKv0zFCnysjYDIU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c2c0e261aeso310360e0c.0
        for <linux-sh@vger.kernel.org>; Fri, 21 Aug 2026 00:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787297818; x=1787902618;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xw9nFUr2QvBubT6nLTxxHmulcSTxEsty5Myw/2/X0oI=;
        b=f1vSzB6uhksLO9XABP5WvuXXGWMJAQhNGowHJgklBZFuhf5Y94aKIeIxOGz6dPcA00
         DHK2yOQ8Vr2N1PApROVxslF+BDfMbAh/jN8ECySmKGTzdgTN443TlXbSOLP5Kah3b466
         yjL6rAFstSO76FMYWBRAzXBAxKnFgIIdLuf7YuhiloYkuxS1y79QLAO7Ni8VnWk6bH8o
         qxSWM876W7l1d+0C/3j9XeEdkWx0nMTZRKoHrg58I3fhDbc43khtfsknkgrLI/0f8KVP
         HrZsZUABJ1kiQehV0oPD+0adKU4/6z8gvsjS/N81jjATgtrnKSJC90wloPP42oWFjEWf
         LwoQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHsEuu2fh8uf/PN1NuoX9fRcpQ6s5zcXJPttA6w2ZZOivJALHAUQamduFK3JA3jv60c1G/yVIadw==@vger.kernel.org
X-Gm-Message-State: AFuF++mOK4GVTcG8S9Vnj7iMONsTr4S86radviHI0/6uPBzuKe1pypw/
	GNn5u+kdL0eeHea3UVSn+GtUgPGOkqHfQLpT5UQwZD3JwE8nSoxdge2Dz7mvGMhc
X-Gm-Gg: AR+sD10Inz2vYRdTrr+xt/RBn8I2pfEl2c8f7LeWOSVfkb31VGTh3NHuxEDgykVOg2/
	sn9k6C/1XrAmuB765/wFRoZvaa2jdpmbFbU+eeHKc5H7kuQfcSvuevL1/AosK3DFRzidRZOmItf
	CnF7RFmgGgCTjFZg0ziiv8jh1lZGte2KmzO/Tf+Zqkr/SGNgvCL5fuh3DvZCj4M3rTVxej/KTJm
	1J9F1xLMeN5shKhRz6yAoIPa96IF9IdK5eNTdGrIIXf/QyXb2FKCNVKYYG3KgAyA4lp0LUjx/YM
	dsMpe6OQT6OHqnCWCPNH7HogPYidqRlYtjXG+vyQyrhuGUWfSS9hAHlOn7TWHpIl0awubP6YK+T
	4eJtUq4AUJb+7Elol7kgMWHEwKeVZCSGlo0GGlcu4I5dhCa0MDWlDElm4sGknhHTXcJLQMZF3XI
	pKvN4e5/PXo7YCl0v+k+vaOX9O+JFxbekSrxlrtfsG7s3XKS8wYhi9/ZX6b/Gxwyu1RigjNEfJU
	LHNzfqWOfSspqKsXtuNSBBVSg==
X-Received: by 2002:a05:6122:2202:b0:5bd:c27a:dafd with SMTP id 71dfb90a1353d-5c5ff779777mr1782649e0c.3.1787297818483;
        Fri, 21 Aug 2026 00:36:58 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c4e76040fsm8104275241.3.2026.08.21.00.36.58
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 00:36:58 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-97bf910aa70so189419241.2
        for <linux-sh@vger.kernel.org>; Fri, 21 Aug 2026 00:36:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp5V2l0J6QKKxRIUvY9JCHVDpP6yoWBRbfVSOvL2NZjY/Ew3foFCCWNQy3d7kAMcm8PKQgqqzQKHw==@vger.kernel.org
X-Received: by 2002:a05:6102:3bf9:b0:77b:2881:580b with SMTP id
 ada2fe7eead31-77b2890fb0dmr88639137.4.1787297817842; Fri, 21 Aug 2026
 00:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820123931.142532-1-ailiop@suse.com>
In-Reply-To: <20260820123931.142532-1-ailiop@suse.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Aug 2026 09:36:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUxpgiMSgjcR2-Vz33iYUrjBNKO29yXk8oEdXG6RLFRtg@mail.gmail.com>
X-Gm-Features: AcwNN1VFSBtkYc0uhJ34y6d8TYOgnAnTdieHd3auyFQfTIP6x1Ev7AgPzaPonCg
Message-ID: <CAMuHMdUxpgiMSgjcR2-Vz33iYUrjBNKO29yXk8oEdXG6RLFRtg@mail.gmail.com>
Subject: Re: [PATCH] sh: remove unused setup_profiling_timer function
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Anthony,

Thanks for your patch!

On Fri, 21 Aug 2026 at 09:27, Anthony Iliopoulos <ailiop@suse.com> wrote:
> setup_profiling_timer() is not used by any code at this point. Since a

It is used in write_profile()
https://elixir.bootlin.com/linux/v7.2/source/kernel/profile.c#L202

> default weak implementation exists, there is no need to keep this
> arch-specific definition around. Remove it along with the now-redundant
> profile header includes.
>
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

> --- a/arch/sh/kernel/smp.c
> +++ b/arch/sh/kernel/smp.c
> @@ -21,7 +21,6 @@
>  #include <linux/sched/hotplug.h>
>  #include <linux/atomic.h>
>  #include <linux/clockchips.h>
> -#include <linux/profile.h>
>
>  #include <asm/processor.h>
>  #include <asm/mmu_context.h>
> @@ -322,14 +321,6 @@ void smp_message_recv(unsigned int msg)
>         }
>  }
>
> -#ifdef CONFIG_PROFILING
> -/* Not really SMP stuff ... */
> -int setup_profiling_timer(unsigned int multiplier)
> -{
> -       return 0;

This returns zero (success), while the default weak implementation
returns -EINVAL, so your change breaks write_profile().
https://elixir.bootlin.com/linux/v7.2/source/kernel/profile.c#L181

> -}
> -#endif
> -
>  #ifdef CONFIG_MMU
>
>  static void flush_tlb_all_ipi(void *info)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
