Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927F8CD5BA6
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 12:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjISMQF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 08:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISMQE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 08:16:04 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02F2F2
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:15:58 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-59c0442a359so45936027b3.0
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125758; x=1695730558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CC0rNC/HiJ6kypjL23ttZKU6knIn/QefjEK9GTBgYE=;
        b=ZTBdrtbb0RJ3ut2s66SOrTFXqCord8eUWpaAGP+wz4NcfcFLJwg2nCKg1qV/qOUKXX
         aaTXODTVdWocwpjQvzl+YiqTjf0BJhz+8YnY+NOiStx/OcRbAbqB1pISF7QaERINDI89
         ZBWVEZHru53co00m2wLFLmgraaa9SFmGmOYSF/tP4dN5TqL8ywRVdUHKw7g7NACSwDLt
         tK36C2VtMyfFg0XU71ASWrB7b21ZqOMvn0+bfAtH+F3mRLqLP2RZyICsW3mSLzoUK/GT
         9vx+GJ9wSxnIH5rzUSWHzhSxnqadjEhgLKUyZO22qXtGem3XxAaM4pa2DAtFdDE91OAu
         ST+Q==
X-Gm-Message-State: AOJu0YwerBhaZ+Ca2EaEm5bkIq9vg3HjZaTVJHUqR+iWlhGBzXNqZcri
        t9CnsB+gqR3ID0Min3KEpZ2MRZZnmAYMbQ==
X-Google-Smtp-Source: AGHT+IFiQ8B++eKATmmCUSElJf835Vpslj+AWJzuIrCamzfY9dCn2ThvF2XpFpZ9l3SE9529eIQS4g==
X-Received: by 2002:a81:cb09:0:b0:59b:5275:800a with SMTP id q9-20020a81cb09000000b0059b5275800amr3949674ywi.2.1695125757971;
        Tue, 19 Sep 2023 05:15:57 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id v15-20020a81a54f000000b00583f8f41cb8sm3089904ywg.63.2023.09.19.05.15.57
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:15:57 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso2587056276.0
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:15:57 -0700 (PDT)
X-Received: by 2002:a25:7747:0:b0:d81:58d3:cc70 with SMTP id
 s68-20020a257747000000b00d8158d3cc70mr10581358ybc.52.1695125757590; Tue, 19
 Sep 2023 05:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <78b37903cfb2cc64f0f09287a3e075d7dda73260.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <78b37903cfb2cc64f0f09287a3e075d7dda73260.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 14:15:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV816qiWBDma-C6=Fpy71Pj=6j5a7cF9D3zeSA791KP5A@mail.gmail.com>
Message-ID: <CAMuHMdV816qiWBDma-C6=Fpy71Pj=6j5a7cF9D3zeSA791KP5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 18/30] drivers/clocksource: sh_tmu clocks property support.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:29 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -537,6 +537,9 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
>
>         /* Get hold of clock. */
>         tmu->clk = clk_get(&tmu->pdev->dev, "fck");
> +       if (IS_ERR(tmu->clk) && IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
> +               /* use DeviceTree clocks property */
> +               tmu->clk = devm_clk_get(&tmu->pdev->dev, NULL);

This should not be needed.
I guess this is a workaround for the missing

            clock-names = "fck";

in arch/sh/boot/dts/sh7751.dtsi?

"make dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/timer/renesas,tmu.yaml"
would have told you ;-)

    timer@ffd80008: 'clock-names' is a required property

>         if (IS_ERR(tmu->clk)) {
>                 dev_err(&tmu->pdev->dev, "cannot get clock\n");
>                 return PTR_ERR(tmu->clk);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
