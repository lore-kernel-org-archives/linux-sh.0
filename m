Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8607CDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 13:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjJRNjz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 09:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjJRNjy (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 09:39:54 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A697D95
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 06:39:52 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a7af45084eso87494727b3.0
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 06:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697636391; x=1698241191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZM9Zpj8ZtiQ2WGIfXXU0k/WE9ixUp1msCIHLVH9TmA=;
        b=xL5ajcjccNzQs+TiMIi/CirMi5ppIzB1/6uD/+puay3MAj4Dpzhz5E5B3dWdQbCgYO
         zJQg6Pa7Krt4MROdYQ0edLjq8pO/TdmdycwNOjTT+UwTCWOtL3pmWwvn+3DZeXEsWhfm
         8mnN88Z6B0efg9HiLx9chWeCi0eWt8pwxHrff6zkd0pLypwtJZy97UA4F3ta0OFkbm3z
         tfnI4BZcwRbcpd8y/UKk0eu6eZ0D5YT8L5A71dYim4Ypn27fwiuQge7BwyKetOev4qRB
         iKRB3vTtjLe2jBhw6UxFxKOND0IPbcJv8fzgWio75++m2ZKhEbiBuju4YmtiRz69U61Y
         AIpw==
X-Gm-Message-State: AOJu0Yyo1xoIEW+dblQcsZlg3E14E76sJ4cPsOGll/0ox2hhxoQJ1SQu
        Ao2W2ZNrQ28g95n2WfYZWQpFP+OmEu2dXQ==
X-Google-Smtp-Source: AGHT+IEs8zhFf84bu/SAyBMgw7PvwkEXWbptf6g0dKFa6Gc5XqoFrhYHixVmksuBN4RPBDcJdLD30Q==
X-Received: by 2002:a81:7782:0:b0:599:b570:2db7 with SMTP id s124-20020a817782000000b00599b5702db7mr5574656ywc.30.1697636391595;
        Wed, 18 Oct 2023 06:39:51 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id x144-20020a81a096000000b00589c103d00asm1508209ywg.79.2023.10.18.06.39.51
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 06:39:51 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a7af45084eso87494477b3.0
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 06:39:51 -0700 (PDT)
X-Received: by 2002:a05:690c:d89:b0:5a7:aa7f:17d5 with SMTP id
 da9-20020a05690c0d8900b005a7aa7f17d5mr6425384ywb.11.1697636390936; Wed, 18
 Oct 2023 06:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <5fd6a128de04b88bb22520cffe955f83af6700b9.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <5fd6a128de04b88bb22520cffe955f83af6700b9.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 15:39:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXpS=BWMnG3h0M=iQ=OGmnj1xXi7oFEsXm-i=tZfQXwyQ@mail.gmail.com>
Message-ID: <CAMuHMdXpS=BWMnG3h0M=iQ=OGmnj1xXi7oFEsXm-i=tZfQXwyQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 24/35] include/dt-binding/interrupt-controller/sh_intc.h:
 renesas,sh7751-intc.h helper
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> SH7751 Interrupt controller binding helper.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/include/dt-bindings/interrupt-controller/sh_intc.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> + *
> + * SH3/4 INTC EVT - IRQ conversion
> + */
> +
> +#define evt2irq(evt)           ((evt) >> 5)
> +#define irq2evt(irq)           ((irq) << 5)

Please drop irq2evt() as it is not used, and not needed, in DTS files.

> +
> +#define IPRDEF(e, o, b)                < e o b >

Please drop this macro, it doesn't add any value.

> +#define IPRA                   0
> +#define IPRB                   4
> +#define IPRC                   8
> +#define IPRD                   12
> +#define INTPRI00               256
> +#define IPR_B12                        12
> +#define IPR_B8                 8
> +#define IPR_B4                 4
> +#define IPR_B0                 0

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
