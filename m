Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DECC4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 16:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjKNQf3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 11:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjKNQf2 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 11:35:28 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9D311B
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 08:35:24 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-581f78a0206so3211218eaf.2
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 08:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699979723; x=1700584523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9akF9RglJ+i3qaXFSL/GKJwwDUY1v+GXcfqTy0GhBA=;
        b=pSW6naAFpKNJC4Ue8gGH7jeUBOZFAHiEaqxULoMTcPkVSk3NH7FoM3fZucjJSVeARf
         vQLu5vkvJMxs8cB8Lc45I6YNWGsRV1b74fKXYUwqTSvj/b/kJRzK058wo2UoMsjsiwzo
         DzTb7jShOl4w+BUgiCxVJkxzd7MKo6O1/6ywiKNTPhWH6uVFJIaMs4Qp4eD9lZBZfUHr
         GFLMv4sMiEMh35Y7z/cdc1+Je9OMhwHKl0N/oRXT67sK+laWpRzGd8D9AcEu9ewgrovC
         +kAWb7KoaWZR5do9vQibWdwZOUaK/9JUKjOdWzTRI4aJ7kJpsgF8W0yd1WXJY1ZGqHYv
         UXsw==
X-Gm-Message-State: AOJu0YyL3cPsAeqYlzBLieHS7CEfWaINv7JbjNvWqTB5VUBrHYEuZYvT
        N2jEY8+jk1piwsDY6keVm9Nb9PP/curOLQ==
X-Google-Smtp-Source: AGHT+IGeCnc7pZGca0O+iE9L975bJn4EcE/Zlkgs5Kj+1W6J+UrngJZNc6G7tJ/cAYA9vDebXGtz9w==
X-Received: by 2002:a05:6359:6d95:b0:16b:fa0f:e43b with SMTP id tg21-20020a0563596d9500b0016bfa0fe43bmr1919829rwb.29.1699979723273;
        Tue, 14 Nov 2023 08:35:23 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id o13-20020a056902010d00b00d9cb47932a0sm2108735ybh.25.2023.11.14.08.35.22
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 08:35:22 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5afbdbf3a19so66754277b3.2
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 08:35:22 -0800 (PST)
X-Received: by 2002:a81:4891:0:b0:5a7:b557:6595 with SMTP id
 v139-20020a814891000000b005a7b5576595mr11031312ywa.21.1699979722789; Tue, 14
 Nov 2023 08:35:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699856600.git.ysato@users.sourceforge.jp> <3ca881b5919a21d6d08caf48ca9287edac5baafa.1699856600.git.ysato@users.sourceforge.jp>
In-Reply-To: <3ca881b5919a21d6d08caf48ca9287edac5baafa.1699856600.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Nov 2023 17:35:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUvNT1tDTOq4ppqn69cocAeveaXrsoL2VQ2efBQ+hv2aA@mail.gmail.com>
Message-ID: <CAMuHMdUvNT1tDTOq4ppqn69cocAeveaXrsoL2VQ2efBQ+hv2aA@mail.gmail.com>
Subject: Re: [PATCH v4 26/37] dt-bindings: vendor-prefix: Add new vendor
 iodata and smi.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Tue, Nov 14, 2023 at 9:01 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Added.
> - IO DATA DEVICE, Inc.
> - Silicon Motion Technology Corporation (Silicon Motion, Inc.)
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -671,6 +671,8 @@ patternProperties:
>      description: Inventec
>    "^inversepath,.*":
>      description: Inverse Path
> +  "^iodata,.*":
> +    description: IO DATA DEVICE Inc.
>    "^iom,.*":
>      description: Iomega Corporation
>    "^irondevice,.*":
> @@ -1281,6 +1283,8 @@ patternProperties:
>      description: Skyworks Solutions, Inc.
>    "^smartlabs,.*":
>      description: SmartLabs LLC
> +  "^smi,.*":
> +    description: Silicon Motion Technology Corporation
>    "^smsc,.*":
>      description: Standard Microsystems Corporation
>    "^snps,.*":

Please split this in two parts, one adding "iodata" (for which I have
already provided my Rb-tag in v3), one adding "smi".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
