Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3783C433F5
	for <linux-sh@archiver.kernel.org>; Mon,  8 Nov 2021 13:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83633611C0
	for <linux-sh@archiver.kernel.org>; Mon,  8 Nov 2021 13:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhKHNej (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:34:39 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:42832 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbhKHNei (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 8 Nov 2021 08:34:38 -0500
Received: by mail-ua1-f51.google.com with SMTP id t13so16130248uad.9;
        Mon, 08 Nov 2021 05:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=917ou4i0m8XwTRLtSzLNb+jh838cky8jWcxVoB+CqOM=;
        b=Pw3i+weyc7+jUFjiqgja4nmIGiQYkp+hTDI9tUVPtfM/z0qZ/4yhUYz846TFW/iUJE
         8aZiIZxOJIJtcYDjBO0eZw31R4ld/ywvH5oMBRjH8uCeCTGw3OIYAu0TUmEvL6ueUne/
         1HnChVid6if+SoM/P5I3r6J8pUDJWBSnVKgaEaJiHHeVunGHmT7XqkpyWVFVRUqup7eq
         /e8uYLF186k+tLqbbRBuWImk5nNh91VBdX1tOA/TDh1l8a3+yBJBR/VZfxG0HOV2YmLi
         CUKZC9kmBWQP4XrfpDcHA4DirB+LRlijSkYt4jGKbYlX9gm8pPWYVqmwv7U5uBDD/314
         XFTg==
X-Gm-Message-State: AOAM532clrUNDaatOchmCe/ok3705337hD8ueOonSizazkXGJ/I7V0Af
        9ehEs0k4btdHQNvPPOA8Nl/0LxreMt2R3g==
X-Google-Smtp-Source: ABdhPJw47zlIxwJ71J54+Vg0Z9l+bDbF+0CIPJ1roBry8M2Jopz/D+M+TAU28p0fM6RDPn+bbdJIiA==
X-Received: by 2002:a67:5f47:: with SMTP id t68mr33706564vsb.56.1636378313578;
        Mon, 08 Nov 2021 05:31:53 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id q9sm1026020vkn.44.2021.11.08.05.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 05:31:53 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id l43so31453031uad.4;
        Mon, 08 Nov 2021 05:31:53 -0800 (PST)
X-Received: by 2002:a67:c38f:: with SMTP id s15mr40867953vsj.50.1636378313058;
 Mon, 08 Nov 2021 05:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20211108101157.15189-1-bp@alien8.de> <20211108101157.15189-36-bp@alien8.de>
In-Reply-To: <20211108101157.15189-36-bp@alien8.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Nov 2021 14:31:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW4fv4LN6oDS6qgYodf74_NvbzMxQfRbtnS-mn_D+u7Kg@mail.gmail.com>
Message-ID: <CAMuHMdW4fv4LN6oDS6qgYodf74_NvbzMxQfRbtnS-mn_D+u7Kg@mail.gmail.com>
Subject: Re: [PATCH v0 35/42] sh: Check notifier registration return value
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Borislav,

On Mon, Nov 8, 2021 at 1:50 PM Borislav Petkov <bp@alien8.de> wrote:
> From: Borislav Petkov <bp@suse.de>
>
> Avoid homegrown notifier registration checks.
>
> No functional changes.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Thanks for your patch!

> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> @@ -1277,11 +1277,14 @@ static struct notifier_block sh7724_post_sleep_notifier = {
>
>  static int __init sh7724_sleep_setup(void)
>  {
> -       atomic_notifier_chain_register(&sh_mobile_pre_sleep_notifier_list,
> -                                      &sh7724_pre_sleep_notifier);
> +       if (atomic_notifier_chain_register(&sh_mobile_pre_sleep_notifier_list,
> +                                          &sh7724_pre_sleep_notifier))
> +               pr_warn("SH7724 pre-sleep notifier already registered\n");
> +
> +       if (atomic_notifier_chain_register(&sh_mobile_post_sleep_notifier_list,
> +                                          &sh7724_post_sleep_notifier))
> +               pr_warn("SH7724 pre-sleep notifier already registered\n");

Do you think these can actually fail?

>
> -       atomic_notifier_chain_register(&sh_mobile_post_sleep_notifier_list,
> -                                      &sh7724_post_sleep_notifier);
>         return 0;
>  }
>  arch_initcall(sh7724_sleep_setup);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
