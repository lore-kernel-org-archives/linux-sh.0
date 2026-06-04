Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA62F8EB0
	for <linux-sh@vger.kernel.org>; Thu,  4 Jun 2026 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575154; cv=none; b=kwnxgXR/n4Q0HYcjISUuQL0PoW+Sm3XCUavFYt9arOhr0g/Khz8TEjTee3Jf64NNTtAWoc3CcK7+CrkcmwfHHNmtaUkVVo7uKsfVPZKhsw51/NHNb5vYL5ea4MDPKmKW+rYzxIHXL8QTpu8tVn1jKt6++5qau3jnV3c1YrkbV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575154; c=relaxed/simple;
	bh=SQ2GHIgaPmVRZGIXy9JI0E9QqRF6VYPry2VevMQ5pgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCfRdLJJNqotu70zJMEaJV9HFTbZ0om9m//KHw4WOfOWp/JPkBhrLBPuK2CxrSi6wIHLh757ZF1OdyiXNEOpCprskB7V7BbJaiR6tDd4UBvaTquVJzqkDXJa/VngcX/rpiJBn5SddF0Ibuy44AsoODk9OPHXYdC8moLefRnBF8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-963b7d9bf68so213753241.3
        for <linux-sh@vger.kernel.org>; Thu, 04 Jun 2026 05:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575152; x=1781179952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jWFluQWU+45h8+QlZ3pZEqkFH5RDZHeJqO7XwUMT2M=;
        b=MlA53L6KKplBdYD3fEAWGKTvmM/f6F6MQS0/MXJx2/Uf+iHW9XZx7eZZlN9NyEVNk2
         YLu3+06YuYfI6+hMFUDxg1hF2wLq91mxuHpGyQw3VrGBySiv9aeteg9qxFKcrovlHU72
         Oq50+S7Ua/gtA0ELLP/23HRORB3Co9d9rGqQ7TqBCFL49aWR0ewSM535FVQgoKXAXeeZ
         6+vy3vGS8wd2bfIjIQIdcpZSY6Ehzk+ipsj19wjNvwq3spIv5Lg5/6Y/EZBiI22jZTjF
         wdwpzLZsoU6gpxaoP+SZ7j/3dkkCqox+zzd0iKrC/C5doSflHYZrfDufMhNAxbrL++JI
         hpoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mRDSSvuCSKq2NhSQGDhuYo3qjGF22SQ5lpfKP1a/0GOmVgtbeOhskK3pKMAhVN9AL1a/aizoE2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwckIGm8GdWqU8gcsDtRL826kxRxGBFZND+arCyI248durbuup
	QvNcoqYR3YJ691IBEI17aY07zeR+5V+yczsk2MW8uhsL7J+ZTZZOCu5uIQUni0jkbMw=
X-Gm-Gg: Acq92OHTL57D4IoxSMYMgF2YtDp8cO1IZN+7jKfPIJPAv9SaXz7m1RiMw0sibdh8Gm/
	U+PeMgiVO2JZo3fGYAts/pX8fAo0ydGAA+gmSLzDFF3vGC/yXzij3CsQk65BbBYxVEyxxJXndiC
	N7V+4agwAkE1s+VflJiT/DKHI7AVK8fZc/zpcEmaRRubJpx7Y+M3XZjYZMRWbefnaqgO9syj65k
	Zhu3RhVwcJwstuDLRa53qPKS4twDCoPL7EX/nGLhA+HOaXMJDMK5AKfSWVqlL4+VRHg0vssT2dU
	J9KZDiTcNm1C67g8eRVOx2R6OaFVUtw8kKZ+Q5xkYT+ED2mdAnXIdMSD3UcuAfT8ivWuRBnlgKZ
	2zI/e8VAfcgzmjFY/WIbXD7IJNlilDdCdqkKGttI1Bjqo23wj/UlI2wcZu6GTYk+EyPNY73Cbi0
	ZBB3nYj6mbjKCMYgtouVuvlYxK8Fq3Qi7pymfc4aCrg3n6UYH28TIzPR3hG3/Xjg5FWVlT1oc=
X-Received: by 2002:a05:6122:1692:b0:59a:e174:2e76 with SMTP id 71dfb90a1353d-5a6e561502cmr4433961e0c.6.1780575152298;
        Thu, 04 Jun 2026 05:12:32 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a6dc44d226sm4709467e0c.11.2026.06.04.05.12.31
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 05:12:32 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6cfd2b2e7b1so206237137.2
        for <linux-sh@vger.kernel.org>; Thu, 04 Jun 2026 05:12:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9M6hOM3xoS60jLmC5ahX0f9PD6MvCHDWajdnqQeVTZiwciJrd7wi3UFikXQ8NYUTjAHTq+zQv15Q==@vger.kernel.org
X-Received: by 2002:a05:6102:548e:b0:608:9a34:c8ea with SMTP id
 ada2fe7eead31-6ec2c4c1f3amr4248260137.10.1780575151789; Thu, 04 Jun 2026
 05:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604113442.1303771-3-thorsten.blum@linux.dev>
In-Reply-To: <20260604113442.1303771-3-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 Jun 2026 14:12:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUthkKaEGbedvXX49TFUhnrijSG+muAv8hsHQobTQTJSw@mail.gmail.com>
X-Gm-Features: AVVi8CeGnUvvslsHgsztmPfd_Wo4SA1G5ky7Y3IOfDKGlXMxZbmrwZltDD7pTgU
Message-ID: <CAMuHMdUthkKaEGbedvXX49TFUhnrijSG+muAv8hsHQobTQTJSw@mail.gmail.com>
Subject: Re: [PATCH] sh: dma: use str_plural helper in register_dmac
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thorsten,

On Thu, 4 Jun 2026 at 13:36, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> Replace the manual ternary "s" pluralization with str_plural() to
> simplify the code. This also corrects the "0 channels" case.
>
> Use pr_info() while at it.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks for your patch!

> --- a/arch/sh/drivers/dma/dma-api.c
> +++ b/arch/sh/drivers/dma/dma-api.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/string_choices.h>
>  #include <asm/dma.h>
>
>  DEFINE_SPINLOCK(dma_spin_lock);
> @@ -200,8 +201,8 @@ int register_dmac(struct dma_info *info)
>
>         INIT_LIST_HEAD(&info->list);
>
> -       printk(KERN_INFO "DMA: Registering %s handler (%d channel%s).\n",
> -              info->name, info->nr_channels, info->nr_channels > 1 ? "s" : "");
> +       pr_info("DMA: Registering %s handler (%d channel%s).\n",

%u, while at it?

> +               info->name, info->nr_channels, str_plural(info->nr_channels));
>
>         BUG_ON((info->flags & DMAC_CHANNELS_CONFIGURED) && !info->channels);

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
