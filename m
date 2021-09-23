Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C33DC433EF
	for <linux-sh@archiver.kernel.org>; Thu, 23 Sep 2021 15:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437CF60EE4
	for <linux-sh@archiver.kernel.org>; Thu, 23 Sep 2021 15:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbhIWPW2 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:22:28 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:35771 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241906AbhIWPWX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 23 Sep 2021 11:22:23 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1mTQWi-000ce9-EJ; Thu, 23 Sep 2021 17:20:44 +0200
Received: from p57bd97e9.dip0.t-ipconnect.de ([87.189.151.233] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1mTQWi-001KqW-5r; Thu, 23 Sep 2021 17:20:44 +0200
Message-ID: <180a123c-304e-2e74-fed6-9da463e985b6@physik.fu-berlin.de>
Date:   Thu, 23 Sep 2021 17:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] sh: pgtable-3level: Fix cast to pointer from integer of
 different size
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Daniel Palmer <daniel@0x0f.com>, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.151.233
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Geert!

On 9/15/21 15:50, Geert Uytterhoeven wrote:
> If X2TLB=y (CPU_SHX2=y or CPU_SHX3=y, e.g. migor_defconfig), pgd_t.pgd
> is "unsigned long long", causing:
> 
>     In file included from arch/sh/include/asm/pgtable.h:13,
> 		     from include/linux/pgtable.h:6,
> 		     from include/linux/mm.h:33,
> 		     from arch/sh/kernel/asm-offsets.c:14:
>     arch/sh/include/asm/pgtable-3level.h: In function ‘pud_pgtable’:
>     arch/sh/include/asm/pgtable-3level.h:37:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>        37 |  return (pmd_t *)pud_val(pud);
> 	  |         ^
> 
> Fix this by adding an intermediate cast to "unsigned long", which is
> basically what the old code did before.

Thanks a lot for fixing this. My SH kernel build becomes much less noisy with
your patch. I can also confirm that it doesn't break the boot on my SH-7785LCR
as expected.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

