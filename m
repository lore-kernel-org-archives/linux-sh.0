Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B867C433F5
	for <linux-sh@archiver.kernel.org>; Sun,  3 Oct 2021 09:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABE661B24
	for <linux-sh@archiver.kernel.org>; Sun,  3 Oct 2021 09:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhJCJVK (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 3 Oct 2021 05:21:10 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:57494 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJCJVK (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 3 Oct 2021 05:21:10 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Oct 2021 05:21:09 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 4FDC920EBC9F
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] Fix the j-core SOC build.
To:     Rob Landley <rob@landley.net>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rich Felker <dalias@libc.org>
References: <7d559bd1-1f9c-124f-ad4d-c805c049971a@landley.net>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a25fd381-8f21-29eb-3620-2082e09cab5f@omp.ru>
Date:   Sun, 3 Oct 2021 12:10:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7d559bd1-1f9c-124f-ad4d-c805c049971a@landley.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 02.10.2021 22:32, Rob Landley wrote:

> From: Rob Landley <rob@landley.net>
> 
> Commit b67177ecd956

    You missed the commit summary enclosed on ("").

> broke the j-core SOC build with a link failure, because
> mm/percpu.c function pcpu_post_unmap_tlb_flush() calls flush_tlb_kernel_range()
> which is defined under #ifdef CONFIG_MMU.
> 
> Signed-off-by: Rob Landley <rob@landley.net>
[...]

MBR, Sergey
