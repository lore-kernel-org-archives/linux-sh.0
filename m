Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2FEC433F5
	for <linux-sh@archiver.kernel.org>; Mon,  8 Nov 2021 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC6C61361
	for <linux-sh@archiver.kernel.org>; Mon,  8 Nov 2021 14:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbhKHOvL (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 8 Nov 2021 09:51:11 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:37842 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbhKHOvK (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 8 Nov 2021 09:51:10 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 9841620E927D
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <ea08bd47-63cc-459f-4703-fc60c728bd02@omp.ru>
Date:   Mon, 8 Nov 2021 17:48:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v0 35/42] sh: Check notifier registration return value
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
CC:     <linux-sh@vger.kernel.org>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-36-bp@alien8.de>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211108101157.15189-36-bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 08.11.2021 13:11, Borislav Petkov wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Avoid homegrown notifier registration checks.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: linux-sh@vger.kernel.org
> ---
>   arch/sh/kernel/cpu/sh4a/setup-sh7724.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> index 0d990ab1ba2a..8dfbb8149f66 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> @@ -1277,11 +1277,14 @@ static struct notifier_block sh7724_post_sleep_notifier = {
>   
>   static int __init sh7724_sleep_setup(void)
>   {
> -	atomic_notifier_chain_register(&sh_mobile_pre_sleep_notifier_list,
> -				       &sh7724_pre_sleep_notifier);
> +	if (atomic_notifier_chain_register(&sh_mobile_pre_sleep_notifier_list,
> +					   &sh7724_pre_sleep_notifier))
> +		pr_warn("SH7724 pre-sleep notifier already registered\n");
> +
> +	if (atomic_notifier_chain_register(&sh_mobile_post_sleep_notifier_list,
> +					   &sh7724_post_sleep_notifier))
> +		pr_warn("SH7724 pre-sleep notifier already registered\n");

   s/pre/post/? :-)

>   
> -	atomic_notifier_chain_register(&sh_mobile_post_sleep_notifier_list,
> -				       &sh7724_post_sleep_notifier);
>   	return 0;
>   }
>   arch_initcall(sh7724_sleep_setup);

MBR, Sergey
