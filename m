Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6A2C46CA1
	for <linux-sh@archiver.kernel.org>; Mon, 18 Sep 2023 19:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjIRTGU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Sep 2023 15:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjIRTGR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Sep 2023 15:06:17 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92CF195;
        Mon, 18 Sep 2023 12:05:57 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59e8d963adbso17653397b3.0;
        Mon, 18 Sep 2023 12:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063956; x=1695668756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6nNVjQmZebnG00xsKzI/fcMI7V75AuDSYfTSicfmnY=;
        b=p+RDNleMGmxuabEK0aC6hDS1kXBZDISyj0jr7Q/QP9Vaxbah7U1MpLFK//zNXB8D/5
         5lx4T0OnywuRK5mSdacyyLOKMk1YBweWdgxw8f1JIy6gkx/2Lt8HtGccXnn4fksRRoWq
         d9vin+UIbgjLgt9iCHPEWUNu2j2zrWEMBkehwM1VbXsFhsKKoNp/WCXKoQwNbhS7cBWf
         571JTKKKvo0/uEq0ki+9llBnaT7fyWObN2H8EEuWeqJT9/vUv9xtCpVa/RDsuzCSKU5O
         OBQmbByfQnAyJHaXObJM8WtxnB7oVPew121oGtVKfPNmOA1HLCaQSHtqxhO0UKM9YlBE
         BhAQ==
X-Gm-Message-State: AOJu0Yx7V2u9gRyNvjx0OKjEeh3V6xOr/Sr5TZCu1zBke71STp4u7Yu3
        ODmzHUaGMfuoWf1NczBZxwfAIoc8Ha7RMw==
X-Google-Smtp-Source: AGHT+IHnkxqaYFAwQWAQhNts2zqKVm8K+4eOwbZFvsOjsIL6+dNa23uW+MQVD3SH8Hyj6X3QgM30dQ==
X-Received: by 2002:a0d:c004:0:b0:593:47ff:bd7 with SMTP id b4-20020a0dc004000000b0059347ff0bd7mr8255366ywd.46.1695063956551;
        Mon, 18 Sep 2023 12:05:56 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id r83-20020a0de856000000b00597f533cc64sm2750248ywe.9.2023.09.18.12.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 12:05:56 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59e8d963adbso17653257b3.0;
        Mon, 18 Sep 2023 12:05:56 -0700 (PDT)
X-Received: by 2002:a81:484c:0:b0:589:f4ec:4d51 with SMTP id
 v73-20020a81484c000000b00589f4ec4d51mr9281124ywa.3.1695063955925; Mon, 18 Sep
 2023 12:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <4179b63bb3f151a49616c4ae2702de16702ad739.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <4179b63bb3f151a49616c4ae2702de16702ad739.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 21:05:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVer7fDi2pA=Gj0z=bsoBp1cL=GYXqtY9rvZBdd2LLd-w@mail.gmail.com>
Message-ID: <CAMuHMdVer7fDi2pA=Gj0z=bsoBp1cL=GYXqtY9rvZBdd2LLd-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/30] drivers/clk: Add SH7750 CPG drivers entry.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:24 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

Patch prefix should be "clk: renesas: ".

>  drivers/clk/renesas/Kconfig  | 15 ++++++++++++++-
>  drivers/clk/renesas/Makefile |  1 +

Please combine this patch with "[RFC PATCH v2 10/30] drivers/clk:
SH7750 / SH7751 CPG Driver".

> --- a/drivers/clk/renesas/Kconfig
> +++ b/drivers/clk/renesas/Kconfig
> @@ -2,7 +2,7 @@
>
>  config CLK_RENESAS
>         bool "Renesas SoC clock support" if COMPILE_TEST && !ARCH_RENESAS

... && !SUPERH

> -       default y if ARCH_RENESAS
> +       default y if ARCH_RENESAS || SUPERH
>         select CLK_EMEV2 if ARCH_EMEV2
>         select CLK_RZA1 if ARCH_R7S72100
>         select CLK_R7S9210 if ARCH_R7S9210
> @@ -39,6 +39,11 @@ config CLK_RENESAS
>         select CLK_R9A07G054 if ARCH_R9A07G054
>         select CLK_R9A09G011 if ARCH_R9A09G011
>         select CLK_SH73A0 if ARCH_SH73A0
> +       select CLK_SH7750 if CPU_SUBTYPE_SH7750
> +       select CLK_SH7750 if CPU_SUBTYPE_SH7750S
> +       select CLK_SH7750 if CPU_SUBTYPE_SH7750R
> +       select CLK_SH7750 if CPU_SUBTYPE_SH7751
> +       select CLK_SH7750 if CPU_SUBTYPE_SH7751R
>
>  if CLK_RENESAS
>
> @@ -218,6 +223,14 @@ config CLK_RZG2L
>         bool "Renesas RZ/{G2L,G2UL,V2L} family clock support" if COMPILE_TEST
>         select RESET_CONTROLLER
>
> +config CLK_SH7750

Probably you want to move this below CLK_SH73A0...

> +       bool "Renesas SH7750/7751 family clock support"

... and drop the "Renesas" part?

Please add "if COMPILE_TEST" like all other clock drivers in this file.

> +       depends on CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7750S || \
> +                  CPU_SUBTYPE_SH7750R || \
> +                  CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R || COMPILE_TEST

There is no need for a dependency rule.

> +       help
> +         This is a driver for SH7750 / SH7751 CPG.
> +
>  # Generic
>  config CLK_RENESAS_CPG_MSSR
>         bool "CPG/MSSR clock support" if COMPILE_TEST

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
