Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164ABC433EF
	for <linux-sh@archiver.kernel.org>; Sat, 12 Mar 2022 21:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiCLVLp (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 12 Mar 2022 16:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiCLVLo (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 12 Mar 2022 16:11:44 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7667712153C;
        Sat, 12 Mar 2022 13:10:33 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 556CE209A774
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2] sh: avoid using IRQ0 on SH3/4
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>
References: <9382f3ca-b49a-e900-7f21-3f10b267ee4a@omp.ru>
Organization: Open Mobile Platform
Message-ID: <97f539fd-c99a-c82b-9c88-87f863a1a5ca@omp.ru>
Date:   Sun, 13 Mar 2022 00:10:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9382f3ca-b49a-e900-7f21-3f10b267ee4a@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 2/11/22 11:51 PM, Sergey Shtylyov wrote:

> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
> and the code supporting SH3/4 SoCs maps the IRQ #s starting at 0 -- modify
> that code to start the IRQ #s from 16 instead.
> 
> [1] https://lore.kernel.org/all/5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru/
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

   Now, after the patch has been tested, I'd really appreciate if it would appear
in 5.18.

[...]

MBR, Sergey
