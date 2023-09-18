Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC96DC46CA1
	for <linux-sh@archiver.kernel.org>; Mon, 18 Sep 2023 15:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjIRPjw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIRPjw (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Sep 2023 11:39:52 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8BBE4F
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:38:36 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-773b4a711bcso189571085a.0
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051247; x=1695656047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/zHcJuNYoBoMfPHMquTTsJSKB/ECPBLIGD1IWQXOgc=;
        b=n3+agB4GIcv6m1DbJMdcC2w5cTHVAbF9o7gcBYyzzWHns+Mo6ju37On7pZpyMdd3KF
         W076/vseVidc0wrgh9Mv75yyumTjS/5d04sWc4kW14pZKeOr7WRXlLihifXviBFm31q3
         ccD76tImKF918UK+xw9DvQD1kqPEg8Ki/67ixp7ZI3aUDG7KGq1YDdXs15BvneBpe4va
         6D+z+D4YpY/eiX0mJoTGAyL3zNWCMR+lJ7Okmlx8AuNSnUQpEUfmlf5uopXTGA/2tMB+
         hefmnNubGToNTNYgIix8oR3r+/Ah1ZGfY/yLcl4V2PTwx07KdDNRfPktTawTNa3hHqU1
         8VMQ==
X-Gm-Message-State: AOJu0YxPjYnIHexS07QNdnmEjbk2QdtQs1FtiEHpS02zhrmyUVFSBD7K
        tZ22v9eCARIy2JBvhsHcLqG8WO35S7hPpw==
X-Google-Smtp-Source: AGHT+IEOsNCh0iDFGuDA+qpCmAiEMGEbbb3wLXe2CLi4mxzAeblcI3Z7PyC/odL1OR9OzWXqEUWxBA==
X-Received: by 2002:a05:6870:468e:b0:1bb:90c3:bb09 with SMTP id a14-20020a056870468e00b001bb90c3bb09mr11022709oap.9.1695049546931;
        Mon, 18 Sep 2023 08:05:46 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id x11-20020a817c0b000000b0054bfc94a10dsm2607989ywc.47.2023.09.18.08.05.46
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 08:05:46 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59c0b9ad491so30690147b3.1
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:05:46 -0700 (PDT)
X-Received: by 2002:a81:4e84:0:b0:581:2887:22be with SMTP id
 c126-20020a814e84000000b00581288722bemr9806574ywb.37.1695049545871; Mon, 18
 Sep 2023 08:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <d097b52851806ebf72141b84a4f0dc9da62fe3a7.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <d097b52851806ebf72141b84a4f0dc9da62fe3a7.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 17:05:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXoiedCbuQq3KD7oVS92WkO3hXjBzjzfYPMW810xJqWEA@mail.gmail.com>
Message-ID: <CAMuHMdXoiedCbuQq3KD7oVS92WkO3hXjBzjzfYPMW810xJqWEA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/30] arch/sh: boards/Kconfig unified OF supported targets.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:24 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Targets that support OF should be treated as one board.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!


> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -376,6 +371,17 @@ config SH_APSH4AD0A
>         help
>           Select AP-SH4AD-0A if configuring for an ALPHAPROJECT AP-SH4AD-0A.
>
> +config SH_OF_BOARD
> +       bool "General Open Firmware boards"
> +       select SH_DEVICE_TREE
> +       select CLKSRC_JCORE_PIT if CPU_J2
> +       select JCORE_AIC if CPU_J2
> +       select HAVE_PCI if CPU_SUBTYPE_SH7751R
> +       help
> +         This board means general OF supported targets.
> +         Currentry supported.

Currently supported:

> +         J-Core, RTS7751R2DPlus and LANDISK.

Although it's usually a bad idea to have such a list, as (hopefully)
it becomes outdated soon ;-)

> +
>  source "arch/sh/boards/mach-r2d/Kconfig"
>  source "arch/sh/boards/mach-highlander/Kconfig"
>  source "arch/sh/boards/mach-sdk7780/Kconfig"

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
