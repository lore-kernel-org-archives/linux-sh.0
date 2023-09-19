Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEE0CD54B9
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 11:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjISLud convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 07:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLud (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 07:50:33 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B60BA
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 04:50:27 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59c268676a9so33047157b3.0
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 04:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695124226; x=1695729026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4ge1ztQC1pNK8wSoePPYMwfiYI1KHgJ1reywHYdVvk=;
        b=Q6PTRy4rZx/FDlEW0LrtKl2V5fWjhHAKTTxjf/XTzYqsL66OM5QNN9Gli65lGhwdKB
         yrvyJsdY+gWL7KiFdVV0NK2g62iVgXIjipWEyC6Ms26bZSSEL5eMcH3DeZHuPRdQgzoC
         bAHw5wCdXbRGLpcboKQvxwak4IUamMYOjuvPqKsQtodg3lAWfwOX3lbWefB0mzmjZwVK
         tSooiYB1+ymz8GCOXj2FHEzEbHdXfmo8E4tg5zejhK9xyhRBE+vWjx2Vwb6SSsZPbpul
         +1jgraRUJ8vtgu8Kf3gP+x5OWfSllJUTRwJavbIH4wXxcJu4EhQt328eFzEVBa+IpOmA
         VSEg==
X-Gm-Message-State: AOJu0Yxg7maTIJu+G72MEwQM5s+tuTgXZNn7aJBDqBsfb9jxDAsTEwB3
        oMydCVwFxvse67RerxtHJ534BsrbPkyV0g==
X-Google-Smtp-Source: AGHT+IEwryfD5883u+MXPsy70L2mAi/fjy2qMJTwZZ4iEatIb9pn2fKIiMPPU/v2RWJ6/B893Zkyrw==
X-Received: by 2002:a0d:d247:0:b0:59b:2be2:3560 with SMTP id u68-20020a0dd247000000b0059b2be23560mr10238768ywd.48.1695124226203;
        Tue, 19 Sep 2023 04:50:26 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id r83-20020a0de856000000b00597f533cc64sm3141149ywe.9.2023.09.19.04.50.25
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 04:50:25 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59c268676a9so33046997b3.0
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 04:50:25 -0700 (PDT)
X-Received: by 2002:a81:8004:0:b0:59b:524a:7238 with SMTP id
 q4-20020a818004000000b0059b524a7238mr11044382ywf.26.1695124225233; Tue, 19
 Sep 2023 04:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <1f9decd26e1321e30ca5091c2447456f0e81efe1.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <1f9decd26e1321e30ca5091c2447456f0e81efe1.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 13:50:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXv3TPa=mCrso9P1Mbh8yCAzNusiX9ELF3mFCi4oY0igA@mail.gmail.com>
Message-ID: <CAMuHMdXv3TPa=mCrso9P1Mbh8yCAzNusiX9ELF3mFCi4oY0igA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/30] drivers/irqchip: Add SH7751 Internal INTC drivers.
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
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -679,4 +679,13 @@ config SUNPLUS_SP7021_INTC
>           chained controller, routing all interrupt source in P-Chip to
>           the primary controller on C-Chip.
>
> +config RENESAS_SH7751_INTC
> +        bool "Renesas SH7751 Interrupt Controller"
> +       depends on SH_DEVICE_TREE

"|| COMPILE_TEST"?

> +       select IRQ_DOMAIN
> +       select IRQ_DOMAIN_HIERARCHY
> +       help
> +         Support for the Renesas SH7751 On-chip interrupt controller.
> +         And external interrupt encoder for some targets.

Inconsistent indentation

> --- /dev/null
> +++ b/drivers/irqchip/irq-renesas-sh7751.c

