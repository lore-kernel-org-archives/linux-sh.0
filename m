Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DCDC47082
	for <linux-sh@archiver.kernel.org>; Thu,  3 Jun 2021 23:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C27613F8
	for <linux-sh@archiver.kernel.org>; Thu,  3 Jun 2021 23:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFCXVf (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 3 Jun 2021 19:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCXVf (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 3 Jun 2021 19:21:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB5C06174A;
        Thu,  3 Jun 2021 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=EXOT9La8+XXIxW3bXOSmdGcimnnQ90QAJmf1D9koF+g=; b=j8pOIRuKWI6jM6Gukk/aAkc+iz
        TabD2ULmBAGbEpx+PAaBNS9jOqflUWzli+HkkwpsT7clsvGl1WK0+cEhbcJIC2aTQAAudt/ozzsoQ
        qFUkmi2g5bBULlRiAxsU6w8svI1+cMVKAaYAsOtM/xCSFZY4vs+Zq5Oz6VD5Cs8AnmqGRRFx59SjT
        7xam4n28lhGiYCcGPQp3Fpfxk+qkywbBTk3dyT8DqGIOKzMUdEDBnkfXycM3C26tHri0h6tn50U7V
        A86nihcbL90QwGXNiVOE2N3FSO0KRVLvNV5eKosRzlBTe1or58prSWZ4pMHTT6F3CH6ZW/QV/BkXr
        L13kTLEQ==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lowcs-00Atf5-PU; Thu, 03 Jun 2021 23:19:46 +0000
Subject: Re: [RFC PATCH 3/4] sh: define __BIG_ENDIAN for math-emu
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20210602231443.4670-1-rdunlap@infradead.org>
 <20210602231443.4670-3-rdunlap@infradead.org>
 <CAMuHMdX1aCJPASd0vvuo+=sjnS8dv24eB_xY8Fn0L2TkJ8NWiQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cde0b1fc-eec3-2267-3872-1099840f5670@infradead.org>
Date:   Thu, 3 Jun 2021 16:19:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX1aCJPASd0vvuo+=sjnS8dv24eB_xY8Fn0L2TkJ8NWiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 6/3/21 12:54 AM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Thu, Jun 3, 2021 at 1:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> The headers in include/math-emu/ test for __BYTE_ORDER == __BIG_ENDIAN
>> without checking to see if these macros are defined, so add
>> a define for __BIG_ENDIAN before pulling in these headers.
>>
>> This placates these build warnings:
>>
>> In file included from ../arch/sh/math-emu/math.c:23:
>> ../include/math-emu/single.h:50:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
>>    50 | #if __BYTE_ORDER == __BIG_ENDIAN
>> In file included from ../arch/sh/math-emu/math.c:24:
>> ../include/math-emu/double.h:59:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
>>    59 | #if __BYTE_ORDER == __BIG_ENDIAN
>>
>> Fixes: 4b565680d163 ("sh: math-emu support")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks for your patch!
> 
>> --- linux-next-20210528.orig/arch/sh/math-emu/sfp-util.h
>> +++ linux-next-20210528/arch/sh/math-emu/sfp-util.h
>> @@ -70,4 +70,4 @@
>>
>>  #define __BYTE_ORDER __LITTLE_ENDIAN
>>
>> -
>> +#define __BIG_ENDIAN 0
> 
> I don't think this is the right fix.
> 
> I think the right values should be picked up from:
> 
>     include/uapi/linux/byteorder/big_endian.h:#define __BIG_ENDIAN 4321
>     include/uapi/linux/byteorder/little_endian.h:#define __LITTLE_ENDIAN 1234
> 
> How is this picked up on other architectures using <math-emu/single.h>?

Hi Geert,

There isn't very much to compare to in other arch/.
I've made a v2 patch that is done like arch/nds32/ does.
What do you think about this one?

thanks.
---
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC PATCH 2/3 v2] sh: define __BIG_ENDIAN for math-emu

Fix this by defining both ENDIAN macros in
<asm/sfp-machine.h> so that they can be utilized in
<math-emu/soft-fp.h> according to the latter's comment:
/* Allow sfp-machine to have its own byte order definitions. */

(This is what is done in arch/nds32/include/asm/sfp-machine.h.)

This placates these build warnings:

In file included from ../arch/sh/math-emu/math.c:23:
../include/math-emu/single.h:50:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
   50 | #if __BYTE_ORDER == __BIG_ENDIAN
In file included from ../arch/sh/math-emu/math.c:24:
../include/math-emu/double.h:59:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
   59 | #if __BYTE_ORDER == __BIG_ENDIAN

Fixes: 4b565680d163 ("sh: math-emu support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sh/include/asm/sfp-machine.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-next-20210528.orig/arch/sh/include/asm/sfp-machine.h
+++ linux-next-20210528/arch/sh/include/asm/sfp-machine.h
@@ -13,6 +13,14 @@
 #ifndef _SFP_MACHINE_H
 #define _SFP_MACHINE_H
 
+#ifdef __BIG_ENDIAN__
+#define __BYTE_ORDER __BIG_ENDIAN
+#define __LITTLE_ENDIAN 0
+#else
+#define __BYTE_ORDER __LITTLE_ENDIAN
+#define __BIG_ENDIAN 0
+#endif
+
 #define _FP_W_TYPE_SIZE		32
 #define _FP_W_TYPE		unsigned long
 #define _FP_WS_TYPE		signed long


