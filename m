Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB30CD5BAA
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 12:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjISMnn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 08:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjISMnn (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 08:43:43 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C031AB8
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:43:37 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-59bc956b029so53829807b3.2
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127417; x=1695732217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lvUEn1eImSAr1xB8MAx/p0tSb4BUZ7Vs9BVKxRSVGM=;
        b=lB2c6gLmeS7n2AIbGqLqLBwgJj1WaEU+kyy0HNarFDzpFM8aEX3QBigoHDnebJsKNX
         3a2UTs9SLx8vPkhI/hSU7XB7taZ9fEJcfQncvtfUYgbUGcODmw8Skz5l8XbMgx87m2kL
         dmJqtg5fr8Luy8Ml/th3nr0DShwZqoV6Ykjx3RHxARBjOClaNlhxeuwgMzz5dOH9k9wZ
         AXQ/GgnxNLFWfJIL4dlZD6nxzrA2MOnJ0Oser1qsvTWwR7W+IrbAJYG9JOLg8Vk7yte+
         5gn8CNiFMy2Jyt+5g4lqWrwEBGY2o4pPlHEjW5FhZCIjIau7T0BMnwZHibmqA/q62Ndu
         WjcQ==
X-Gm-Message-State: AOJu0YzeVNa0SO7MnxzD7ifZszp1AI3OshZiRIbeSKyyQvKSiM06wqDr
        ga9rKqJcXPelx+Bb/XsxAHYcT0rm3Om/cA==
X-Google-Smtp-Source: AGHT+IGPDNrucxIX68PQStlboLNkmPQKqmb7hlo3xkQyL/7ro+IxbAj1ewPcejbGZ/CHdcmC1Hybsg==
X-Received: by 2002:a0d:d488:0:b0:59b:c847:bce0 with SMTP id w130-20020a0dd488000000b0059bc847bce0mr10747248ywd.42.1695127416642;
        Tue, 19 Sep 2023 05:43:36 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id o144-20020a0dcc96000000b00576e5af0249sm3131672ywd.20.2023.09.19.05.43.36
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:43:36 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d7e904674aeso5449533276.3
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:43:36 -0700 (PDT)
X-Received: by 2002:a25:d14:0:b0:d81:5d20:97b9 with SMTP id
 20-20020a250d14000000b00d815d2097b9mr9997416ybn.31.1695127416220; Tue, 19 Sep
 2023 05:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <7b5122f6252cf4ce563b2fab2ac61bd794876619.1694596125.git.ysato@users.sourceforge.jp>
 <84014955-92e0-bfd3-f4d3-0bfbf9f0dac5@kernel.org>
In-Reply-To: <84014955-92e0-bfd3-f4d3-0bfbf9f0dac5@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 14:43:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUyGKO0q+RGJCcJj=uoOiEw91RBOLUtdCUWOds6tjsB3Q@mail.gmail.com>
Message-ID: <CAMuHMdUyGKO0q+RGJCcJj=uoOiEw91RBOLUtdCUWOds6tjsB3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 24/30] include/dt-bindings: Add SH7750 CPG header.
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Krzysztof,

On Wed, Sep 13, 2023 at 12:49 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 13/09/2023 11:23, Yoshinori Sato wrote:
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>
> >  include/dt-bindings/clock/sh7750.h | 13 +++++++++++++
>
> Missing vendor prefix.

None of the clock binding definitions for Renesas SoCs use a
vendor prefix. The same is true for various other vendors.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
