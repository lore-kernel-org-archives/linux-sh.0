Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F041FC433EF
	for <linux-sh@archiver.kernel.org>; Fri,  8 Jul 2022 07:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiGHHyZ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 8 Jul 2022 03:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiGHHyZ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 8 Jul 2022 03:54:25 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5CF25C68
        for <linux-sh@vger.kernel.org>; Fri,  8 Jul 2022 00:54:24 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id x17so18075qkh.11
        for <linux-sh@vger.kernel.org>; Fri, 08 Jul 2022 00:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XR9WjDWPP0AqCRVmMHVxtD0tF3ApqqEeeQJCbUtfFac=;
        b=ubBPI8P4BLE+uWT3fInLCKEMZlOE1ayf0Bnhi28BfIA+AseZ0Hi82gZzhWr5RMMTf8
         XOrPDtE7xMfuzknW19JGkg4+rtN4v0MSIsIeugAQ9LTi5UpVDBMDgNmg7zYSE1jzDpRU
         LlsbHVhyu9JSk4owZQs1BfgY7Kur7vfBcmXArNdkbMno1+IWSVlVXyZoRB6j/C7pQLUt
         0V2PpPJDgGEaSFwxHflIn6sqzex4TZVU+zqQsfDudjtSw5AJJifvgGbPkKpmwNb4a7bY
         ZmRMcIwvGVqcq1Gm9Ty4UNO8XgjaotM1uAlkpWwrYJsNt3f0BiInXA9RFOGZFZx1LSy2
         IP4A==
X-Gm-Message-State: AJIora/enuGHzwMKtlD6C9NIBQzhBUOd7VPeCdeutVTdgntwQ4M61k7w
        /Uo2Fc7KLJ3hGxc1zOqod9C1Tpa9x84GlQ==
X-Google-Smtp-Source: AGRyM1tNObGO7kvszYSpCI5rOfbmsb535Q/rPAb8dfSneBj6A9XFtS1+gTeStgl1IbGtNbNGA+M1Fg==
X-Received: by 2002:a05:620a:20c2:b0:6b5:5db7:41b with SMTP id f2-20020a05620a20c200b006b55db7041bmr1362001qka.659.1657266863300;
        Fri, 08 Jul 2022 00:54:23 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a404800b006b24f49d06csm20267376qko.6.2022.07.08.00.54.22
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 00:54:22 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id r3so36572004ybr.6
        for <linux-sh@vger.kernel.org>; Fri, 08 Jul 2022 00:54:22 -0700 (PDT)
X-Received: by 2002:a25:2b48:0:b0:668:3b7d:326c with SMTP id
 r69-20020a252b48000000b006683b7d326cmr2120545ybr.380.1657266862287; Fri, 08
 Jul 2022 00:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220523091633.5217-1-phil.edworthy@renesas.com>
In-Reply-To: <20220523091633.5217-1-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Jul 2022 09:54:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWdd7VGLpUFo--DdYJRtHhrEH-j9wm1nb66BZZ6o82Sug@mail.gmail.com>
Message-ID: <CAMuHMdWdd7VGLpUFo--DdYJRtHhrEH-j9wm1nb66BZZ6o82Sug@mail.gmail.com>
Subject: Re: [PATCH] sh: clk: Extend valid clk ptr checks using IS_ERR_OR_NULL
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Phil,

On Mon, May 23, 2022 at 11:16 AM Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> In order to allow all drivers to call clk functions with an invalid clk
> ptr, ensure we check not only for a NULL clk ptr, but also for errors
> before using it.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Thanks for your patch!

> --- a/drivers/sh/clk/core.c
> +++ b/drivers/sh/clk/core.c
> @@ -294,7 +294,7 @@ int clk_enable(struct clk *clk)
>         unsigned long flags;
>         int ret;
>
> -       if (!clk)
> +       if (IS_ERR_OR_NULL(clk))
>                 return -EINVAL;

drivers/clk/clk.c:clk_enable() only checks for NULL, so I think this
part should be dropped.

>
>         spin_lock_irqsave(&clock_lock, flags);
> @@ -470,7 +470,7 @@ void clk_enable_init_clocks(void)
>
>  unsigned long clk_get_rate(struct clk *clk)
>  {
> -       if (!clk)
> +       if (IS_ERR_OR_NULL(clk))
>                 return 0;

Same here.

>
>         return clk->rate;
> @@ -482,7 +482,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>         int ret = -EOPNOTSUPP;
>         unsigned long flags;
>
> -       if (!clk)
> +       if (IS_ERR_OR_NULL(clk))
>                 return 0;

Same here.

>
>         spin_lock_irqsave(&clock_lock, flags);
> @@ -513,7 +513,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>         unsigned long flags;
>         int ret = -EINVAL;
>
> -       if (!parent || !clk)
> +       if (!parent || IS_ERR_OR_NULL(clk))
>                 return ret;

Same here.

>         if (clk->parent == parent)
>                 return 0;
> @@ -542,7 +542,7 @@ EXPORT_SYMBOL_GPL(clk_set_parent);
>
>  struct clk *clk_get_parent(struct clk *clk)
>  {
> -       if (!clk)
> +       if (IS_ERR_OR_NULL(clk))
>                 return NULL;

Same here.

>
>         return clk->parent;
> @@ -551,7 +551,7 @@ EXPORT_SYMBOL_GPL(clk_get_parent);
>
>  long clk_round_rate(struct clk *clk, unsigned long rate)
>  {
> -       if (!clk)
> +       if (IS_ERR_OR_NULL(clk))
>                 return 0;

Same here.

>
>         if (likely(clk->ops && clk->ops->round_rate)) {

So it's just clk_disable() that needs the improved checking, so you can
always call it in cleanup code, regardless of failing to get the clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
