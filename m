Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3A5C433EF
	for <linux-sh@archiver.kernel.org>; Sat, 26 Feb 2022 08:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiBZIHp (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 26 Feb 2022 03:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBZIHo (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 26 Feb 2022 03:07:44 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0990E267CE8;
        Sat, 26 Feb 2022 00:07:11 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1nNs6c-001ujp-9m; Sat, 26 Feb 2022 09:07:06 +0100
Received: from dynamic-089-014-140-217.89.14.pool.telefonica.de ([89.14.140.217] helo=[192.168.1.9])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1nNs6b-000md8-Sp; Sat, 26 Feb 2022 09:07:06 +0100
Message-ID: <c7d6d986-f6b4-3200-f2c5-761ac39b9c87@physik.fu-berlin.de>
Date:   Sat, 26 Feb 2022 09:07:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] sh: avoid using IRQ0 on SH3/4
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>
References: <2f419ed2-66b8-4098-7cd3-0fe698d341c9@omp.ru>
 <63f06bf0-fc7b-3c5c-8af9-5adfd7628354@omp.ru>
 <dde846f0-1324-7fde-ef92-eb72d4200b50@physik.fu-berlin.de>
 <e4c1aec0-e8a0-4577-d12b-8e4efedbf7e6@omp.ru>
 <9671b75b-d0c4-7967-a543-5eebdf942b35@omp.ru>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <9671b75b-d0c4-7967-a543-5eebdf942b35@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.14.140.217
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sergey!

On 2/25/22 20:28, Sergey Shtylyov wrote:
>>> I can test your revised patch next week on my SH7785LCR.
>>
>>    Please do, although testing on the AP-SH4A* bords would be a bit more
>> interesting, as they actually use IRQ0 for the SMSC911x chip...
> 
>    So, were you finally able to test it?

Not yet, sorry. Machine is currently offline due to a power outage and I cannot
turn it back on remotely, I'm not home until tomorrow. I will be able to test
it tomorrow, however.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

