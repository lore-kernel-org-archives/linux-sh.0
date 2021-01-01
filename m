Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790C5C433DB
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 14:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3409D221FE
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 14:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbhAAOUV (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Jan 2021 09:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbhAAOUV (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Jan 2021 09:20:21 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38545C061573;
        Fri,  1 Jan 2021 06:19:25 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4D6nG26jzQz1rx7v;
        Fri,  1 Jan 2021 15:19:17 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4D6nFx6224z1qr4s;
        Fri,  1 Jan 2021 15:19:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id BIltP4p3Udx1; Fri,  1 Jan 2021 15:19:17 +0100 (CET)
X-Auth-Info: 1/GNeLCdYALz3a6mX2XzgaEhotv3PN6I0esOTNVZI7jHH/udBpqogP7WlVEmMKUQ
Received: from igel.home (ppp-46-244-163-100.dynamic.mnet-online.de [46.244.163.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  1 Jan 2021 15:19:17 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 9807B2C3621; Fri,  1 Jan 2021 15:19:16 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: boards: Fix the cacography in irq.c
References: <20201119105656.11068-1-tangbin@cmss.chinamobile.com>
X-Yow:  Either CONFESS now or we go to ``PEOPLE'S COURT''!!
Date:   Fri, 01 Jan 2021 15:19:16 +0100
In-Reply-To: <20201119105656.11068-1-tangbin@cmss.chinamobile.com> (Tang Bin's
        message of "Thu, 19 Nov 2020 18:56:56 +0800")
Message-ID: <87sg7k7na3.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Nov 19 2020, Tang Bin wrote:

> The world 'swtich' is wrong, so fix it.

s/world/word/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
