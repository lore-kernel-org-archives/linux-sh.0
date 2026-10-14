Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804B44C502
	for <linux-sh@vger.kernel.org>; Wed, 14 Oct 2026 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961435; cv=none; b=BDYz98jUXIw3adXaXEQjxWzIW01auLAEG0t5jcCL45O3ztR4GAYaixMKSTqV5sy0NpyFabGNodnPW48YDZvjW6hs0XZ1DyN6c5dRRKW8DdxZOeEtBhvRILfA0Xce9z77Gx+aGBaC3n1jjn8I9sTNfJ3SLv00hDrV6qjAtmVKhm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961435; c=relaxed/simple;
	bh=TTFre1wVPc8VoMEWdWl7FNETUfe1CwRLfZ7pj2U9bSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5Q2knV+lsnf9oZmqSifnZrv9VVVhHk+3uNTG82YP8BvAtzUwciuTNbUrhQLPkDkb1O1CohhInk1smSRpJqAvevPlcHbIhWhDaSTp8E+/rn0BuL+Fj1VY5OmtkKX0228niRIYuKmwftr2jRjK+WKh78CTyuH+6EkURLiv0PY95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5e23be41cf8so1741369e0c.2
        for <linux-sh@vger.kernel.org>; Wed, 14 Oct 2026 00:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961432; x=1792566232;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bk0WxILScU6Y6u+duQiyaZKyaSUANhQ4Ts1Mqg6Tw0M=;
        b=Ked3lHE64OTETCMTXAVKW3bfmBREVvyIvwNK/4IZB6LcWsFodWpwm53Y9eezxAZfno
         tUbed8Ynmz4zY0PO9MH06QEXkHqSiIJY1wMTDvpgzhCufWevL4yjOPFVktcL7z/QmfEz
         VyZHxP3x2dtfg5PRuoFAxN6QRgQ+xrb9OvaAuqnoTkJ/VVfUTJRTqNm6+9qan2JVp2gJ
         Tb6r8buyqVZsagCyze3KnnpP4ZVtz7hcCdUJTO3BpVpy+XkjLyC0LSQC77tMxrjjmZ0h
         iOfCIIgL6kttoTTE3FlBdwPWzkv81qSHNYOt3xIUJ3MdQ+uPv+B/UwVOiPBW/EiugXE1
         oeGA==
X-Forwarded-Encrypted: i=1; AKwUvByce+a31bXWgvOhHTc+7TLsjmmeu1Gm20jFepIBF2mU7Lrd/5HHuXy2U+FQtcdDQIWbToL5JadaKA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJoTVP66OBTgVvj49bFhg3bY+HoJK+ZM6w+Ux7gYiqrYIZCnrM5
	ag2UOaL/LECdgUQcoERQPXsopuOuGbQlr84Z8T/fZ3dxp7a02pOehSMp9Y2xEJh9cPU=
X-Gm-Gg: AYBFou0BJypWltHgMNibWpy5EwKhPnSZHLfVg7wEcgawjE1f2HOOBf3GK8cRo4qeWm+
	UkkPw7wkLAazAbu0nB/hSL0Ut8gp8wJzq7TTmLuEMIcYnw9XgDkkSVtidFZrM/+eTCrwnCFTYp2
	TG4QkuAXifGNId0JGy5PzPi6ohLUDJ5+FVCHYZc2OhbCDvHoyI6y7jeFk7VIwRHlgvbr8tfYKsl
	aj1FVR2rfxH2oI1hJ/OgKfPH2RNyxJivBPbLrVlrSHlNsrNVf+Kqo9Z8/EDWozErdAIlEl64rgw
	5KoN0EVhIykS43mY3dnmkWumkS2nuKgNmVs+zd7S4fG1nxyk8JMyGrY/zUzpwzPCNkjKW8hFSHD
	lvaWB07NqQ+rOFjC6VgrkK+R/+W9kdt7B8CFxvm0mxWD9xgJbjAVKecQyMjI6LKjWkZzv7ippa2
	mqJIWHf2nJWzNIQzXaNcbV4O69YEQ/6BnUy5gG5B0MUFHGetq1SCOc3PhtoNbBSIDkNaO6bXGEw
	6gLLiKJ11dChKlUpWvNRfKTMgDpw83ke2E+e+Es1MK5bP4=
