Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49664C433F5
	for <linux-sh@archiver.kernel.org>; Mon, 15 Nov 2021 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD6463211
	for <linux-sh@archiver.kernel.org>; Mon, 15 Nov 2021 10:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKOKHr (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 15 Nov 2021 05:07:47 -0500
Received: from mail-vk1-f178.google.com ([209.85.221.178]:41798 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhKOKHq (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 15 Nov 2021 05:07:46 -0500
Received: by mail-vk1-f178.google.com with SMTP id a129so8768216vkb.8;
        Mon, 15 Nov 2021 02:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9MNzNk4Llt9/ytxcRiqz1AimDVwVVOQtIzFg5Xenuc=;
        b=ZSAJ0GhYez5M7vDTsxWyw1ajkQpxkPoZAHORpLOGlV//5W7VJvGpK1qxOa+dbGp2AV
         C4tKVUvOaDocbB6SImwPflWsJyRyyceVWyw6YHo4lvKr3JEj07xHzj9nuxXV9LS60ERL
         R/Cu0h+UQVroV/qnaUAWYFSUkPWJIDbKnpcvjqubEKk++X2054QQP+LWMzW8v1cWAShV
         aCF/4Fz7XaGouTQQ6OejPIx2oUDIteyxdaKCbDjM7Q/rhp0hf8ZlMNAENZRNUdcdGXJT
         8WvRGjebLFQFl8c9DkpurRcDVnZNmUe/MMe2G7G4PNUXYeYpSpHoSODa5QTojnY+3Wpf
         QwPQ==
X-Gm-Message-State: AOAM532+j4oj+PepYXYIuX0uqFf4eU3dW4fjg6WsvZPIPNjWKa8ZC2tw
        x0bUoq8gY6iUEwZACiPjcBhkOSFf6WC+5w==
X-Google-Smtp-Source: ABdhPJxIkZEDCpmUtk6e9AAMTbXQ8d7FsSadeRsKgwUiG1AwPtMLbw4+BWDS7mrSH09qpwL2jpCwOg==
X-Received: by 2002:a1f:288:: with SMTP id 130mr57512963vkc.1.1636970690935;
        Mon, 15 Nov 2021 02:04:50 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id n10sm1519949uaj.20.2021.11.15.02.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 02:04:50 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id l24so29341769uak.2;
        Mon, 15 Nov 2021 02:04:50 -0800 (PST)
X-Received: by 2002:a67:c38f:: with SMTP id s15mr41011407vsj.50.1636970690301;
 Mon, 15 Nov 2021 02:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20211115064139.10338-1-rdunlap@infradead.org>
In-Reply-To: <20211115064139.10338-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Nov 2021 11:04:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYdF2f3LWkjs33qAH2r0ZSquLT+VRCEqzZsCvfiqc3aQ@mail.gmail.com>
Message-ID: <CAMuHMdVYdF2f3LWkjs33qAH2r0ZSquLT+VRCEqzZsCvfiqc3aQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sh: math-emu: fix macro redefined warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Nov 15, 2021 at 7:42 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Fix a warning that was reported by the kernel test robot:
>
> In file included from ../include/math-emu/soft-fp.h:27,
>                  from ../arch/sh/math-emu/math.c:22:
> ../arch/sh/include/asm/sfp-machine.h:17: warning: "__BYTE_ORDER" redefined
>    17 | #define __BYTE_ORDER __BIG_ENDIAN
> In file included from ../arch/sh/math-emu/math.c:21:
> ../arch/sh/math-emu/sfp-util.h:71: note: this is the location of the previous definition
>    71 | #define __BYTE_ORDER __LITTLE_ENDIAN
>
> Fixes: b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- linux-next-20211112.orig/arch/sh/math-emu/sfp-util.h
> +++ linux-next-20211112/arch/sh/math-emu/sfp-util.h
> @@ -67,7 +67,3 @@
>    } while (0)
>
>  #define abort()        return 0
> -
> -#define __BYTE_ORDER __LITTLE_ENDIAN
> -
> -

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
