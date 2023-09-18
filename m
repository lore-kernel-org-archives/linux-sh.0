Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DABCD13DE
	for <linux-sh@archiver.kernel.org>; Mon, 18 Sep 2023 15:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjIRP30 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjIRP3H (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Sep 2023 11:29:07 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA41AC
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:27:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a9b41ffe11so3335365b6e.2
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050615; x=1695655415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cv7yg3opL+OP0xDyaX5N/l9bhI3rJ5MLCw084hHCWfQ=;
        b=voLuHGDAmfP1iSVkbJMmYwLmwxmes6X3SWRLc6Xvg+uFPGXbBHdGio+2aUhcYP9EVW
         M4ySiXZexmR/RTBlBx5VPFR6ohWnalZjNqpva0/5huMmUzDxefxaBqpYoZfN22090i2O
         jkZYQabTmdZkBrpiPd7yiAqQFTx2NrToYiUOv79TiZXqDEcMGYRcp/KvdYQU1QsKdtaH
         svffaU+69erlby/QJ/O/L8a09ONRVPWqwheInjWJwGJzxrJpSMBmgzOSU0dDn4RGRIMl
         ugpKmORzMa/eo6KKpIn1KcX7M/qVjT0TI+J0B6LIitWdUkDfvLRTzdhP4yvyMghydXUa
         EFrA==
X-Gm-Message-State: AOJu0YxrnochnZ7OkWF79ir+M8nZlkmZSc4V39zAbwh1sbIqjYLTMMLW
        oenPZKQmfKsB6/OoeBR1WohDuveCtMIURw==
X-Google-Smtp-Source: AGHT+IFkBiZs4Cvc7+YrIpXDy0CtCUQAmkhy7F6IE99cHLczwKVpA9x5tGyp2UlT1bism1XMlbuoNQ==
X-Received: by 2002:a9d:4e90:0:b0:6be:e1cd:7326 with SMTP id v16-20020a9d4e90000000b006bee1cd7326mr11250052otk.4.1695050186105;
        Mon, 18 Sep 2023 08:16:26 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id g13-20020a9d618d000000b006b75242d6c3sm4212009otk.38.2023.09.18.08.16.25
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 08:16:25 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ab244ef065so3337291b6e.0
        for <linux-sh@vger.kernel.org>; Mon, 18 Sep 2023 08:16:25 -0700 (PDT)
X-Received: by 2002:a05:6358:e497:b0:142:d62b:304b with SMTP id
 by23-20020a056358e49700b00142d62b304bmr12620673rwb.2.1695050185709; Mon, 18
 Sep 2023 08:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <f8abf3a7f0f9ce83e67968318aa4b3d306a9fa1c.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <f8abf3a7f0f9ce83e67968318aa4b3d306a9fa1c.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 17:16:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUuxThiaiV2mEqgOkHCuE8tGaF6C5WXrcXkioHk5tyh_g@mail.gmail.com>
Message-ID: <CAMuHMdUuxThiaiV2mEqgOkHCuE8tGaF6C5WXrcXkioHk5tyh_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/30] include: sh_intc.h Add stub function "intc_finalize".
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Sep 13, 2023 at 11:35 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> This function not use in OF.

This function is not used with OF.

> avoid unneeded call.

Using a static inline function avoids an external call.

>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
