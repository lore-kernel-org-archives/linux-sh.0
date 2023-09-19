Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18720CD5BB3
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 13:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjISNFc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjISNFb (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 09:05:31 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18BEF4
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:05:25 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59e88a28b98so36399527b3.1
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695128725; x=1695733525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQwd0Y8AxdMEIJB1VBkmPHH0Y0qV2s3MUMQFkR2oUPA=;
        b=hL7MfZb/XMpS8362RfvJ9Sb3vYHr9EmYIwc529QRZr3qtcvQnv+Tcr0LQJ8Tf/krjY
         dthG/p0K8dR8gEo1+cyubX0OwfTCoOA1HjsHwOMVLAUUTu4U5YIkEmWlzAP6ReuEomvM
         s3DNCrfUfvLX54yfEuP1UqHMMcuZhUSP3j77LjWxx3S/wuv9cr7csMXK8NRqOUvl6ARj
         gTfcpUtx2FQK+3PbqSaQZHLZMV3so0ezjvKqx8d4KDYBbCELY/ngNy6b+AFOItI5Mr+x
         EElXtOLxKv4/dXZl3FGR1WL9ItTi4ENl5C5PsyLgLWNnHmlS/6Xbj/W7yyoTTdMVpFb5
         ZSGQ==
X-Gm-Message-State: AOJu0YyMbQQqT0fJNE+6TWPJmkXBHytu5L+aAeGazi3pOxQjbPgf6Lo1
        5Y/EH35efNJF6XWZQeMhu3C8P7gukToqag==
X-Google-Smtp-Source: AGHT+IGFiPxmC4o14wOOE/4c3J0zWrEum9tMTF3Ok3i5+hRAuqi5zRyFhfsQNKDPe2JnEdtVtkcxxQ==
X-Received: by 2002:a81:840a:0:b0:59b:6f83:e564 with SMTP id u10-20020a81840a000000b0059b6f83e564mr2884310ywf.4.1695128724613;
        Tue, 19 Sep 2023 06:05:24 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id i62-20020a815441000000b00592236855cesm3124646ywb.61.2023.09.19.06.05.24
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 06:05:24 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-59e6ebdf949so40941847b3.0
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:05:24 -0700 (PDT)
X-Received: by 2002:a81:48d8:0:b0:586:a680:250 with SMTP id
 v207-20020a8148d8000000b00586a6800250mr2705958ywa.5.1695128724076; Tue, 19
 Sep 2023 06:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <e4dc419e3cc4f44d323aa3686333dafe83b68bce.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <e4dc419e3cc4f44d323aa3686333dafe83b68bce.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 15:05:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXBv+Wbf1XfPxQpLKy-c+zeu_P6Rjk0NV0Fby=AJia79Q@mail.gmail.com>
Message-ID: <CAMuHMdXBv+Wbf1XfPxQpLKy-c+zeu_P6Rjk0NV0Fby=AJia79Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 25/30] include/dt-bindings: Add sh_intc IRQ - EVT
 conversion helper
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
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

>  arch/sh/boot/dts/include/dt-bindings               | 1 +
>  include/dt-bindings/interrupt-controller/sh_intc.h | 7 +++++++
>  2 files changed, 8 insertions(+)
>  create mode 120000 arch/sh/boot/dts/include/dt-bindings
>  create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h
>
> diff --git a/arch/sh/boot/dts/include/dt-bindings b/arch/sh/boot/dts/include/dt-bindings
> new file mode 120000
> index 000000000000..08c00e4972fa
> --- /dev/null
> +++ b/arch/sh/boot/dts/include/dt-bindings
> @@ -0,0 +1 @@
> +../../../../../include/dt-bindings

Do you need this symlink? All other architectures do without.

> --- /dev/null
> +++ b/include/dt-bindings/interrupt-controller/sh_intc.h

This is used by the DTS files, so this patch should be moved up in
this series.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
