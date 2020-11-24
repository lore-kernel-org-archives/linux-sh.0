Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75640C2D0E4
	for <linux-sh@archiver.kernel.org>; Tue, 24 Nov 2020 00:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105F32075A
	for <linux-sh@archiver.kernel.org>; Tue, 24 Nov 2020 00:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUq69Hdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgKXANx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKXANx (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 23 Nov 2020 19:13:53 -0500
Received: from localhost (unknown [176.167.152.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A3D120757;
        Tue, 24 Nov 2020 00:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606176832;
        bh=H1q3NdPA5XVVHKGEKjYQ4s3GAIDuBwFKucV9+lLeoqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUq69HdgxnvYd/CJdPSIQdLBWDLXZ4EpnV9+8BlBqGhsbsp6ElmI/dbTn82zkagdx
         0Yu1OR5EQaVImLPlvD3ZmBwEIUt3b9L/qQoGV4RfIbNQGjQg6vTJ2w9wXaCHMHXORr
         8ABQTbt0lirfodCOB9pGRMQLt4bC7NbrsKUSZ3sQ=
Date:   Tue, 24 Nov 2020 01:13:50 +0100
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
Message-ID: <20201124001350.GF1751@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.324061522@linutronix.de>
 <20201123134437.GA95787@lothringen>
 <87r1ojnaai.fsf@nanos.tec.linutronix.de>
 <20201123235801.GE1751@lothringen>
 <87wnyblitk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnyblitk.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Nov 24, 2020 at 01:06:15AM +0100, Thomas Gleixner wrote:
> On Tue, Nov 24 2020 at 00:58, Frederic Weisbecker wrote:
> > On Mon, Nov 23, 2020 at 08:27:33PM +0100, Thomas Gleixner wrote:
> >> On Mon, Nov 23 2020 at 14:44, Frederic Weisbecker wrote:
> >> > On Fri, Nov 13, 2020 at 03:02:21PM +0100, Thomas Gleixner wrote:
> >> >> +	/*
> >> >> +	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
> >> >> +	 * in_serving_softirq() become true.
> >> >> +	 */
> >> >> +	cnt = SOFTIRQ_OFFSET;
> >> >> +	__local_bh_enable(cnt, false);
> >> >
> >> > But then you enter __do_softirq() with softirq_count() == SOFTIRQ_OFFSET.
> >> > __do_softirq() calls softirq_handle_begin() which then sets it back to
> >> > SOFTIRQ_DISABLE_OFFSET...
> >> 
> >> The RT variant of it added in this very same patch
> >> > +static inline void softirq_handle_begin(void) { }
> >> > +static inline void softirq_handle_end(void) { }
> >
> > Ah but then account_irq_enter_time() is called with SOFTIRQ_OFFSET (it's
> > currently called with softirq_count == 0 at this point) and that may mess
> > up irqtime accounting which relies on it. It could spuriously account all
> > the time between the last (soft-)IRQ exit until now as softirq time.
> 
> Good point. Haven't thought about that. Let me have a look again.

But I'm cooking a patchset which moves account_irq_enter_time() after
HARDIRQ_OFFSET or SOFTIRQ_OFFSET is incremented. This will allow us to move
tick_irq_enter() under this layout:

		 preempt_count_add(HARDIRQ_OFFSET)
		 lockdep_hardirq_enter()
		 tick_irq_enter()
		 account_irq_enter_time()

This way tick_irq_enter() can be correctly handled by lockdep and we can remove
the nasty hack which temporarily disables softirqs around it.

And as a side effect it should also fix your issue.

I should have that ready soonish.

Thanks.
