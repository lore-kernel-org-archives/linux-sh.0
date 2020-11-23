Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE94C63697
	for <linux-sh@archiver.kernel.org>; Mon, 23 Nov 2020 23:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C765520728
	for <linux-sh@archiver.kernel.org>; Mon, 23 Nov 2020 23:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFRCTaZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgKWX6G (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727931AbgKWX6F (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 23 Nov 2020 18:58:05 -0500
Received: from localhost (unknown [176.167.152.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2051A20724;
        Mon, 23 Nov 2020 23:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606175884;
        bh=wlBAJHyNfRR9V9uKfIpJvzXL6dugQ5jSJ9PZbyQVK0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFRCTaZAgmKkRgWK4QqyETUgI+4tgN0UAq7RB9jbFcwi4RliJmfWhNnxQAcigLBCR
         FN+MYO/tZhuK0KF5bqdJPRF4oO31elR3z/Li3TGW9+/te1VGJES/iAEXj/tvELbdcb
         lf9dhGlX6/nYJJ5+rLwfRWNydnK9WXypNmscWo1g=
Date:   Tue, 24 Nov 2020 00:58:01 +0100
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
Message-ID: <20201123235801.GE1751@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.324061522@linutronix.de>
 <20201123134437.GA95787@lothringen>
 <87r1ojnaai.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1ojnaai.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Nov 23, 2020 at 08:27:33PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 23 2020 at 14:44, Frederic Weisbecker wrote:
> > On Fri, Nov 13, 2020 at 03:02:21PM +0100, Thomas Gleixner wrote:
> >> +	/*
> >> +	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
> >> +	 * in_serving_softirq() become true.
> >> +	 */
> >> +	cnt = SOFTIRQ_OFFSET;
> >> +	__local_bh_enable(cnt, false);
> >
> > But then you enter __do_softirq() with softirq_count() == SOFTIRQ_OFFSET.
> > __do_softirq() calls softirq_handle_begin() which then sets it back to
> > SOFTIRQ_DISABLE_OFFSET...
> 
> The RT variant of it added in this very same patch
> > +static inline void softirq_handle_begin(void) { }
> > +static inline void softirq_handle_end(void) { }

Ah but then account_irq_enter_time() is called with SOFTIRQ_OFFSET (it's
currently called with softirq_count == 0 at this point) and that may mess
up irqtime accounting which relies on it. It could spuriously account all
the time between the last (soft-)IRQ exit until now as softirq time.
