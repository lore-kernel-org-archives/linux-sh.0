Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F14DC48BDF
	for <linux-sh@archiver.kernel.org>; Thu, 24 Jun 2021 09:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F50613DC
	for <linux-sh@archiver.kernel.org>; Thu, 24 Jun 2021 09:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFXJES (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 24 Jun 2021 05:04:18 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:40715 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhFXJER (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 24 Jun 2021 05:04:17 -0400
Received: by mail-vs1-f54.google.com with SMTP id e26so1674251vsh.7;
        Thu, 24 Jun 2021 02:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15joZD+xBP1Z8SrQnGc//eBrPwGFXIcsB20vjekMerE=;
        b=qHj7C1NODmjIIfnw1Uly/SnEX6e3Ok4r72W934IbYL+r4pN2yaK6+q90hCPBvxw2Vc
         upw3PB6f7W6wimNbyLfk8XB7t1tRZ3B/IFeJxqR4sQlcN2HUxfIJFSLEtLR5R/woneHT
         t/iCUn2u8jNBOG29GC86rfON0Vl7S2cy5o0/g5X/jZxJqdcegO88kkgEACtYZ67Xi+We
         4IMHOY3AQRBLZCRmXt4IG4pGGs754d/FhMU40HtT0Dy49LCvZVdHgm6+jY1BV1RBfA+f
         SSbA43aHJsh7JQ8NGJJxny3/icCEmZ6jcKsam1zyFazKh9CMBE1nPlp2B8pkJ40Ru1Cl
         BBDw==
X-Gm-Message-State: AOAM533ytJbUIv3i9w1B/mv95+fLUY6DgGiGldg+IAeqgCyuCZoCL9Pa
        I8n5c2FnGWwBPpHYNlRi2Indu5YpIDesYwl3pL5ljpr34Ts=
X-Google-Smtp-Source: ABdhPJwUIiP7sWlZYLENR84hWkp5+WKkCqAxyUVsyMwoKroMc+BhM+Fq8NZ4VfcMIDhAOQ1j3revAmZglHfRU29BdvI=
X-Received: by 2002:a67:f7c2:: with SMTP id a2mr736297vsp.3.1624525318295;
 Thu, 24 Jun 2021 02:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210624085721.10711-1-wjc@cdjrlc.com>
In-Reply-To: <20210624085721.10711-1-wjc@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Jun 2021 11:01:47 +0200
Message-ID: <CAMuHMdXTYb2zHVeFiJZcr6J-NX4PqsyfkMtipiho3VWKz+v5Vg@mail.gmail.com>
Subject: Re: [PATCH] sh/intc: Replace symbolic permissions with octal permissions
To:     wjc@cdjrlc.com
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Jun 24, 2021 at 10:57 AM Jinchao Wang <wjc@cdjrlc.com> wrote:
> Resolve following checkpatch issue:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred.
> Consider using octal permissions '0444'.
>
> Signed-off-by: Jinchao Wang <wjc@cdjrlc.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
