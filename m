Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D2C64E69
	for <linux-sh@archiver.kernel.org>; Fri, 20 Nov 2020 00:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B522224D
	for <linux-sh@archiver.kernel.org>; Fri, 20 Nov 2020 00:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1MQ/TLTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgKTA0Z (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Nov 2020 19:26:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgKTA0Z (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Thu, 19 Nov 2020 19:26:25 -0500
Received: from localhost (can06-h06-176-173-97-249.dsl.sta.abo.bbox.fr [176.173.97.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699D022240;
        Fri, 20 Nov 2020 00:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605831984;
        bh=6woHDUK2/w8uiImED2aQVgFB0Ty6xMl7PTbicL5V8n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1MQ/TLTB/sfVDGEUi5EE96UXmn32gYFCJXyhx5o7RiYtnWl5g3a8Z+HpnmS7ma79q
         SvuhIQc1+KjQYV10qbpkVFr05sQcuR0MhBZbn5ofyYBvuRres4RWbWUUyIOtnxtW2J
         t2dqcm8d6MHYZP4b0NxIQFM4HllUcqRbeeowffpw=
Date:   Fri, 20 Nov 2020 01:26:21 +0100
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
Message-ID: <20201120002621.GA32792@lothringen>
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
> +void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
> +{
> +	unsigned long flags;
> +	int newcnt;
> +
> +	WARN_ON_ONCE(in_hardirq());
> +
> +	/* First entry of a task into a BH disabled section? */
> +	if (!current->softirq_disable_cnt) {
> +		if (preemptible()) {
> +			local_lock(&softirq_ctrl.lock);
> +			rcu_read_lock();

Ah you lock RCU because local_bh_disable() implies it and
since it doesn't disable preemption anymore, you must do it
explicitly?

Perhaps local_lock() should itself imply rcu_read_lock() ?

> +		} else {
> +			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
> +		}
> +	}
> +
> +	preempt_disable();

Do you really need to disable preemption here? Migration is disabled by local_lock()
and I can't figure out a scenario where the below can conflict with a preempting task.

> +	/*
> +	 * Track the per CPU softirq disabled state. On RT this is per CPU
> +	 * state to allow preemption of bottom half disabled sections.
> +	 */
> +	newcnt = this_cpu_add_return(softirq_ctrl.cnt, cnt);

__this_cpu_add_return() ?

> +	/*
> +	 * Reflect the result in the task state to prevent recursion on the
> +	 * local lock and to make softirq_count() & al work.
> +	 */
> +	current->softirq_disable_cnt = newcnt;
> +
> +	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt == cnt) {
> +		raw_local_irq_save(flags);
> +		lockdep_softirqs_off(ip);
> +		raw_local_irq_restore(flags);
> +	}
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(__local_bh_disable_ip);
> +
> +static void __local_bh_enable(unsigned int cnt, bool unlock)
> +{
> +	unsigned long flags;
> +	int newcnt;
> +
> +	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
> +			    this_cpu_read(softirq_ctrl.cnt));

__this_cpu_read() ? Although that's lockdep only so not too important.

> +
> +	preempt_disable();

Same question about preempt_disable().

> +	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() == cnt) {
> +		raw_local_irq_save(flags);
> +		lockdep_softirqs_on(_RET_IP_);
> +		raw_local_irq_restore(flags);
> +	}
> +
> +	newcnt = this_cpu_sub_return(softirq_ctrl.cnt, cnt);

__this_cpu_sub_return?

> +	current->softirq_disable_cnt = newcnt;
> +	preempt_enable();
> +
> +	if (!newcnt && unlock) {
> +		rcu_read_unlock();
> +		local_unlock(&softirq_ctrl.lock);
> +	}
> +}

Thanks.
