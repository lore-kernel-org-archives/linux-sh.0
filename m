Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DBBCDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 14:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjJROEv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjJROEv (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 10:04:51 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F4383
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 07:04:49 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a82c2eb50cso64797877b3.2
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 07:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637889; x=1698242689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOZyptRzKt8AGlez2aBikOrKCc3gF/4SOd3agr/6M34=;
        b=sY4uQBlUI03DYQRJtldPUBMDFQxAEYwPu6JANFuvb9G8dDSHbRcIJL9R3E22ZWRrNA
         sEyar9kraoV+TCsOWRsrCqaoRHnnJ244dp8DyQxZssKO6DIn480DnocJK1Fb3Pj2i8aQ
         3O7TF2j20wSYKTovKesJWGy0agZ5pxKClVx+JQ6ucB7kElAchH64kj4SW/X/3tFHmjOK
         9qLEVWuK4r7YLOMkJde987aFHB/ohtBs4yDvwcrTH7SewCX3DqhcOduCkRYCEoQVVoO4
         8DjDaRZ7lbsm1EuOVhlOCKBrTIcsuhEQY44C0wSFhyWEi3wwXCGU8dgci1LNr0OMkcQl
         wfAw==
X-Gm-Message-State: AOJu0YyQGwSlnGRkx9jx2gMaQNaHf4a1DKULr1K2zGWhfaycRYwYnaTW
        hwDfILx4izi2Xi1afy3gXHDDgzZEeeUlAQ==
X-Google-Smtp-Source: AGHT+IGUHYADTIax9ge26NsTKQxkdtP97d6ouWFU1QWYlt0d69HlNt8a1PzpZes/XnL2RPKyd1IdfQ==
X-Received: by 2002:a0d:e688:0:b0:5a8:2744:1565 with SMTP id p130-20020a0de688000000b005a827441565mr5616714ywe.4.1697637888488;
        Wed, 18 Oct 2023 07:04:48 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id w20-20020a81a214000000b005925c896bc3sm1521272ywg.53.2023.10.18.07.04.48
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 07:04:48 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a7c95b8d14so87541397b3.3
        for <linux-sh@vger.kernel.org>; Wed, 18 Oct 2023 07:04:48 -0700 (PDT)
X-Received: by 2002:a0d:eb15:0:b0:59f:7fb9:621a with SMTP id
 u21-20020a0deb15000000b0059f7fb9621amr5864158ywe.22.1697637887918; Wed, 18
 Oct 2023 07:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <4596e6d37f626672986ef67e9e7e328db9077b71.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <4596e6d37f626672986ef67e9e7e328db9077b71.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 16:04:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVyq3jGb0ZRsM5Zbsw=WD=ndsPELkCJmSHNfp7AwT-6A@mail.gmail.com>
Message-ID: <CAMuHMdUVyq3jGb0ZRsM5Zbsw=WD=ndsPELkCJmSHNfp7AwT-6A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 19/35] Documentation/devicetree/bindings/serial:
 renesas,scif.yaml Add SH.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -81,6 +81,11 @@ properties:
>                - renesas,scif-r9a07g054      # RZ/V2L
>            - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
>
> +      - items:
> +          - enum:
> +              - renesas,scif-sh7751   # SH7751
> +          - const: renesas,scif       # generic SCIF compatible UART

There is no need to add a new "items" section.
Just add "renesas,scif-sh7751" to the first "items" section at the top.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
