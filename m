Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A48DC433E0
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 20:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5762F22C9D
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 20:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437773AbhARUAm (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:00:42 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:41217 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437786AbhARUAe (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Jan 2021 15:00:34 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l1agk-001qlf-Vo; Mon, 18 Jan 2021 20:59:46 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l1agk-001doN-9y; Mon, 18 Jan 2021 20:59:46 +0100
Subject: Re: [PATCH] sh: kdump: add some attribute to function
To:     Yejune Deng <yejune.deng@gmail.com>, ysato@users.sourceforge.jp,
        dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1607582998-13098-1-git-send-email-yejune.deng@gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <2a4c3426-8afb-f56f-b31a-44a4505f5030@physik.fu-berlin.de>
Date:   Mon, 18 Jan 2021 20:59:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1607582998-13098-1-git-send-email-yejune.deng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 12/10/20 7:49 AM, Yejune Deng wrote:
> add '__iomem' for ioremap() and '__user' for copy_to_user().
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  arch/sh/kernel/crash_dump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
> index a908612..5b41b59 100644
> --- a/arch/sh/kernel/crash_dump.c
> +++ b/arch/sh/kernel/crash_dump.c
> @@ -26,7 +26,7 @@
>  ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>                                 size_t csize, unsigned long offset, int userbuf)
>  {
> -	void  *vaddr;
> +	void  __iomem *vaddr;
>  
>  	if (!csize)
>  		return 0;
> @@ -34,7 +34,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>  	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
>  
>  	if (userbuf) {
> -		if (copy_to_user(buf, (vaddr + offset), csize)) {
> +		if (copy_to_user((void __user *)buf, (vaddr + offset), csize)) {
>  			iounmap(vaddr);
>  			return -EFAULT;
>  		}

Successfully boot-tested on my SH-7785LCR. No regressions.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

