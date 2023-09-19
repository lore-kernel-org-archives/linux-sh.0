Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BD9CD5BA3
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 12:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjISMKX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 08:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISMKW (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 08:10:22 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B1BF5
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:10:17 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59c0281d72dso46574737b3.0
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125416; x=1695730216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV8T6G+dbFUD/QGF3OJQuIGMyPLwz2yKPVDuUsZZ7rk=;
        b=ZbHkf1K1OH1q5pfHtGsajy7U2m9LpYPeOUMUEEn9rdC0V+7nfHaZz6CoXTDLoquXRB
         K3HvEiTqbALz15wtSoRvf5AVBkub6DqmU25UQ/9w6GQuIdJtvaZFHWUp0LtJ66rdiCws
         kcXM98B3LhUPhq5CT79vav5TgjEaKJE7JGSGytptlfw21mhRwjyNxMxLIUzCUqWyb2ys
         DzlP8f/PCeTJ1WH2oDtDLrrnpnpbNXmrmBDafpYT6E0AIPzFWUoah7XDCITlQ8Y/dQrS
         RiegWeS74ipEZFMDthMTG7us8z5bME6BFn47KIDuh4JLOuJhulX0XWfuuP+WmnQQ0UMi
         +jDw==
X-Gm-Message-State: AOJu0YwkQ+xUgfeJ7t5R+F4+A6zFCcdiXk29PgjtddWGtpd/XG+bvb/J
        MJfY1VtBrVDK97XOv0Yb2EsvttReWqceag==
X-Google-Smtp-Source: AGHT+IHSsKfaojMHT8ShA3fdmvNHWZkKScWMHDCbA7FL45iylT3EshF5CpPCeJ/nB4ygHu0lHTwtMg==
X-Received: by 2002:a0d:c981:0:b0:59b:14ca:4316 with SMTP id l123-20020a0dc981000000b0059b14ca4316mr12097906ywd.43.1695125416340;
        Tue, 19 Sep 2023 05:10:16 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id ci26-20020a05690c0a9a00b005869e1d8c41sm2203515ywb.29.2023.09.19.05.10.16
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:10:16 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59c07cf02ebso43111537b3.1
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:10:16 -0700 (PDT)
X-Received: by 2002:a25:26ca:0:b0:d09:34f4:6698 with SMTP id
 m193-20020a2526ca000000b00d0934f46698mr11458552ybm.36.1695125415936; Tue, 19
 Sep 2023 05:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <ca08873f80dfc356ae4fed363b9cc6ef5e9c8af6.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <ca08873f80dfc356ae4fed363b9cc6ef5e9c8af6.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 14:10:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU5sH7dP_UkwgSN5kYBTL6nOwCvq_9CJMuG7Y03dur=dQ@mail.gmail.com>
Message-ID: <CAMuHMdU5sH7dP_UkwgSN5kYBTL6nOwCvq_9CJMuG7Y03dur=dQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 16/30] drivers/irqchip: SH7751 IRL external encoder
 with enable gate.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:27 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> SH7751 have 15 level external interrupt.
> It is typically connected to the CPU through a priority encoder
> that can suppress requests.
> This driver provides a way to control those hardware with irqchip.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -688,4 +688,11 @@ config RENESAS_SH7751_INTC
>           Support for the Renesas SH7751 On-chip interrupt controller.
>           And external interrupt encoder for some targets.
>
> +config RENESAS_SH7751IRL_INTC
> +        bool "Renesas SH7751 based target IRL encoder support."
> +       depends on RENESAS_SH7751_INTC
> +       help

Inconsistent indentation

> +         Support for External Interrupt encoder
> +         on the some Renesas SH7751 based target.
> +
>  endmenu

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
