Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4B1E75438
	for <linux-sh@archiver.kernel.org>; Tue,  3 Oct 2023 09:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjJCJRC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 3 Oct 2023 05:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjJCJRA (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 3 Oct 2023 05:17:00 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA3EAB;
        Tue,  3 Oct 2023 02:16:56 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d77ad095f13so710533276.2;
        Tue, 03 Oct 2023 02:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696324615; x=1696929415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6pmxgdMjNksHv7Jn4j84JaWDZ29B4cnPZQJm+PQPzk=;
        b=R+AXuTVWV3zwtfxhy16IRY03kVUJIvmqV7oD78kxoxQjXKQnGSF8bNTTR9388ZMg69
         LHoBkcYzhddQNZFSmr+a9EBvgr8uta1sCqcR4a90/6GOWYPAf0lnLdEjGLDoUn5aorTu
         SqtsuZwPRGWELD3oLvKfWFWRrBiOUD8v+B07cZv0PMC+gza4DgooB1ZHPSjl4aLY+YAf
         bKfEMPKKz+G+FJHYAoe7ZduTFomRKe0KT9/9fTtpP1T0zHWb7tf0guTYKfHjcGU6PvB8
         lkkptNaTJLW3vrh8jT7sOg16yffPygeLBxCGy5zF5lZtupVYwnTsMedJUJyRbiTTrqjO
         8uHw==
X-Gm-Message-State: AOJu0Yy8NHKaxtVotLO+kmALef00jX44yrxPg5apYiqJkTXOBSwyT75g
        4wxYt59sHaglgYr4rJNVvY0v0e80rEetbg==
X-Google-Smtp-Source: AGHT+IGFDR7qM91FuKAihnW46CcO3lwaD4Nguop9Cf4hWt6CG8odTLVvqreY5y6DAAfd9bGIe4Iuvw==
X-Received: by 2002:a25:106:0:b0:d81:6e88:7cb2 with SMTP id 6-20020a250106000000b00d816e887cb2mr11548396ybb.46.1696324615226;
        Tue, 03 Oct 2023 02:16:55 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 14-20020a25050e000000b00d5d4bae6fdfsm287732ybf.30.2023.10.03.02.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 02:16:54 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59f1dff5298so8369137b3.3;
        Tue, 03 Oct 2023 02:16:54 -0700 (PDT)
X-Received: by 2002:a0d:d4c1:0:b0:592:5def:5c03 with SMTP id
 w184-20020a0dd4c1000000b005925def5c03mr13812337ywd.22.1696324614714; Tue, 03
 Oct 2023 02:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <66ed5e27cb600f3317d315c4fd60bd3e9eb09c17.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <66ed5e27cb600f3317d315c4fd60bd3e9eb09c17.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Oct 2023 11:16:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWPg7+Qpu1Z_fHDek-isbxjEOzmGHpA=gK05jWvegYH0Q@mail.gmail.com>
Message-ID: <CAMuHMdWPg7+Qpu1Z_fHDek-isbxjEOzmGHpA=gK05jWvegYH0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/30] Documentation/devicetree: Add
 renesas,sh7751-cpg binding document.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Sep 13, 2023 at 11:26 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../bindings/clock/renesas,sh7750-cpg.yaml    | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
> new file mode 100644
> index 000000000000..bf10a09440ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/renesas,cpg-clocks.yaml#

warning: ignoring duplicate '$id' value
'http://devicetree.org/schemas/clock/renesas,cpg-clocks.yaml#'

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
