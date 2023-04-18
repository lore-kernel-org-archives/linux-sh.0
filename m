Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4D9C77B75
	for <linux-sh@archiver.kernel.org>; Tue, 18 Apr 2023 08:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDRI5p (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 18 Apr 2023 04:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDRI5o (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 18 Apr 2023 04:57:44 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415A13C30
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 01:57:41 -0700 (PDT)
Received: from [192.168.1.103] (31.173.80.61) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 18 Apr
 2023 11:57:32 +0300
Subject: Re: [PATCH] Fix J-core aic warning spam
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rob Landley <rob@landley.net>
CC:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
 <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <91f17ce6-566f-c5d0-f30c-8f8440f0cca6@omp.ru>
Date:   Tue, 18 Apr 2023 11:56:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.80.61]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 04/18/2023 08:36:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 176786 [Apr 18 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 509 509 b12bcaa7ba85624b485f2b6b92324b70964a1c65
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.61 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;omp.ru:7.1.1;31.173.80.61:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.61
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/18/2023 08:41:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/18/2023 7:17:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 4/18/23 10:18 AM, Geert Uytterhoeven wrote:
[...]
>>> From: Rich Felker <dalias@libc.org>
>>> Signed-off-by: Rob Landley <rob@landley.net>
>>>
>>> Silence noisy boot messages (warning and stack dump for each IRQ) when booting
>>> on J2 SOC.
> 
>>> --- a/drivers/irqchip/irq-jcore-aic.c
>>> +++ b/drivers/irqchip/irq-jcore-aic.c
[...]
>>> @@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
>>>       jcore_aic.irq_unmask = noop;
>>>       jcore_aic.name = "AIC";
>>>
>>> +     rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
>>> +                          of_node_to_nid(node));
>>> +     if (rc < 0)
>>> +             pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
>>> +                     min_irq);
> 
> This is a fatal error, so please bail out, instead of continuing.

   Then shounld't we use pr_err() (or stronger), not pr_info()?

[...]

> Gr{oetje,eeting}s,
> 
>                         Geert

MBR, Sergey
