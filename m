Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8451C63798
	for <linux-sh@archiver.kernel.org>; Tue, 24 Nov 2020 00:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3200120729
	for <linux-sh@archiver.kernel.org>; Tue, 24 Nov 2020 00:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJTyhrP2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j6SecNH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgKXAGS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:06:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKXAGS (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 23 Nov 2020 19:06:18 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606176375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pHgX8+4TV9Nw2BiY/0kJVALhIqoS3Bge9Gph+T2lLis=;
        b=HJTyhrP2bJioLD+987Ys70sntmISGX+DLi5zSWQWyOeNYxGw+Rcgcp96xJXkNql5saR4b1
        mtRJeCQMIYNOQc5bGK9o3cjSFHmd0XwO5JzY9Ed97ukjc9tLjn2NVQpjFv7Tl1UCWJyJxP
        4r4pyVX89yJRly+FJ1p9pSNf87sDfHyqh8WflOfzH0e+r9XFjgJp1ILEUFI98Q3jUGqNI8
        ZIdelFQeSVJ7UVhprV3dNRgYyMF3dgl3qia6vzgckrcgkrsKzdV18WnWbwxPPhOYtVJGWc
        cr5Duzs/vYWkaaAOPuJb9Qv9vdNI3WJRAwaCR1OTmFq2ePRtPZnRbJJzycwJsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606176375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pHgX8+4TV9Nw2BiY/0kJVALhIqoS3Bge9Gph+T2lLis=;
        b=j6SecNH3mtXRZPPLBTkvtl4Q11WTEjpfetY9og3uuduZGYkJQlpXdvg4Dnk0hrMtUfud6O
        7Ako8/dL7EVU3NCg==
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
In-Reply-To: <20201123235801.GE1751@lothringen>
References: <20201113140207.499353218@linutronix.de> <20201113141734.324061522@linutronix.de> <20201123134437.GA95787@lothringen> <87r1ojnaai.fsf@nanos.tec.linutronix.de> <20201123235801.GE1751@lothringen>
Date:   Tue, 24 Nov 2020 01:06:15 +0100
Message-ID: <87wnyblitk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Nov 24 2020 at 00:58, Frederic Weisbecker wrote:
> On Mon, Nov 23, 2020 at 08:27:33PM +0100, Thomas Gleixner wrote:
>> On Mon, Nov 23 2020 at 14:44, Frederic Weisbecker wrote:
>> > On Fri, Nov 13, 2020 at 03:02:21PM +0100, Thomas Gleixner wrote:
>> >> +	/*
>> >> +	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
>> >> +	 * in_serving_softirq() become true.
>> >> +	 */
>> >> +	cnt = SOFTIRQ_OFFSET;
>> >> +	__local_bh_enable(cnt, false);
>> >
>> > But then you enter __do_softirq() with softirq_count() == SOFTIRQ_OFFSET.
>> > __do_softirq() calls softirq_handle_begin() which then sets it back to
>> > SOFTIRQ_DISABLE_OFFSET...
>> 
>> The RT variant of it added in this very same patch
>> > +static inline void softirq_handle_begin(void) { }
>> > +static inline void softirq_handle_end(void) { }
>
> Ah but then account_irq_enter_time() is called with SOFTIRQ_OFFSET (it's
> currently called with softirq_count == 0 at this point) and that may mess
> up irqtime accounting which relies on it. It could spuriously account all
> the time between the last (soft-)IRQ exit until now as softirq time.

Good point. Haven't thought about that. Let me have a look again.

Thanks,

        tglx
