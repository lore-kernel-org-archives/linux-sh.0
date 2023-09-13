Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58335CA5537
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 10:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbjIMKtp (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbjIMKtk (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 06:49:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6CE19BD
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 03:49:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6500C433CC;
        Wed, 13 Sep 2023 10:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694602162;
        bh=3Zko0cpkv7MbAkvNCGp50c+XYTavZfRoXqbPoHTW14A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QNfJ5ze4ggox3Fj5J0rSl6gUFGvRW01r3aC0SBF05X1/Eqt52OcgPNZODWb6KXogI
         CYPE62ihbBKwwz150wWfvq+jSyWpkysYl8NXFkRKxAuGWv9LIjE5oKiMR0DE/0Dtam
         zUVolhDm1tfawdKCxdT33eIDEysWHjZlPMLxdVO3OxQsFVGkcP3w5w5lpZKPIIYc4n
         54ZkyfsE6kHMvF+kPJjAATT4i2co9H9c2GZRi+Z96xn2HlxWjSZokLhVPfWKVqdoEE
         lBTEN+r3oonCqkICKkvQCo4CwGAM6RiMgOuX3fZmYWxb/x5M8LpsYoRE00sQrQZiKE
         Z2fx5XZRiTb8A==
Message-ID: <dac176a0-3251-c5b3-4ae3-835bb266a8c1@kernel.org>
Date:   Wed, 13 Sep 2023 12:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 23/30] arch/sh: Add SH7751 SoC Internal periphreal
 devicetree.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <4bf42fc7a928e9a726ea20ee4e2168f993bb34f7.1694596125.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <4bf42fc7a928e9a726ea20ee4e2168f993bb34f7.1694596125.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 13/09/2023 11:23, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/boot/dts/sh7751.dtsi | 76 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 arch/sh/boot/dts/sh7751.dtsi
> 
> diff --git a/arch/sh/boot/dts/sh7751.dtsi b/arch/sh/boot/dts/sh7751.dtsi
> new file mode 100644
> index 000000000000..749eab3bce9f
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
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		cpu@0 {
> +		      compatible = "renesas,sh7751r","renesas,sh4", "renesas,sh";

Except missing spaces and incorrect indentation, where is this
documented? Anyway it looks really odd to use such compatibles for CPUs.


Best regards,
Krzysztof

