Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99621EB64D9
	for <linux-sh@archiver.kernel.org>; Wed, 12 Jul 2023 05:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGLFP2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 12 Jul 2023 01:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGLFP1 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 12 Jul 2023 01:15:27 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F1710E3;
        Tue, 11 Jul 2023 22:15:26 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qJSC6-002AA8-7T; Wed, 12 Jul 2023 07:15:18 +0200
Received: from p57bd9f0d.dip0.t-ipconnect.de ([87.189.159.13] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qJSC6-0016Z1-09; Wed, 12 Jul 2023 07:15:18 +0200
Message-ID: <31e4e3d0e6d1c6f044dd9461b81eb7f410ccabfe.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] [RFC] sh: highlander: Handle virq offset in cascaded
 IRL demux
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 12 Jul 2023 07:15:16 +0200
In-Reply-To: <4fcb0d08a2b372431c41e04312742dc9e41e1be4.1688908186.git.geert+renesas@glider.be>
References: <4fcb0d08a2b372431c41e04312742dc9e41e1be4.1688908186.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.159.13
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sun, 2023-07-09 at 15:10 +0200, Geert Uytterhoeven wrote:
> Take into account the virq offset when translating cascaded IRL
> interrupts.
> 
> Fixes: a8ac2961148e8c72 ("sh: Avoid using IRQ0 on SH3 and SH4")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only, but the fix is identical to the fix for rts7751r2d.
> ---
>  arch/sh/boards/mach-highlander/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-highlander/setup.c b/arch/sh/boards/mach-highlander/setup.c
> index 533393d779c2b97f..a821a1b155473d93 100644
> --- a/arch/sh/boards/mach-highlander/setup.c
> +++ b/arch/sh/boards/mach-highlander/setup.c
> @@ -389,10 +389,10 @@ static unsigned char irl2irq[HL_NR_IRL];
>  
>  static int highlander_irq_demux(int irq)
>  {
> -	if (irq >= HL_NR_IRL || irq < 0 || !irl2irq[irq])
> +	if (irq >= 16 + HL_NR_IRL || irq < 16 || !irl2irq[irq - 16])
>  		return irq;
>  
> -	return irl2irq[irq];
> +	return irl2irq[irq - 16];
>  }
>  
>  static void __init highlander_init_irq(void)

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
