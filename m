Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A52C433DB
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 17:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFC722C9C
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 17:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406880AbhARRKU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Jan 2021 12:10:20 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:34185 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405850AbhARRKQ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Jan 2021 12:10:16 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l1Y20-0011Om-6P; Mon, 18 Jan 2021 18:09:31 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l1Y1z-001IsJ-Hg; Mon, 18 Jan 2021 18:09:31 +0100
Subject: Re: [PATCH 2/2] sh: boot: avoid unneeded rebuilds under
 arch/sh/boot/compressed/
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210117111632.2392635-1-masahiroy@kernel.org>
 <20210117111632.2392635-2-masahiroy@kernel.org>
 <acc34727-c956-3943-c623-1acd462c2a2d@physik.fu-berlin.de>
 <CAK7LNAQL3RUtnw99smJCRc_rOm3PgMZhjc85WT3WwNGCcgK6nw@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <2d51d847-816a-d645-2296-79728656a196@physik.fu-berlin.de>
Date:   Mon, 18 Jan 2021 18:09:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQL3RUtnw99smJCRc_rOm3PgMZhjc85WT3WwNGCcgK6nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Masahiro!

On 1/17/21 5:21 PM, Masahiro Yamada wrote:
>> This patch doesn't apply for me while the first one applies without problems:
>>
>> glaubitz@epyc:..glaubitz/linux-git> git am ../sh-patches-2021/\[PATCH\ 1_2\]\ sh\:\ boot\:\ add\ intermediate\ vmlinux.bin\*\ to\ targets\ instead\ of\ extra-y.eml
>> Applying: sh: boot: add intermediate vmlinux.bin* to targets instead of extra-y
>> glaubitz@epyc:..glaubitz/linux-git> git am ../sh-patches-2021/\[PATCH\ 2_2\]\ sh\:\ boot\:\ avoid\ unneeded\ rebuilds\ under\ arch_sh_boot_compressed_.eml
>> Applying: sh: boot: avoid unneeded rebuilds under arch/sh/boot/compressed/
>> error: arch/sh/boot/compressed/ashiftrt.S: already exists in working directory
>> error: arch/sh/boot/compressed/ashldi3.c: already exists in working directory
>> error: arch/sh/boot/compressed/ashlsi3.S: already exists in working directory
>> error: arch/sh/boot/compressed/ashrsi3.S: already exists in working directory
>> error: arch/sh/boot/compressed/lshrsi3.S: already exists in working directory
> 
> Adrian, these 5 files are currently generated files.
> 
> That is why git-am failed.

I already guessed that. I removed them now and the patch applies cleanly.

Will test-boot on my SH-7785LCR in a minute.

> They are not cleaned up by 'make ARCH=sh clean'
> (this is a bug too).

That should be easy to fix I guess :-).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

