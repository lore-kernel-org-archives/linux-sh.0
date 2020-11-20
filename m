Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4853DC56202
	for <linux-sh@archiver.kernel.org>; Fri, 20 Nov 2020 13:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E09222BA
	for <linux-sh@archiver.kernel.org>; Fri, 20 Nov 2020 13:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HEhswiIm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RZkuXUkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgKTN1V (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 20 Nov 2020 08:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgKTN1U (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 20 Nov 2020 08:27:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F35C0613CF;
        Fri, 20 Nov 2020 05:27:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605878838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHqHNj7D5d9Cv8EzyvHSjgSpDYg4ETCAPafLpAfo//Q=;
        b=HEhswiImS/dENygnbZ2I5TlKQ+4kWcihUrziVeV1d3qqfS3S26UnHRv/Ped0aUKXHjC9Nx
        DgwT754SAUbLML1w4KO9RwBfh4sQ2O3PSAV5pp6fY0aRCPMDk+Ryzev4plDG17YzlQhCFN
        dqjGb9veqbjv5/eG77x99PMJN/E0iPrxWkOOXMljHyyxsQXrY5Kjc24r2mEGZtvBSokEmc
        +wT4EvfQN1L+I+rTB/YyTlA9HawaS+cC7iosldQh5dV51/fJq8R7Kzu0OdcAxdEJcpNSd6
        zzvupz6s5Mp5GkbewQvx7NRr/TQ8pUfDtBascYj+a0qodcbS7k6TmB+sk3flmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605878838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHqHNj7D5d9Cv8EzyvHSjgSpDYg4ETCAPafLpAfo//Q=;
        b=RZkuXUktbRUflzdqY4fITcI9dyb3o37qGwy9CStVW1rfFicwzfXkw4b0liQC4o1VRZpd5V
        cwwxQS4BdJvQIABw==
To:     Frederic Weisbecker <frederic@kernel.org>
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
Subject: Re: [patch 14/19] softirq: Make softirq control and processing RT aware
In-Reply-To: <20201120002621.GA32792@lothringen>
References: <20201113140207.499353218@linutronix.de> <20201113141734.324061522@linutronix.de> <20201120002621.GA32792@lothringen>
Date:   Fri, 20 Nov 2020 14:27:18 +0100
Message-ID: <87o8jsnop5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Fri, Nov 20 2020 at 01:26, Frederic Weisbecker wrote:
> On Fri, Nov 13, 2020 at 03:02:21PM +0100, Thomas Gleixner wrote:
>> +void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
>> +{
>> +	unsigned long flags;
>> +	int newcnt;
>> +
>> +	WARN_ON_ONCE(in_hardirq());
>> +
>> +	/* First entry of a task into a BH disabled section? */
>> +	if (!current->softirq_disable_cnt) {
>> +		if (preemptible()) {
>> +			local_lock(&softirq_ctrl.lock);
>> +			rcu_read_lock();
>
> Ah you lock RCU because local_bh_disable() implies it and
> since it doesn't disable preemption anymore, you must do it
> explicitly?
>
> Perhaps local_lock() should itself imply rcu_read_lock() ?

It's really only required for local_bh_disable(). Lemme add a comment.

>> +		} else {
>> +			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
>> +		}
>> +	}
>> +
>> +	preempt_disable();
>
> Do you really need to disable preemption here? Migration is disabled by local_lock()
> and I can't figure out a scenario where the below can conflict with a
> preempting task.

Indeed it's pointless.

>> +	/*
>> +	 * Track the per CPU softirq disabled state. On RT this is per CPU
>> +	 * state to allow preemption of bottom half disabled sections.
>> +	 */
>> +	newcnt = this_cpu_add_return(softirq_ctrl.cnt, cnt);
>
> __this_cpu_add_return() ?

Yep.

Thanks,

        tglx
