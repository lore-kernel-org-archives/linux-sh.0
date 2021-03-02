Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9DBC43331
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5747764E6B
	for <linux-sh@archiver.kernel.org>; Wed,  3 Mar 2021 03:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352253AbhCCDaT (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:30:19 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:41091 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239761AbhCBQaR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 2 Mar 2021 11:30:17 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lH7lK-000VQu-Eu; Tue, 02 Mar 2021 17:20:42 +0100
Received: from dynamic-089-012-163-039.89.12.pool.telefonica.de ([89.12.163.39] helo=[192.168.1.10])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lH7lK-000s1Z-7M; Tue, 02 Mar 2021 17:20:42 +0100
Subject: Re: [PATCH] sh: Use generic GGC library routines
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210302161439.3799589-1-geert+renesas@glider.be>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <78fb8ea2-92f9-12a3-4f96-6ed2290a57d5@physik.fu-berlin.de>
Date:   Tue, 2 Mar 2021 17:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302161439.3799589-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.12.163.39
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Geert!

On 3/2/21 5:14 PM, Geert Uytterhoeven wrote:
> The C implementations of __ashldi3(), __ashrdi3__(), and __lshrdi3() in
> arch/sh/lib/ are identical to the generic C implementations in lib/.
> Reduce duplication by switching SH to the generic versions.
> 
> Update the include path in arch/sh/boot/compressed accordingly.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

There is a funny typo in the subject you probably want to fix :-).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

