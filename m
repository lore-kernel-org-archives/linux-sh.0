Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7E1EED60B
	for <linux-sh@archiver.kernel.org>; Fri, 15 Sep 2023 15:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbjIOPnk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 15 Sep 2023 11:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbjIOPnX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 15 Sep 2023 11:43:23 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FF519A0
        for <linux-sh@vger.kernel.org>; Fri, 15 Sep 2023 08:43:15 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d7eccc1b8c6so2351487276.0
        for <linux-sh@vger.kernel.org>; Fri, 15 Sep 2023 08:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694792594; x=1695397394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Igg6vlfAA0dbiHSWNDNCabUxO+o9QOSFgOJAF/VaFK0=;
        b=limGsoLvq3EG6A778e0ienFtsKFKamwXzUsxb59je21mQEfSx041I64B2G9Hg5dnf1
         HPhNubxohJi+AzxvL2Dmw2Y9BgW+PtZXQMEql2x/U/kljqIKsx2p0uBPs5FXmaoODHkT
         rlxzZBsc0ZvykU2ck5IeO+JS3hcDoswz2cCjRXFyW5Okoo4Iq1GXL/eaQovoHiZSuZBj
         SREfbeefRiAkKKyIJUM338cbT1O8u7VSO2u2Wy9CExBqIi20gWBtQtIgFAKfdKgIt4hh
         9L2dM+7tXShEVEDKdIhxXEzydGY5Ll5u89eJWQRV9Sgyg79BZCpfqm3H47+CNsW91Ub8
         CMJg==
X-Gm-Message-State: AOJu0Yxl7Vi0cyGQi8lmLH2CdrjHXNHxhUL8exsDAx4s++Jat1kDRXvl
        2h/IT+vh0US914LLRvPDwM0uOg+M4uEkLQ==
X-Google-Smtp-Source: AGHT+IEtge/Tm0RU0NZ4bK0N1sxBZ4/oIIq1VpfVZyrEGV9GTUqE0xQxlKJXt76h8A7fAJKUh2N4VA==
X-Received: by 2002:a81:5f09:0:b0:581:5cb9:6c2b with SMTP id t9-20020a815f09000000b005815cb96c2bmr2227125ywb.45.1694792594504;
        Fri, 15 Sep 2023 08:43:14 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id n124-20020a0dfd82000000b005925c896bc3sm925137ywf.53.2023.09.15.08.43.14
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:43:14 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-591ba8bd094so23663887b3.3
        for <linux-sh@vger.kernel.org>; Fri, 15 Sep 2023 08:43:14 -0700 (PDT)
X-Received: by 2002:a0d:df8f:0:b0:59c:8b3:6855 with SMTP id
 i137-20020a0ddf8f000000b0059c08b36855mr2153710ywe.5.1694792593917; Fri, 15
 Sep 2023 08:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <d63793503fbbc7d5ca7b40d6b31678d371b69c29.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <d63793503fbbc7d5ca7b40d6b31678d371b69c29.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 17:43:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWY0gr-2eaGhoyeAib9=ABPWZqnYU6iAEUHAmVZiYUYNw@mail.gmail.com>
Message-ID: <CAMuHMdWY0gr-2eaGhoyeAib9=ABPWZqnYU6iAEUHAmVZiYUYNw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 26/30] arch/sh: RTS7751R2D Plus DeviceTree.
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

> --- /dev/null
> +++ b/arch/sh/boot/dts/rts7751r2dplus.dts
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the Renesas RTS7751R2D Plus
> + */
> +
> +/dts-v1/;
> +
> +#include "sh7751.dtsi"
> +
> +/ {
> +       model = "Renesas RTS7715R2D Plus";
> +       compatible = "renesas,r2dplus";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&shintc>;
> +
> +       aliases {
> +               serial0 = &scif1;
> +       };
> +
> +       chosen {

I had to add

    stdout-path = "serial0:115200n8";

to get serial console output on qemu/r2d.

> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
