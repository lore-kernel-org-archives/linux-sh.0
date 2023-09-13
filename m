Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770DACA5537
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 10:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjIMKpF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 06:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjIMKpF (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 06:45:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5515A19AC
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 03:45:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C60C433C8;
        Wed, 13 Sep 2023 10:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694601901;
        bh=n2vVMmySkr4wwZ8qUR7xE57fkDuSDiNTkwrJmuEWbGY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=niATTSTDnkXZDsd2iuR4bPTOsMQsCpWd6HvRFTdA4wEYI+PQsbTHLMOWKHjHyGrH+
         KdWa68+HJ8BH04e/aE5a94XZAI0ayDBjQj/o9r6WXX/uCPIro/H3V6z6+5AmRKAAkB
         96RUJW4LBKKLJg9M2MBE1/+KoGpTNYxaNpQQ7yoFVnW5mtfcT+UtNHbYgzp94G/dgZ
         rMYPP0XB1EsFZ36a1cV4N5pSh10NxJLdpi3WI8lOFNblaToM9CFFvzcXv+ugj9gPWk
         EydGBWs9+57PQ1+cIYXtrzi8N5b6UanC3V1nmVxKpVZwTid77HFSuQCoDelR8N//Pz
         9mCa7TiiAtyIw==
Message-ID: <ffb49123-48f1-a0f2-24fd-d0077782290e@kernel.org>
Date:   Wed, 13 Sep 2023 12:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 15/30] Documentation/devicetree: Add
 renesas,sh7751-intc binding document.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <144ec782c78a55e5c4f41de421b2f3eb8432554c.1694596125.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <144ec782c78a55e5c4f41de421b2f3eb8432554c.1694596125.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 13/09/2023 11:23, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../renesas,sh7751-intc.yaml                  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
> new file mode 100644
> index 000000000000..0f0139545d77
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
> +
> +  sh7751,irlm:

This was absolutely never tested. That's not a valid vendor prefix.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

