Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1749C433F5
	for <linux-sh@archiver.kernel.org>; Sun,  1 May 2022 18:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbiEASM4 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 1 May 2022 14:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEASMy (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 1 May 2022 14:12:54 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778AE4EA38;
        Sun,  1 May 2022 11:09:27 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 7302120EA55E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
CC:     <linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru>
 <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
 <20220429171623.GQ7074@brightrain.aerifal.cx>
 <525e7383-d26a-fe35-7005-e1dd9b57f76f@omp.ru>
Organization: Open Mobile Platform
Message-ID: <86b6c752-0599-d878-bff4-7d3d7b84176a@omp.ru>
Date:   Sun, 1 May 2022 21:09:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <525e7383-d26a-fe35-7005-e1dd9b57f76f@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 5/1/22 8:58 PM, Sergey Shtylyov wrote:
[...]
>>>> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
>>>> and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
>>>> see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
>>>> at 0 -- modify that code to start the IRQ #s from 16 instead.
>>>>
>>>> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
>>>> indeed use IRQ0 for the SMSC911x compatible Ethernet chip...
>>>
>>> Maybe try getting it landed through Andrew Morton's tree?
>>
>> Hi. I'm alive and looking at it. If it needs to go in for this cycle I
>> will send a pull request for just this and anything else critical. Was
> 
>    Well, now using IRQ0 just causes a WARNing in platform_get_irq() -- I don't
> think fixing it is critical enough. Starting from 5.19-rc1 the SMSC91xx driver
> should stop working on the mentioned boards.
>    But let me look at the SMSC driver itself, I haven't done this yet...

   Looks like these boards were borked back in 2015 by this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=965b2aa78fbcb831acf4f669f494da201f4bcace

   It stopped accepting IRQ0 for no apparent reason. :-/

[...]

>> Rich

MBR, Sergey
