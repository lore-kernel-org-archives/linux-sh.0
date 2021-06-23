Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4864C4743C
	for <linux-sh@archiver.kernel.org>; Wed, 23 Jun 2021 13:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A5B61026
	for <linux-sh@archiver.kernel.org>; Wed, 23 Jun 2021 13:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhFWNih (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 23 Jun 2021 09:38:37 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:57579 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230163AbhFWNig (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 23 Jun 2021 09:38:36 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lw33B-001fsV-BD; Wed, 23 Jun 2021 15:36:17 +0200
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lw33B-00340a-5U; Wed, 23 Jun 2021 15:36:17 +0200
Subject: Re: dma_declare_coherent_memory and SuperH
To:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210623133205.GA28589@lst.de>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <9d12d2e3-3faf-3b2f-0265-2baee85c3ead@physik.fu-berlin.de>
Date:   Wed, 23 Jun 2021 15:36:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623133205.GA28589@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Christoph!

On 6/23/21 3:32 PM, Christoph Hellwig wrote:
> I have a vague recollection that you were planning on dropping support
> for non-devicetree platforms, is that still the case?
I guess you are talking about this patch set [1].

Would be great if we could get this rebased and merged. Since Geert has access
to SH hardware as well, he might be able to help.

Adrian

> [1] https://lore.kernel.org/patchwork/cover/693910/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
