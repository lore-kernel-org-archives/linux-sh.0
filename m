Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7023C636D4
	for <linux-sh@archiver.kernel.org>; Thu,  2 Feb 2023 16:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjBBQ2S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBBQ2R (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 2 Feb 2023 11:28:17 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3882CFDC;
        Thu,  2 Feb 2023 08:28:16 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pNcRV-000A0K-Ta; Thu, 02 Feb 2023 17:28:09 +0100
Received: from p57bd9464.dip0.t-ipconnect.de ([87.189.148.100] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pNcRV-0008xK-MR; Thu, 02 Feb 2023 17:28:09 +0100
Message-ID: <0565e1b146995f9f8339bb81ac23218dba371133.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: clk: Fix clk_enable() to return 0 on NULL clk
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-sh@vger.kernel.org, linux-clk@vger.kernel.org
Date:   Thu, 02 Feb 2023 17:28:09 +0100
In-Reply-To: <b53e6b557b4240579933b3359dda335ff94ed5af.1675354849.git.geert+renesas@glider.be>
References: <b53e6b557b4240579933b3359dda335ff94ed5af.1675354849.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.100
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Geert!

On Thu, 2023-02-02 at 17:20 +0100, Geert Uytterhoeven wrote:
> On SH, devm_clk_get_optional_enabled() fails with -EINVAL if the clock
> is not found.  This happens because __devm_clk_get() assumes it can pass
> a NULL clock pointer (as returned by clk_get_optional()) to the init()
> function (clk_prepare_enable() in this case), while the SH
> implementation of clk_enable() considers that an error.
> 
> Fix this by making the SH clk_enable() implementation return zero
> instead, like the Common Clock Framework does.
> 
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Exposed by commit 599566c1c3692052 ("r8169: use
> devm_clk_get_optional_enabled() to simplify the code"), cfr.
> https://lore.kernel.org/all/585c4b48790d71ca43b66fc24ea8d84917c4a0e1.camel@physik.fu-berlin.de
> 
> Boot-tested on qemu/rts7751r2d, which did not show the problem though.
> ---
>  drivers/sh/clk/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
> index d996782a710642cd..7a73f5e4a1fc70cc 100644
> --- a/drivers/sh/clk/core.c
> +++ b/drivers/sh/clk/core.c
> @@ -295,7 +295,7 @@ int clk_enable(struct clk *clk)
>  	int ret;
>  
>  	if (!clk)
> -		return -EINVAL;
> +		return 0;
>  
>  	spin_lock_irqsave(&clock_lock, flags);
>  	ret = __clk_enable(clk);

I can confirm that this patch makes the r8169 driver work again!

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
