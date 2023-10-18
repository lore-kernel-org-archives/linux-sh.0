Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535AAC41513
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 18:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJRSiM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 14:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRSiM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 14:38:12 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3400118
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 11:38:10 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7afd45199so90258987b3.0
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 11:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697654290; x=1698259090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfLSbOkhwmu5hviem8z7p8gpRsk4S7h5o19dl8a19Sk=;
        b=ds2npSCX2ge903U/MK9ZvanD8sPY3rNr4L8+Uc/S+qS2S9JrpaZ7GebaAjjzuEG0+s
         whMEXNSaRhb3BDVdlRrVyfc3fSBxux3h7jzCdkY7hMaGT/Z7PTpmeyEvYKZLqJmK9klk
         QRPuZvAr8pnI+57olcDE6NzVz7tb7O95sDvvxPbnNEoReI1ZrWylVRW+yxs9lBcqHgMa
         IYtZJyPrhK0V2O/2T2rBl+xTGoTdVvQBVjU4H+UZtDYRqVCd9xJW9R0jTsWMNGhIAaQp
         X3gmhIpv+UmZxC7WOij0CCaHP9FBF6QVy9u0SPVF68HPhx/q6Q1I+Vi7dDh8rVf+nxLq
         l2PA==
X-Gm-Message-State: AOJu0YxRFOhKWMKM7cUEeQeeARq7KGLrp1ER64tTP72OX32V47P7ZGSI
        VemIYuR1S40VVlJ5XOnWm2BgSKVEiERUWg==
X-Google-Smtp-Source: AGHT+IGG1Ti12E3IOTmNFviKqbUtonnvkuCX6i2PcCb+7SnHXXMJ8LVHwoVoZIagfqcJoRSyy4yB9A==
X-Received: by 2002:a81:5dc1:0:b0:569:e7cb:cd4e with SMTP id r184-20020a815dc1000000b00569e7cbcd4emr76951ywb.48.1697654289716;
        Wed, 18 Oct 2023 11:38:09 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id p136-20020a0de68e000000b0058ddb62f99bsm1749153ywe.38.2023.10.18.11.38.09
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:38:09 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a7c7262d5eso89971467b3.1
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 11:38:09 -0700 (PDT)
X-Received: by 2002:a81:5303:0:b0:5a7:bc38:fff2 with SMTP id
 h3-20020a815303000000b005a7bc38fff2mr97985ywb.15.1697654289303; Wed, 18 Oct
 2023 11:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <7b864c7ded52ace326c42b132708a6dc8ad9a606.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <7b864c7ded52ace326c42b132708a6dc8ad9a606.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 20:37:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQUm9CpNGXoXJvyDrhe_3J11MTTvV4_J0zKK9U6AUcqQ@mail.gmail.com>
Message-ID: <CAMuHMdXQUm9CpNGXoXJvyDrhe_3J11MTTvV4_J0zKK9U6AUcqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 06/35] arch/sh/boards/of-generic.c: some cleanup.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/arch/sh/boards/of-generic.c
> +++ b/arch/sh/boards/of-generic.c
> @@ -140,25 +132,13 @@ static void __init sh_of_init_irq(void)
>         irqchip_init();
>  }
>
> -static int __init sh_of_clk_init(void)
> -{
> -#ifdef CONFIG_COMMON_CLK
> -       /* Disabled pending move to COMMON_CLK framework. */
> -       pr_info("SH generic board support: scanning for clk providers\n");
> -       of_clk_init(NULL);
> -#endif
> -       return 0;
> -}
> -

Removing this breaks J2 for sure? I guess this should be merged with
"[RFC PATCH v3 07/35] arch/sh/kernel/time.c: support COMMON_CLK."
to avoid a bisection regression?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
