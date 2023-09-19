Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D076CD5BB9
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 13:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjISNMO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 09:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjISNMO (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 09:12:14 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87499F3
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:12:05 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59c0a7d54bdso41598017b3.1
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129124; x=1695733924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD5BlPIqg3mq+fIhDGejNg6yCUv01kgXVwBqNf51uLM=;
        b=e/C/10yk+Vu874OUl0awFzO1Ta9242RMdls4ktaMav5jYek2BiFlTLPUkeGGe/+X+o
         JLkwtsB3RN+fRFyVDNBOURIZXt6fvKHbuzcAepD+O4W+7OBHIubSHpZvECeM2YV10WlZ
         hUzXQlAGDdyk3+Iptce2q962d/o5d2716ARzks9p6U94JH4W7xUdvHUv3ifrmr+PwJqo
         BJf34RFFV4jUGDI720qw2BjvDyEvPb9z1mjm0j+5MkeUisYSJzOHO1cS6MG9lC/+q9V+
         co3iJJf8eUm78UhW7aY+IzGYiGPTvSXOmLzcXOk9thITLRFmT/eMeAxmkelp0kL7+3pQ
         LZaA==
X-Gm-Message-State: AOJu0Ywyw2NSTzXlv0Tlim44vYkVmLiF04vdVF/g2u8egS+FvHyv9zas
        Dc4MJ+ROGYPTp0gKirzaXnDvdGu0QtA99A==
X-Google-Smtp-Source: AGHT+IEw0Bkh+fO1LTlj46XXyJnPsGb9CyHX4CsvPxm0ZSg8sPiPxgQN+iNtNcKmLdpe/fW1Rpk/JQ==
X-Received: by 2002:a81:840f:0:b0:56d:3b91:7e76 with SMTP id u15-20020a81840f000000b0056d3b917e76mr11762746ywf.12.1695129124465;
        Tue, 19 Sep 2023 06:12:04 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id y18-20020a81a112000000b0058451c12076sm3206858ywg.14.2023.09.19.06.12.04
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 06:12:04 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59c0a7d54bdso41597817b3.1
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:12:04 -0700 (PDT)
X-Received: by 2002:a0d:d585:0:b0:59b:5456:a9bb with SMTP id
 x127-20020a0dd585000000b0059b5456a9bbmr13096564ywd.42.1695129124043; Tue, 19
 Sep 2023 06:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <4bf42fc7a928e9a726ea20ee4e2168f993bb34f7.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <4bf42fc7a928e9a726ea20ee4e2168f993bb34f7.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 15:11:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVKvfxJx=QCCqp7DQqsS8Qz9gEAS75Mb-v_L9u_0nQKOg@mail.gmail.com>
Message-ID: <CAMuHMdVKvfxJx=QCCqp7DQqsS8Qz9gEAS75Mb-v_L9u_0nQKOg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 23/30] arch/sh: Add SH7751 SoC Internal periphreal devicetree.
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

> --- /dev/null
> +++ b/arch/sh/boot/dts/sh7751.dtsi
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the SH7751 SoC
> + */
> +
> +#include <dt-bindings/interrupt-controller/sh_intc.h>
> +#include <dt-bindings/clock/sh7750.h>
> +
> +/ {
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               cpu@0 {
> +                     compatible = "renesas,sh7751r","renesas,sh4", "renesas,sh";
> +               };
> +       };
> +
> +       clocks {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               cpg: cpg@ffc00000 {
> +                       #clock-cells = <1>;
> +                       compatible = "renesas,sh7750-cpg";

renesas,sh7751-cpg?

> +                       clocks = <&xtal>;

Please provide an xtal (or extal) fixed-clock placeholder, to be
filled in by the board DTS.
(cfr. extal_clk in arch/arm64/boot/dts/renesas/r8a77951.dtsi)

> +                       reg = <0xffc00000 2>, <0xffc00008 4>;
> +               };
> +
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
