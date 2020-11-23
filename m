Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0CDC388F9
	for <linux-sh@archiver.kernel.org>; Mon, 23 Nov 2020 13:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33B5206F1
	for <linux-sh@archiver.kernel.org>; Mon, 23 Nov 2020 13:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+ehFd6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbgKWNol (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 23 Nov 2020 08:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbgKWNol (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 23 Nov 2020 08:44:41 -0500
Received: from localhost (unknown [176.167.152.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2AF206F1;
        Mon, 23 Nov 2020 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606139080;
        bh=P9zQbHB28E6VtYusUFpATLlB1aKLlAxQSqrq/mCm4FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+ehFd6USfbS/TljS1tg/RC+MNXIQxsXIXc+xVORBRpWK5OMZqRunsbCJWvMXQuor
         KDFJIax5mc0aaPeN/c15BVFH2tuZnwaXqQ1i+BgXEeLu1OjJBSAHJ+u0CKbLSlD45Q
         2GlZcY3RVfb4H4uRcAcxIKt0VrsnKIWLDUKKugBA=
Date:   Mon, 23 Nov 2020 14:44:37 +0100
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
Subject: Re: [patch 14/19] softirq: Make softirq control and processing RT
 aware
Message-ID: <20201123134437.GA95787@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.324061522@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113141734.324061522@linutronix.de>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Fri, Nov 13, 2020 at 03:02:21PM +0100, Thomas Gleixner wrote:
> +void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
> +{
> +	bool preempt_on = preemptible();
> +	unsigned long flags;
> +	u32 pending;
> +	int curcnt;
> +
> +	WARN_ON_ONCE(in_irq());
> +	lockdep_assert_irqs_enabled();
> +
> +	local_irq_save(flags);
> +	curcnt = this_cpu_read(softirq_ctrl.cnt);
> +
> +	/*
> +	 * If this is not reenabling soft interrupts, no point in trying to
> +	 * run pending ones.
> +	 */
> +	if (curcnt != cnt)
> +		goto out;
> +
> +	pending = local_softirq_pending();
> +	if (!pending || ksoftirqd_running(pending))
> +		goto out;
> +
> +	/*
> +	 * If this was called from non preemptible context, wake up the
> +	 * softirq daemon.
> +	 */
> +	if (!preempt_on) {
> +		wakeup_softirqd();
> +		goto out;
> +	}
> +
> +	/*
> +	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
> +	 * in_serving_softirq() become true.
> +	 */
> +	cnt = SOFTIRQ_OFFSET;
> +	__local_bh_enable(cnt, false);

But then you enter __do_softirq() with softirq_count() == SOFTIRQ_OFFSET.
__do_softirq() calls softirq_handle_begin() which then sets it back to SOFTIRQ_DISABLE_OFFSET...

> +	__do_softirq();
> +
> +out:
> +	__local_bh_enable(cnt, preempt_on);

You escape from there with a correct preempt_count() but still the softirq executes
under SOFTIRQ_DISABLE_OFFSET and not SOFTIRQ_OFFSET, making in_serving_softirq() false.

> +	local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL(__local_bh_enable_ip);

Thanks.
