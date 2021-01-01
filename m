Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201E7C433E0
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 13:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3EE221F2
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 13:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbhAAN5U (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:57:20 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:48509 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726747AbhAAN5U (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Jan 2021 08:57:20 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kvKuz-001dkJ-B4; Fri, 01 Jan 2021 14:56:36 +0100
Received: from p5b13a2ad.dip0.t-ipconnect.de ([91.19.162.173] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kvKuy-003CFZ-JE; Fri, 01 Jan 2021 14:56:36 +0100
Subject: Re: [PATCH] sh: boards: Fix the cacography in irq.c
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201119105656.11068-1-tangbin@cmss.chinamobile.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <dcf1a0d9-d533-63d7-c3d9-5023fe969117@physik.fu-berlin.de>
Date:   Fri, 1 Jan 2021 14:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201119105656.11068-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.173
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/19/20 11:56 AM, Tang Bin wrote:
> The world 'swtich' is wrong, so fix it.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  arch/sh/boards/mach-landisk/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-landisk/irq.c b/arch/sh/boards/mach-landisk/irq.c
> index 29b8b1f85..0b672b80c 100644
> --- a/arch/sh/boards/mach-landisk/irq.c
> +++ b/arch/sh/boards/mach-landisk/irq.c
> @@ -26,8 +26,8 @@ enum {
>  	PCI_INTD, /* PCI int D */
>  	ATA,	  /* ATA */
>  	FATA,	  /* CF */
> -	POWER,	  /* Power swtich */
> -	BUTTON,	  /* Button swtich */
> +	POWER,	  /* Power switch */
> +	BUTTON,	  /* Button switch */
>  };
>  
>  /* Vectors for LANDISK */
> 

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

