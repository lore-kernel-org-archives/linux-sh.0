Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F61C433F5
	for <linux-sh@archiver.kernel.org>; Sat,  2 Oct 2021 21:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDB361A56
	for <linux-sh@archiver.kernel.org>; Sat,  2 Oct 2021 21:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhJBVlB (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 2 Oct 2021 17:41:01 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51381 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhJBVlB (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 2 Oct 2021 17:41:01 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1mWmiu-002jEs-Gi; Sat, 02 Oct 2021 23:39:12 +0200
Received: from p57bd97e9.dip0.t-ipconnect.de ([87.189.151.233] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1mWmis-000L4N-TP; Sat, 02 Oct 2021 23:39:12 +0200
Message-ID: <c9258ee8-1613-a1c2-759a-30334e969cab@physik.fu-berlin.de>
Date:   Sat, 2 Oct 2021 23:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] Fix the j-core SOC build.
Content-Language: en-US
To:     Rob Landley <rob@landley.net>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rich Felker <dalias@libc.org>
References: <7d559bd1-1f9c-124f-ad4d-c805c049971a@landley.net>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <7d559bd1-1f9c-124f-ad4d-c805c049971a@landley.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.151.233
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Rob!

On 10/2/21 21:32, Rob Landley wrote:
> From: Rob Landley <rob@landley.net>
> 
> Commit b67177ecd956 broke the j-core SOC build with a link failure, because
> mm/percpu.c function pcpu_post_unmap_tlb_flush() calls flush_tlb_kernel_range()
> which is defined under #ifdef CONFIG_MMU.

Looks like you're missing a "Fixes:" tag.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

