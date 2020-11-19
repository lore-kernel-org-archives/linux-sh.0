Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C0EC2D0E4
	for <linux-sh@archiver.kernel.org>; Thu, 19 Nov 2020 12:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B12246F2
	for <linux-sh@archiver.kernel.org>; Thu, 19 Nov 2020 12:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xjvIzyCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgKSMUM (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Nov 2020 07:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgKSMUL (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Thu, 19 Nov 2020 07:20:11 -0500
Received: from localhost (unknown [176.167.53.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 147F5246E0;
        Thu, 19 Nov 2020 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605788410;
        bh=7msB9UZ0ORXDHxcN+JlYLzzlkduf1INZ0Px8j2bPjc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xjvIzyCJh5J9yoHMKvk7u8/J045IF1dkz6lt3l2nW3/ex+fHmrOsoYSMGsqdlePCu
         YNBtsVHbgbJxpxIAkBi/bPW006T3JDX01JIEcwzACUrOS6HfDmILJ02NqkD04mGDts
         JJilgH+zhuK+myshHmBxBRcagyNXGuy0w5Fyx41Q=
Date:   Thu, 19 Nov 2020 13:20:06 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch 11/19] softirq: Move related code into one section
Message-ID: <20201119122006.GB20115@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141733.974214480@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113141733.974214480@linutronix.de>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Fri, Nov 13, 2020 at 03:02:18PM +0100, Thomas Gleixner wrote:
> To prepare for adding a RT aware variant of softirq serialization and
> processing move related code into one section so the necessary #ifdeffery
> is reduced to one.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Up to this patch at least:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
