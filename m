Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A922C433E0
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C116206DB
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 19:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393788AbhARTBC (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Jan 2021 14:01:02 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:41229 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407946AbhARTAu (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Jan 2021 14:00:50 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l1Zl2-001a8Z-7F; Mon, 18 Jan 2021 20:00:07 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l1Zl1-001X3a-Jb; Mon, 18 Jan 2021 20:00:07 +0100
Subject: Re: [PATCH] sh: check return code of request_irq
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201212161831.GA28098@roeck-us.net>
 <20201222205402.2269377-1-ndesaulniers@google.com>
 <fe77cdc9-7ef1-a300-259b-65b451b2551a@physik.fu-berlin.de>
 <CANiq72nXe_BAyxb+VVf0CSCm749FLsQ5c6wCQQNc97ef_Z8YwA@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <49b26402-9368-ce39-62dc-8404e3ea937c@physik.fu-berlin.de>
Date:   Mon, 18 Jan 2021 20:00:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CANiq72nXe_BAyxb+VVf0CSCm749FLsQ5c6wCQQNc97ef_Z8YwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Miguel!

On 1/1/21 9:42 PM, Miguel Ojeda wrote:
> On Fri, Jan 1, 2021 at 2:50 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>>
>> Verified on my SH-7785LCR board. Boots fine.
>>
>> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> Thanks for testing, John!
> 
> I think Masahiro was concerned about the error case (I assume you
> tested the happy path).

Not sure about testing the error case though. How do I make request_irq()
fail?

> In any case, if no maintainer suggests something else, looks good to
> me (and it is no worse than the status quo unless the `pr_err()` can
> somehow kill it), so:
> 
>     Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

I agree.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

