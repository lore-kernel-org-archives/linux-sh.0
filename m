Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD35CA0FE1
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346759AbjIAN0a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 09:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjIAN0a (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 09:26:30 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54480CC5
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 06:26:27 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5922380064bso21612217b3.2
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 06:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693574786; x=1694179586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHYoCG5YB9xssc5iidMPniymMYZpROrmA8MJFClcfRY=;
        b=bto8tn+iqkvswkk8W7+Az9FQ/yJcx+bsArJ4NeaVs3QKYkveHCTRji7/tQNm/y5DyJ
         PUvQhxbossJ564MZAVhOYBsJeXpppX69hBLuVRX6sEmWLeB/lyTPGTA2fUh4l5PqTISQ
         2MUfj3V6YN5zXUI76iOCCzwfF+TFJ2C+l8dt1KJJd20xv/yLxczM1AoLlAhw8yCCQ9E2
         2cHFqc+fBH0sBd4m1O82k84fFjt/f4B85VB4TtCldDJY6NWEIL0AxARTGwpZH+JHbfHV
         pAIra9m9dR9GJIgQRDsC2phOOWed6BWZuppwXD9UZIx/aTGDp5McAn+0Rc+8WmtZFZGh
         QFsQ==
X-Gm-Message-State: AOJu0YwjWqMMFrEMg8mNK/FY32aorVrdcPQ6SC63JRYPrycUmTtCLnA7
        JfuhEFTd4ksVB3COA9EHkTV2Vmi2TmgsbA==
X-Google-Smtp-Source: AGHT+IFz0yvRLyejcqEDMcaIlMFzc4owPVFYTRbeVdEcT697NGWceR+YslKnVemhGgZ6tgD7zbM1DA==
X-Received: by 2002:a0d:ca8e:0:b0:58c:f957:d1c4 with SMTP id m136-20020a0dca8e000000b0058cf957d1c4mr2506104ywd.36.1693574786236;
        Fri, 01 Sep 2023 06:26:26 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id w198-20020a8149cf000000b00577139f85dfsm1046619ywa.22.2023.09.01.06.26.26
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 06:26:26 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5922380064bso21612097b3.2
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 06:26:26 -0700 (PDT)
X-Received: by 2002:a25:76d6:0:b0:d7a:d018:5a37 with SMTP id
 r205-20020a2576d6000000b00d7ad0185a37mr1113558ybc.39.1693574785846; Fri, 01
 Sep 2023 06:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <8f12d3b4b5fdeae4e465fc8fbf843e2878f17b55.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <8f12d3b4b5fdeae4e465fc8fbf843e2878f17b55.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 15:26:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6eGEFH9wbqWOV07gi=vcgfsdnnrZm9UG8wCjYRwRYsQ@mail.gmail.com>
Message-ID: <CAMuHMdX6eGEFH9wbqWOV07gi=vcgfsdnnrZm9UG8wCjYRwRYsQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 10/12] serial/sh-sci: Fix earlyprintk / earlycon.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Thu, Aug 31, 2023 at 11:23 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> - earlyprintk having fault.
> - fix shortname conflict.
> - fix SCI regshift in SH4.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2721,7 +2721,7 @@ static int sci_remap_port(struct uart_port *port)
>         if (port->membase)
>                 return 0;
>
> -       if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
> +       if ((port->dev && port->dev->of_node) || (port->flags & UPF_IOREMAP)) {

Why is this needed? It works fine on arm32, arm64, and riscv.

>                 port->membase = ioremap(port->mapbase, sport->reg_size);
>                 if (unlikely(!port->membase)) {
>                         dev_err(port->dev, "can't remap port#%d\n", port->line);
> @@ -3507,6 +3507,10 @@ static int __init early_console_setup(struct earlycon_device *device,
>         if (!device->port.membase)
>                 return -ENODEV;
>
> +       if (type == PORT_SCI &&
> +           (IS_ENABLED(CONFIG_CPU_SH3) || IS_ENABLED(CONFIG_CPU_SH4))) {
> +               device->port.regshift = 2;
> +       }

How do you run into this, given you don't have any SCI ports enabled
in your DTS, only SCIF?

Anyway, I think this should be fixed in sci_init_single(), by extending
the driver to support the more-or-less standard "reg-shift" DT property
(as I said before in
https://lore.kernel.org/all/CAMuHMdW2gxDzYbP_0Z90o8mHdUm_BV6e+gMHpELJx_g=ezAbdw@mail.gmail.com).

>         device->port.serial_in = sci_serial_in;
>         device->port.serial_out = sci_serial_out;
>         device->port.type = type;
> @@ -3556,8 +3560,8 @@ static int __init hscif_early_console_setup(struct earlycon_device *device,
>
>  OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
>  OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
> -OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_setup);
> -OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_console_setup);
> +OF_EARLYCON_DECLARE(rzscif, "renesas,scif-r7s9210", rzscifa_early_console_setup);
> +OF_EARLYCON_DECLARE(rzscif, "renesas,scif-r9a07g044", rzscifa_early_console_setup);

Why?

>  OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
>  OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
>  OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
