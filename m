Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54941C11F68
	for <linux-sh@archiver.kernel.org>; Fri,  2 Jul 2021 09:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF47611C0
	for <linux-sh@archiver.kernel.org>; Fri,  2 Jul 2021 09:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGBJ16 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 2 Jul 2021 05:27:58 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:37215 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230388AbhGBJ16 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 2 Jul 2021 05:27:58 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lzFQG-002aEM-Gp; Fri, 02 Jul 2021 11:25:20 +0200
Received: from p57bd964c.dip0.t-ipconnect.de ([87.189.150.76] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lzFQG-004BfI-AA; Fri, 02 Jul 2021 11:25:20 +0200
Subject: Re: [PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>,
        Arnd Bergmann <arnd@arndb.de>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <20210627220544.8757-4-rdunlap@infradead.org>
 <6af41806-e715-4084-418f-4a8924d26c07@physik.fu-berlin.de>
 <8efd6e1d-9949-9598-9e6b-41d9b2f4ea7a@infradead.org>
 <d1e925b1-b0ef-2e00-ea79-b5ff2be3cf4c@physik.fu-berlin.de>
 <CAMuHMdUjT3GnZTUurHmjctxaa==VYU9-rNuQun=f=RyWi2M5Tw@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <85485961-4c6e-a1bc-d66a-19869b5a03f1@physik.fu-berlin.de>
Date:   Fri, 2 Jul 2021 11:25:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUjT3GnZTUurHmjctxaa==VYU9-rNuQun=f=RyWi2M5Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.76
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Geert!

On 7/1/21 10:41 AM, Geert Uytterhoeven wrote:
>>> OK. Thanks for all of the testing.
>>
>> I'll report back with the other patch applied that Geert mentioned from linux-next before this one.
> 
> FTR, I booted all three successfully on qemu/rts7751r2d and on physical landisk.

Good to know, thanks.

>> FWIW, there are some warnings when building the SH-7785LCR configuration:
>>
>> In file included from ./arch/sh/include/asm/hw_irq.h:6,
>>                  from ./include/linux/irq.h:591,
>>                  from ./include/asm-generic/hardirq.h:17,
>>                  from ./arch/sh/include/asm/hardirq.h:9,
>>                  from ./include/linux/hardirq.h:11,
>>                  from ./include/linux/interrupt.h:11,
>>                  from ./include/linux/serial_core.h:13,
>>                  from ./include/linux/serial_sci.h:6,
>>                  from arch/sh/kernel/cpu/sh4a/setup-sh7785.c:10:
>> ./include/linux/sh_intc.h:100:63: warning: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Wsizeof-pointer-div]
>>   100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
>>       |                                                               ^
>> ./include/linux/sh_intc.h:107:9: note: in expansion of macro '_INTC_ARRAY'
>>   107 |         _INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs), \
>>       |         ^~~~~~~~~~~
>> ./include/linux/sh_intc.h:124:15: note: in expansion of macro 'INTC_HW_DESC'
>>   124 |         .hw = INTC_HW_DESC(vectors, groups, mask_regs,                  \
>>       |               ^~~~~~~~~~~~
>> arch/sh/kernel/cpu/sh4a/setup-sh7785.c:478:8: note: in expansion of macro 'DECLARE_INTC_DESC'
>>   478 | static DECLARE_INTC_DESC(intc_desc, "sh7785", vectors, groups,
>>       |        ^~~~~~~~~~~~~~~~~
> 
> A while ago, I had a look into fixing them, but it was non-trivial.
> The issue is that the macros are sometimes used with NULL pointer arrays.
> The __same_type() check in
> 
>     #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> 
> is supposed to catch that, but modern compilers seem to evaluate the
> non-taken branch, too, leading to the warning.
> 
> Anyone with a suggestion? (CCing the multi-compiler guru)

Ah, thanks for the explanation.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
