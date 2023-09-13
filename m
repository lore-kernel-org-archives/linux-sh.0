Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A6CA5534
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 10:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbjIMKrg (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjIMKrf (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 06:47:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B9919AC
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 03:47:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374CDC433C9;
        Wed, 13 Sep 2023 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694602051;
        bh=sYs1Z+iCXnDG/bBEifMFfPLyP7FvKlU7+3MEJcBQFmo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tSkCVkYwbbzirx8wlWO7Kotev0qhsNMym+fC8PbLX6g0b+aeykgwTRNnKe0/JB4v9
         pyY/DTOfh+7CzhNkShiE5dObiniyZhCuh8KurWpsSj0yt+8xmIje91TcpWYgVrEG0C
         RaiXvAOVGzSeY2gWAGJfLIf4+K+P/z6quzN0bNULfFZuu+oiSC5Hv+qyP0LRK04BJS
         2LSugx1yNk+1TTdfdq52X1NST4lTY8iinG8WPrPmQ8IYQO+IwNKiBQ0p8r8aLHnT+B
         lNkZqgqLUel1likFsjIKvsOdpLy0XcnLfFdMwBNeMyrf1vXeQcay8ZIQLPRCJmOo5K
         +ys9NJKbiDjKA==
Message-ID: <cabf9417-e264-fb23-ddd4-24f51f7e72a2@kernel.org>
Date:   Wed, 13 Sep 2023 12:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 25/30] include/dt-bindings: Add sh_intc IRQ - EVT
 conversion helper
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <e4dc419e3cc4f44d323aa3686333dafe83b68bce.1694596125.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <e4dc419e3cc4f44d323aa3686333dafe83b68bce.1694596125.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 13/09/2023 11:23, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
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
> \ No newline at end of file

Nothing improved here.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> diff --git a/include/dt-bindings/interrupt-controller/sh_intc.h b/include/dt-bindings/interrupt-controller/sh_intc.h
> new file mode 100644
> index 000000000000..cab546fba396
> --- /dev/null
> +++ b/include/dt-bindings/interrupt-controller/sh_intc.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> + *
> + * SH3/4 INTC EVT - IRQ conversion
> + */
> +
> +#define evt2irq(evt)		((evt) >> 5)
> +#define irq2evt(irq)		((irq) << 5)

No, that's not a binding. Drop entire file.

Best regards,
Krzysztof

