Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A246ECD54BE
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 11:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjISL4g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 07:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjISL4f (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 07:56:35 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71549F4
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 04:56:30 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59bbdb435bfso55153467b3.3
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 04:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695124589; x=1695729389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nge3eSViv1JPE6yUgx9DKrYnxuuRpqAeDCsPOcPjF3o=;
        b=D8XVIuIXgE550CZgq+Nh/JwlbYeqq/jy2DJ2g/tcyQNtKheXDlH0MTdPJrHlvn51na
         +HZ5Ux9Upeb/HVR8f0ANxp7Gfy/v5Ppf/QdSZH/6Fk1v7nB2SCXnGvuttJZHnY3wfxbd
         5202xUHMlUx+8KtLEhiHsIyEuLvQvzr4jSINGnjmhlh1OzaNzhKafEcWwW7HTvQl6XiK
         Dbd747taEjClavBf5taOhGhefPNZRzJJlf7svrKp+n/29qIY9576coBh7DFmimzI6tQ0
         zlgdM1nT6rCpDN9bdNHdkmzn7+IQye2T2OjTpCZxvjF6dCa5bs9VzK8Qnko0dNHIO8nT
         dKTg==
X-Gm-Message-State: AOJu0YyWqPePcPrJyDbIPkoHRqFJR4TU4eq+D7ajJpXEMyxfA3kk7W+A
        YXyy8R7MasAkdzzOLoRgeBEEOvM8cHEgUw==
X-Google-Smtp-Source: AGHT+IGqBNHPTRtRs+fGslq/b5Or5DFTuV46e+3FtfgCY6MZM52JM8qN+F0WPn4eCrop0BbW1eNeBQ==
X-Received: by 2002:a0d:d541:0:b0:59b:c4a5:f2ba with SMTP id x62-20020a0dd541000000b0059bc4a5f2bamr12689003ywd.9.1695124589384;
        Tue, 19 Sep 2023 04:56:29 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id l6-20020a819406000000b0057085b18cddsm3166127ywg.54.2023.09.19.04.56.29
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 04:56:29 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d7b91422da8so5277281276.2
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 04:56:29 -0700 (PDT)
X-Received: by 2002:a25:7457:0:b0:d81:4168:3a83 with SMTP id
 p84-20020a257457000000b00d8141683a83mr10939395ybc.25.1695124588825; Tue, 19
 Sep 2023 04:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <144ec782c78a55e5c4f41de421b2f3eb8432554c.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <144ec782c78a55e5c4f41de421b2f3eb8432554c.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 13:56:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUC-tOWS5+YONVW7egiwSgsTvxz09_Shrfz_Y6Ztdu9zQ@mail.gmail.com>
Message-ID: <CAMuHMdUC-tOWS5+YONVW7egiwSgsTvxz09_Shrfz_Y6Ztdu9zQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/30] Documentation/devicetree: Add
 renesas,sh7751-intc binding document.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:26 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH7751 Interrupt Controller
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,sh7751-intc
> +
> +  '#interrupt-cells':
> +    # an interrupt index and flags, as defined in interrupts.txt in
> +    # this directory
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2

Please explain the meaning of each register bank, using
"description".

Perhaps reg-names, as there are two register banks?

> +
> +  sh7751,irlm:

The vendor prefix should be "renesas".

> +    description: If this value true. ICR.IRLM is 1.

This does not explain why you need this.
Is this hardware description, or software configuration?

> +    $ref: /schemas/types.yaml#/definitions/bool

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