X-Received: by 2002:a05:6122:8006:b0:5e9:6d96:a910 with SMTP id 71dfb90a1353d-5e96da64d4emr336251e0c.3.1791961432562;
        Wed, 14 Oct 2026 00:03:52 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cb93832sm10987344e0c.12.2026.10.14.00.03.51
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 00:03:51 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-98a8c72a04cso1321332241.3
        for <linux-sh@vger.kernel.org>; Wed, 14 Oct 2026 00:03:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByGYd72+xsRWn2eGcKmddtJPAF7PHzNR2JfdT+DJfGrCISSdZxYGYU3yQoB7nGuWexyWoa2v3XczQ==@vger.kernel.org
X-Received: by 2002:a05:6102:3c91:b0:7c3:9b8d:5124 with SMTP id
 ada2fe7eead31-7cb3a0aed1dmr3343010137.18.1791961431528; Wed, 14 Oct 2026
 00:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927191359.6144-1-kmehltretter@gmail.com>
In-Reply-To: <20260927191359.6144-1-kmehltretter@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Oct 2026 09:03:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfpChkH-Ad5x7p579+4rBQtfF5CKwwRrdZ6CxDPDWMCg@mail.gmail.com>
X-Gm-Features: AclHuK-JPX25FVbWtEZgw5SZJYvwRgJ9Oj-OYRi5HkMjQopQgwpR2Z7Y6E2CNek
Message-ID: <CAMuHMdXfpChkH-Ad5x7p579+4rBQtfF5CKwwRrdZ6CxDPDWMCg@mail.gmail.com>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling them
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Karl,

On Sun, 27 Sept 2026 at 21:14, Karl Mehltretter <kmehltretter@gmail.com> wrote:
> register_intc_controller() sorts d->prio and d->sense right after
> allocating them, with hw->nr_prio_regs and hw->nr_sense_regs as the
> element count. The lists hold hw->nr_vectors entries and are only
> filled later, by intc_register_irq().
>
> On SH7785, sh7785-irq0123 and sh7785-irq4567 have four vectors but the
> SoC's eleven priority registers, so sort() swaps 88 bytes in a 32 byte
> kmalloc object at boot. slub_debug=FZPU reports "Right Redzone
> overwritten" in kmalloc-32, and v6.5 and v6.6 panic in
> __kmem_cache_alloc_node() while registering sh7785-irq0123.
>
> Found with a custom QEMU model of the SH7785LCR. On it, v6.4
> sh7785lcr_defconfig boots with SLAB, the defconfig default before v6.5,
> and hangs before the console is up when built with SLUB.
>
> Sort the lists once all vectors are registered, with the number of
> entries that were added.
>
> Fixes: b59f9f9775e6 ("sh: intc: optimize intc IRQ lookup")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks for your patch!

> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c
> @@ -275,9 +275,6 @@ int __init register_intc_controller(struct intc_desc *desc)
>                         k += save_reg(d, k, hw->prio_regs[i].set_reg, smp);
>                         k += save_reg(d, k, hw->prio_regs[i].clr_reg, smp);
>                 }
> -
> -               sort(d->prio, hw->nr_prio_regs, sizeof(*d->prio),
> -                    intc_handle_int_cmp, NULL);

Yeah, if hw->nr_prio_regs > hw->nr_vectors, this overflows d->prio[].
Furthermore, this sorting is useless, as d->prio[] is still empty
(all zeroes).

>         }
>
>         if (hw->sense_regs) {
> @@ -287,9 +284,6 @@ int __init register_intc_controller(struct intc_desc *desc)
>
>                 for (i = 0; i < hw->nr_sense_regs; i++)
>                         k += save_reg(d, k, hw->sense_regs[i].reg, 0);
> -
> -               sort(d->sense, hw->nr_sense_regs, sizeof(*d->sense),
> -                    intc_handle_int_cmp, NULL);

Similar.

>         }
>
>         if (hw->subgroups)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
