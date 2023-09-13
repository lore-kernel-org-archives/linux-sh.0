Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55F1CA5534
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 10:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbjIMKu0 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbjIMKuL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 06:50:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3882105
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 03:49:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BA9C433C8;
        Wed, 13 Sep 2023 10:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694602185;
        bh=/a5PoTFoOUj+TF5ozpRwq2LjoUGPlXs+MycXK54ubq0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=efmp7bdAUNUKkLEmTHUc6UiddCZ0d5Qh0YPOC0mL+3lLoB6Cx5rRX5sI5OlAYAXXd
         Nuqy1wpIpT6JpA51TXW0drn8vj0gMiqMWajZX91s8eRzGVa4+O/p6avpA59lWrv+Fr
         uPHLZIF+piZUYsW30GBDGfocbTux/OOKFxd7h1sXhPm/Fz32AnNOB4QT16nPaDKZvv
         3SH0iW3pTOlH/ED86YpKA63wUg7mcNPrXvST9pc7YCIhblDSXvxmBtoiNLe9UiHar7
         145cYQPWi8t5r43Icqp2LhGqz4+fvURiuDjxRfyUTCZY9juf9Ar2ExZ3TO8UATi4pj
         u8pyMUJ+l+ugQ==
Message-ID: <83ecc09e-7a8b-0781-80e1-875977e027b8@kernel.org>
Date:   Wed, 13 Sep 2023 12:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 26/30] arch/sh: RTS7751R2D Plus DeviceTree.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <d63793503fbbc7d5ca7b40d6b31678d371b69c29.1694596125.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <d63793503fbbc7d5ca7b40d6b31678d371b69c29.1694596125.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 13/09/2023 11:23, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>


No improvements in commit msg. No improvements in subject.

> ---
>  arch/sh/boot/dts/rts7751r2dplus.dts | 124 ++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 arch/sh/boot/dts/rts7751r2dplus.dts
> 
> diff --git a/arch/sh/boot/dts/rts7751r2dplus.dts b/arch/sh/boot/dts/rts7751r2dplus.dts
> new file mode 100644
> index 000000000000..a08061133841
> --- /dev/null
> +++ b/arch/sh/boot/dts/rts7751r2dplus.dts
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the Renesas RTS7751R2D Plus
> + */
> +
> +/dts-v1/;
> +
> +#include "sh7751.dtsi"
> +
> +/ {
> +	model = "Renesas RTS7715R2D Plus";
> +	compatible = "renesas,r2dplus";

Missing bindings documentation. Incomplete compatible - missing SoC.

Sorry, but this is nowhere ready for review. There are so many trivial
issues to fix.


Best regards,
Krzysztof

