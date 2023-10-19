Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70EFCDB465
	for <linux-sh@archiver.kernel.org>; Thu, 19 Oct 2023 07:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjJSHTQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Oct 2023 03:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjJSHTN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 19 Oct 2023 03:19:13 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551BD9F;
        Thu, 19 Oct 2023 00:19:12 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-579de633419so94650487b3.3;
        Thu, 19 Oct 2023 00:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697699951; x=1698304751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qe8JMzEOoVEtr+s55csrTBv3rV8C974uRP6q9AzcSlc=;
        b=skPvRB7m3TPYol2Jp1traRsUBedEXYp1Kc2EYx0NRnBKE8pC9QBiH/r2GZtLpIw2vS
         FRWE/8yyESbHgAaOYUK3K2mO3kN4vXu/+yf0y4wklindcrNiG3JEy+feXdfoc0PLohu3
         ZCQ1+ZUheI2GYB5Vwoz3IXv1VOBgsJzEc+4cDvrRWRE+jZaEVpnbDqWJDZ0CGx8MCjjh
         I2k9gayazj8XcCuscuFuxro/aSXvjljQRZcsJrAIIoFpVcRxSE8n5PpA3ZfNV21ttU8y
         GhbcEKFdIJG+XBsn079NwdciwOr6w94s2kNjmH1Ofjwri2McveeuG7Q+6l9EOeoY8BoN
         djxQ==
X-Gm-Message-State: AOJu0YxucrV4KMxGNe2nbAngFTU55BckCj8tQVI+KOnchqQ90U9Hiifh
        hGeceQomh8hcALXF2oIOhA2qWC8gzD6e1A==
X-Google-Smtp-Source: AGHT+IGED7tXdL8IAc70SjR61szELnOTsuYyuVCXjj3vRfscxcVgB/wK3KM4tTCTaUxbCU34nMGl9g==
X-Received: by 2002:a0d:e644:0:b0:569:479f:6d7f with SMTP id p65-20020a0de644000000b00569479f6d7fmr1577351ywe.43.1697699950944;
        Thu, 19 Oct 2023 00:19:10 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id n69-20020a0dcb48000000b0059f8120ee4dsm2234203ywd.30.2023.10.19.00.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 00:19:10 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a86b6391e9so54428857b3.0;
        Thu, 19 Oct 2023 00:19:10 -0700 (PDT)
X-Received: by 2002:a81:b40e:0:b0:59b:c6a4:15c7 with SMTP id
 h14-20020a81b40e000000b0059bc6a415c7mr1407978ywi.46.1697699950549; Thu, 19
 Oct 2023 00:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <a772e1b6de89af22057d3af31cc03dcad7964fc7.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <a772e1b6de89af22057d3af31cc03dcad7964fc7.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Oct 2023 09:18:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVtNcUAh5ZeeXyfvS+F=zyJ_4KFoEYxuXONMJ_xH1zwDg@mail.gmail.com>
Message-ID: <CAMuHMdVtNcUAh5ZeeXyfvS+F=zyJ_4KFoEYxuXONMJ_xH1zwDg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 12/35] drivers/clk/renesas: clk-sh7750.c
 SH7750/7751 CPG driver.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> This driver supported SH7750/7751 PLL/Divider clock and module stop.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/clk/renesas/clk-sh7750.c

> +static void sbcr_sw(struct clk_hw *hw, bool on)
> +{
> +       struct clk_gate *gate = to_clk_gate(hw);
> +       u8 msk = BIT(gate->bit_idx);
> +       u8 val;
> +
> +       val = readb(gate->reg);
> +       if (on)
> +               val &= ~msk;
> +       else
> +               val |= msk;
> +       writeb(val, gate->reg);
> +}
> +
> +static int sbcr_enable(struct clk_hw *hw)
> +{
> +       sbcr_sw(hw, true);
> +       return 0;
> +}
> +
> +static void sbcr_disable(struct clk_hw *hw)
> +{
> +       sbcr_sw(hw, false);
> +}
> +
> +static int sbcr_is_enabled(struct clk_hw *hw)
> +{
> +       u8 val;
> +       struct clk_gate *gate = to_clk_gate(hw);
> +
> +       val = readb(gate->reg);
> +       val &= 1 << gate->bit_idx;
> +       return val != 0;

This condition is inverted: 0 is enabled, 1 is stopped.

> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