> +/* INTEVT to IPR mapping */
> +static const struct iprmap {
> +       int intevt;

irq, as you're storing the irq number not the event number?

> +       int off;
> +       int bit;

All unsigned int ...

> +} iprmaps[] = {
> +#define IPRDEF(e, o, b) { .intevt = evt2irq(e), .off = o, .bit = b }
> +       IPRDEF(0x240, IPRD, IPR_B12),   /* IRL0 */
> +       IPRDEF(0x2a0, IPRD, IPR_B8),    /* IRL1 */
> +       IPRDEF(0x300, IPRD, IPR_B4),    /* IRL2 */
> +       IPRDEF(0x360, IPRD, IPR_B0),    /* IRL3 */
> +       IPRDEF(0x400, IPRA, IPR_B12),   /* TMU0 */
> +       IPRDEF(0x420, IPRA, IPR_B8),    /* TMU1 */
> +       IPRDEF(0x440, IPRA, IPR_B4),    /* TMU2 TNUI */
> +       IPRDEF(0x460, IPRA, IPR_B4),    /* TMU2 TICPI */
> +       IPRDEF(0x480, IPRA, IPR_B0),    /* RTC ATI */
> +       IPRDEF(0x4a0, IPRA, IPR_B0),    /* RTC PRI */
> +       IPRDEF(0x4c0, IPRA, IPR_B0),    /* RTC CUI */
> +       IPRDEF(0x4e0, IPRB, IPR_B4),    /* SCI ERI */
> +       IPRDEF(0x500, IPRB, IPR_B4),    /* SCI RXI */
> +       IPRDEF(0x520, IPRB, IPR_B4),    /* SCI TXI */
> +       IPRDEF(0x540, IPRB, IPR_B4),    /* SCI TEI */
> +       IPRDEF(0x560, IPRB, IPR_B12),   /* WDT */
> +       IPRDEF(0x580, IPRB, IPR_B8),    /* REF RCMI */
> +       IPRDEF(0x5a0, IPRB, IPR_B4),    /* REF ROVI */
> +       IPRDEF(0x600, IPRC, IPR_B0),    /* H-UDI */
> +       IPRDEF(0x620, IPRC, IPR_B12),   /* GPIO */
> +       IPRDEF(0x640, IPRC, IPR_B8),    /* DMAC DMTE0 */
> +       IPRDEF(0x660, IPRC, IPR_B8),    /* DMAC DMTE1 */
> +       IPRDEF(0x680, IPRC, IPR_B8),    /* DMAC DMTE2 */
> +       IPRDEF(0x6a0, IPRC, IPR_B8),    /* DMAC DMTE3 */
> +       IPRDEF(0x6c0, IPRC, IPR_B8),    /* DMAC DMAE */
> +       IPRDEF(0x700, IPRC, IPR_B4),    /* SCIF ERI */
> +       IPRDEF(0x720, IPRC, IPR_B4),    /* SCIF RXI */
> +       IPRDEF(0x740, IPRC, IPR_B4),    /* SCIF BRI */
> +       IPRDEF(0x760, IPRC, IPR_B4),    /* SCIF TXI */
> +       IPRDEF(0x780, IPRC, IPR_B8),    /* DMAC DMTE4 */
> +       IPRDEF(0x7a0, IPRC, IPR_B8),    /* DMAC DMTE5 */
> +       IPRDEF(0x7c0, IPRC, IPR_B8),    /* DMAC DMTE6 */
> +       IPRDEF(0x7e0, IPRC, IPR_B8),    /* DMAC DMTE7 */
> +       IPRDEF(0xa00, INTPRI00, IPR_B0),        /* PCIC PCISERR */
> +       IPRDEF(0xa20, INTPRI00, IPR_B4),        /* PCIC PCIDMA3 */
> +       IPRDEF(0xa40, INTPRI00, IPR_B4),        /* PCIC PCIDMA2 */
> +       IPRDEF(0xa60, INTPRI00, IPR_B4),        /* PCIC PCIDMA1 */
> +       IPRDEF(0xa80, INTPRI00, IPR_B4),        /* PCIC PCIDMA0 */
> +       IPRDEF(0xaa0, INTPRI00, IPR_B4),        /* PCIC PCIPWON */
> +       IPRDEF(0xac0, INTPRI00, IPR_B4),        /* PCIC PCIPWDWN */
> +       IPRDEF(0xae0, INTPRI00, IPR_B4),        /* PCIC PCIERR */
> +       IPRDEF(0xb00, INTPRI00, IPR_B8),        /* TMU3 */
> +       IPRDEF(0xb80, INTPRI00, IPR_B12),       /* TMU4 */

Probably the same or a very similar interrupt controller is present
on other SoCs? Then the comments don't make much sense, as the actual
interrupt mapping is specified in the DTS anyway.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
