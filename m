Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB797CD5BA7
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 12:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjISMZZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 08:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjISMZZ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 08:25:25 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA16F5
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:25:19 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59c26aa19b7so34760257b3.2
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126318; x=1695731118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aChHu6Qnk/1yjMRTWJfL0YSf0JvDbAgZMRzoO7n7wNg=;
        b=JLPh6xYoctorUiyYAoltLm9nIiOhoB/+C5P1lxjfQkSpWTya/4RgdLlYzW0z6Qg9wL
         sy4HCWXwEB7aJksqt3pDGNAss2Xc6K740LWmuNYW4znrwjE1H5/PeX45m2l5Bg2Iow0v
         n95a+C0JtbZYPIA+xrUULAA2Q0BudYjrHTlqjKSqhLPk/6RppPLNdwr+Je4Ojvh8dFRy
         P9sm/XUvp0I9f+HW+56fNSwWiIl/pmadgsL6argkrdgjfmNBUn3Vr3YK4U6bjLghvww2
         8bCeM/G4MoIXUwS7MFjuUtbt8N5cjOj0ndK5h67BdjwFlD6GY2AbglH+8f9BQ4wTEfs0
         VA0A==
X-Gm-Message-State: AOJu0Yy08EbRMUJVWKVyk/WRXZa5phwMDifAiU7tKIqk6CI6koX4j5X1
        DB7t2izb1LbWAi3CytJ+NgXUx5cgnDHYVw==
X-Google-Smtp-Source: AGHT+IGgEUrCBxFOaJXJFlzwYV23f6hJQIixj9tIekEc2++oG+Pyl3aL96lmRpfnqBVonHOdadOKiA==
X-Received: by 2002:a25:ab6c:0:b0:d78:1724:1b1a with SMTP id u99-20020a25ab6c000000b00d7817241b1amr11607629ybi.37.1695126318563;
        Tue, 19 Sep 2023 05:25:18 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id y190-20020a25dcc7000000b00d1b86efc0ffsm2849639ybe.6.2023.09.19.05.25.18
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:25:18 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d8164e661abso5528527276.1
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:25:18 -0700 (PDT)
X-Received: by 2002:a25:6904:0:b0:d81:8d15:d850 with SMTP id
 e4-20020a256904000000b00d818d15d850mr12007685ybc.53.1695126317908; Tue, 19
 Sep 2023 05:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <cef5926b1fbf18d2a3aec93dca8f1a9fb579e643.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <cef5926b1fbf18d2a3aec93dca8f1a9fb579e643.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 14:25:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxJO9P0k6rmFnwJVrwj7mumAaDnioOQmgzeKrRh41_2A@mail.gmail.com>
Message-ID: <CAMuHMdWxJO9P0k6rmFnwJVrwj7mumAaDnioOQmgzeKrRh41_2A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 19/30] drivers/tty: sh-sci fix SH4 OF support.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

Thanks for your patch!

On Wed, Sep 13, 2023 at 11:26 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> - fix earlycon name.

I guess you mean earlyprintk?

"Earlyprintk expects that all names used in OF_EARLYCON_DECLARE()
 are unique".

> - fix earlyprintk hung (NULL pointer reference).
> - clocks property support.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c

> @@ -2842,6 +2842,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
>                          * global "peripheral_clk" clock.
>                          */
>                         clk = devm_clk_get(dev, "peripheral_clk");
> +                       if (IS_ERR(clk))
> +                               clk = devm_clk_get(dev, NULL);

This should not be needed.
I guess this is a workaround for the lack of

        clock-names = "fck";

in arch/sh/boot/dts/sh7751.dtsi?

"make dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/renesas,scif.yaml"
would have told you ;-)

    serial@ffe80000: 'clock-names' is a required property

>                         if (IS_ERR(clk))
>                                 return dev_err_probe(dev, PTR_ERR(clk),
>                                                      "failed to get %s\n",
> @@ -3555,8 +3557,8 @@ static int __init hscif_early_console_setup(struct earlycon_device *device,
>
>  OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
>  OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
> -OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_setup);
> -OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_console_setup);
> +OF_EARLYCON_DECLARE(rzscif, "renesas,scif-r7s9210", rzscifa_early_console_setup);
> +OF_EARLYCON_DECLARE(rzscif, "renesas,scif-r9a07g044", rzscifa_early_console_setup);

Perhaps "rzscifa", to match the setup function prefix?

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
