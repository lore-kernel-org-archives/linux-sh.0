Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2ABCDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 18:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjJRSuQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 14:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjJRSuP (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 14:50:15 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D23114;
        Wed, 18 Oct 2023 11:50:13 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-59b5484fbe6so87990407b3.1;
        Wed, 18 Oct 2023 11:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697655012; x=1698259812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmbiZvC/7dQ+VY3RX5RbhFdc27/3OB6TM8pck8su/4I=;
        b=VujEdPtd15g/OgU7MCWpZARuSezq9NnOKzVkOjzB3ujHhHENMRT+TDqqAHIi4u3qwX
         dn99fWBmPQcFPq2JMpOprvRbUcL6T1fvrCj13GxuvaySNUHBZNxPdvAeD6nss7NZlLV1
         ZR6qdP+zoIqE2SZilJbrsMBhLESXDrPSlkpKU11KBCfLAnj2ZSD8xJeJzg3IIiffuIwY
         /aexi7eRz11RuirIigEkcqIsLOLjK5K0n6xynOLKAMF52ygBbx8ZcxiISsRR7BNQI9Nc
         MLxd1AWAeY6fltBnDiA6JESKPLf59bWkyg7km/P/zr39WtY+2fvp2IdYAX5LE7K3nNnB
         stpQ==
X-Gm-Message-State: AOJu0Yw8IBk8jJJaLHogU2xZ9kt30MEtoNmfCgciVaHh58Im7IqSamVf
        i1aQVkMW6AZoMFp3Z7zIhja8NyjjK/8wAA==
X-Google-Smtp-Source: AGHT+IHQVmX6zRiY5VeWoJ2/fqwOK8hN2lkgKgmu5RdBxEI3sV5301tpu7loILYYfFCVAScV6kjuSA==
X-Received: by 2002:a25:c807:0:b0:d9a:3992:192d with SMTP id y7-20020a25c807000000b00d9a3992192dmr261388ybf.16.1697655012480;
        Wed, 18 Oct 2023 11:50:12 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id a3-20020a259383000000b00d72176bdc5csm1460858ybm.40.2023.10.18.11.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:50:11 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a7ad24b3aaso87705637b3.2;
        Wed, 18 Oct 2023 11:50:11 -0700 (PDT)
X-Received: by 2002:a0d:ebc4:0:b0:5a7:be8c:e85 with SMTP id
 u187-20020a0debc4000000b005a7be8c0e85mr156797ywe.24.1697655011019; Wed, 18
 Oct 2023 11:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <35311df6cf65c9f110604cbbdecad2f15ac602b6.1697199949.git.ysato@users.sourceforge.jp>
 <CAMuHMdVjyPchHd8Hzcy+1Pv-57M_eD9rPSDmT88M3bSeEUn86A@mail.gmail.com>
In-Reply-To: <CAMuHMdVjyPchHd8Hzcy+1Pv-57M_eD9rPSDmT88M3bSeEUn86A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 20:49:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX79+Y1R7XL23A-OBbEK7qO4zMa91+89by63X--U2nkxQ@mail.gmail.com>
Message-ID: <CAMuHMdX79+Y1R7XL23A-OBbEK7qO4zMa91+89by63X--U2nkxQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 29/35] Documentation/devicetree/bindings/soc/renesas/sh.yaml:
 Add SH7751 based target.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Oct 18, 2023 at 8:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> > +              - iodata,landisk  # LANDISK HDL-U
> > +              - iodata,usl-5p   # USL-5P
>
> These depend on "[RFC PATCH v3 27/35] Documentation/devicetree/bindings:
> vendor-prefix add IO DATA DEVICE Inc.", so that patch should be moved

My apologies. Somehow the patches didn't end up in the right order
in my mailbox, so please ignore this comment.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
