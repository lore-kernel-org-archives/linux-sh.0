Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292C9C433EF
	for <linux-sh@archiver.kernel.org>; Fri,  8 Oct 2021 19:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 049F061027
	for <linux-sh@archiver.kernel.org>; Fri,  8 Oct 2021 19:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhJHTs4 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhJHTs4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 8 Oct 2021 15:48:56 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8217C061570;
        Fri,  8 Oct 2021 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=IRGD4RfBn7KLUyaNIF8H0Vn2lDfysR2nr3bQYIRmdjo=; b=1e0XizjF86RqMSFmwaq5bfgKr9
        +9OdCsQVlszLbhF52EQgo3ZV8NGK3yPCkk9F6qM0yvtSeUmlOCvqdZLON0zWpoSO7T8z3un1B8CW5
        sgV5rGRB8lIRkQ504nD41TUCIRbz41IRkSlNPNiKmm1Ieqy4qZMuuG/rmQKvdZ/qvB7zuzZTNi0rt
        mJfxRenm2/dtfwst2yvHT8+bdhMjwQoWGzleP35PkILcKAjTaCFKdL6NvYAmImTEXn5Gy7AX9EiQP
        BIQXyKZkYeri8XCGMTl/GOlh+vhVLVXA1N77XbA8lNuGPhCXltYwB9k6Gl+ZwJcmP/W1+oY55QTRG
        ZqECr1QQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYvpV-0040Q3-Ml; Fri, 08 Oct 2021 19:46:53 +0000
Subject: Re: [PATCH 5/5 v3] sh: fix READ/WRITE redefinition warnings
To:     Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>
References: <20211005001914.28574-1-rdunlap@infradead.org>
 <20211005001914.28574-6-rdunlap@infradead.org>
 <1191978c-be37-87b1-bbc9-f0aa128d0961@landley.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <754abc70-d539-296a-8993-3a66656e44b1@infradead.org>
Date:   Fri, 8 Oct 2021 12:46:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1191978c-be37-87b1-bbc9-f0aa128d0961@landley.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 10/8/21 11:39 AM, Rob Landley wrote:
> On 10/4/21 7:19 PM, Randy Dunlap wrote:
>> kernel.h defines READ and WRITE, so rename the SH math-emu macros
>> to MREAD and MWRITE.
> 
> This one doesn't apply for me. My file has:
> 
> #define WRITE(d,a)      ({if(put_user(d, (typeof (d)*)a)) return -EFAULT;})
> 
> But your patch tries to remove:
> 
> -#define WRITE(d,a)     ({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> 
> Which is odd because git log says my tree is current as of today, but git log on
> this file says it was last updated:
> 
> commit 2e1661d2673667d886cd40ad9f414cb6db48d8da
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Thu May 23 11:04:24 2019 -0500
> 
> What did I miss?

Hi Rob,

I am making patches to linux-next, which contains this:

commit ca42bc4b7bda
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Dec 31 23:23:01 2020 +0000

     sh: fix trivial misannotations

which adds the __user annotations...


-- 
~Randy
