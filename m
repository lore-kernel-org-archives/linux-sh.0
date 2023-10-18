Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED94CDB483
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 19:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjJRTlM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 15:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjJRTlL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 15:41:11 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91EEAB
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 12:41:09 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a7db1f864bso86184527b3.3
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 12:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658069; x=1698262869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrcaU44rxNkgqCSH0SfbF6PEiHFp/fuFdjJrh6o5M8M=;
        b=OZp4RiCh0W4jZny/pFK6vFgQmtG282i1HrciEgN+Ss/M+90eWdIwTPBN3myFDb/mlu
         WGqtCU+pI0wUiMp9tx7WzcgVvChnaHuxeZUG1ScYn2tqZ3wCjtYv+OLBUCNw4yv3Kgrb
         QaFR07ITxj77t2fLWwDm39IgqIwgNlU5dc+iRZ7mYq2KslDC6rPmhbfyPhm9TDeQuRB8
         SJldxNZrwqR5b94EX3qt+xz0k4EC0oaQ7FnTa2ATagwkQEekeWTNlmUCV5+jhu1TG0LJ
         SCTSxG+q4fYVI4eISgcZhNkDrXP9Wdnx3Wl9B9BRpuR8dvFtS+GgqvkTE5UGbpyYcgx9
         85yA==
X-Gm-Message-State: AOJu0Ywuy4l01Wt7/8PaoyBrN0DXpxhblUFgLTVFYhOysMR2F1yusG2/
        kiDj5L4YazoAb/K7uSWOT3nctJKKXWamDg==
X-Google-Smtp-Source: AGHT+IG9k4B7zYf7iPSiLkmRC3G5Ng7g/AKg/CnGoyCl+gJUKYO1E6PidvovnhQEzF2INdxRwDL/xQ==
X-Received: by 2002:a81:4e42:0:b0:5a7:c935:6cf with SMTP id c63-20020a814e42000000b005a7c93506cfmr277536ywb.24.1697658068748;
        Wed, 18 Oct 2023 12:41:08 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id o187-20020a8173c4000000b0057085b18cddsm1767828ywc.54.2023.10.18.12.41.08
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:41:08 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a7db1f864bso86184367b3.3
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 12:41:08 -0700 (PDT)
X-Received: by 2002:a05:690c:ec7:b0:5a7:bc0e:193e with SMTP id
 cs7-20020a05690c0ec700b005a7bc0e193emr318610ywb.18.1697658068197; Wed, 18 Oct
 2023 12:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <f1144ece5bbf1d7fab85080bcd60dd5165b0f7ce.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <f1144ece5bbf1d7fab85080bcd60dd5165b0f7ce.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 21:40:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_5NTA8OcwAZNx_t2=OQpgVV-2oAiGipcE_oAPLOg8HQ@mail.gmail.com>
Message-ID: <CAMuHMdX_5NTA8OcwAZNx_t2=OQpgVV-2oAiGipcE_oAPLOg8HQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 23/35] Documentation/devicetree/bindings/timer:
 renesas,tmu.yaml add SH.
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

> --- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> @@ -21,6 +21,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,tmu-sh       # SH

Please use an SoC-specific compatible value: renesas,tmu-sh7750

>            - renesas,tmu-r8a7740  # R-Mobile A1
>            - renesas,tmu-r8a774a1 # RZ/G2M
>            - renesas,tmu-r8a774b1 # RZ/G2N
> @@ -46,7 +47,14 @@ properties:
>
>    interrupts:
>      minItems: 2
> -    maxItems: 3
> +    maxItems: 4
> +
> +  interrupt-names:
> +    items:
> +      - const: tuni0
> +      - const: tuni1
> +      - const: tuni2
> +      - const: ticpi2

I'm delighted to see support for the 4th interrupt, finally!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
