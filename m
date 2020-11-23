Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE87C2D0E4
	for <linux-sh@archiver.kernel.org>; Mon, 23 Nov 2020 19:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7411206CA
	for <linux-sh@archiver.kernel.org>; Mon, 23 Nov 2020 19:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="amCizpPW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GlcMAjj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgKWT1h (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgKWT1g (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 23 Nov 2020 14:27:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF84C0613CF;
        Mon, 23 Nov 2020 11:27:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606159653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TzRAC5hW73yiYJuiiYIIWX/K2NAu8mPi3fpeAy0/13s=;
        b=amCizpPWCFj6Axs+WdkxrRqFE+lU8MuDMXmyWE6f8enVCKpgwNtqwDVcmdJFd8To1THP5I
        EzayCNumDArKzAPuWfYxA8AzxbKkWnU26RRP2fqY/WRSLjTj9OkHWSzcainSwG2heil0Ek
        1wrNa5d/6+7V0/urWfCYgSTKKmlnFM0Xhew7CTkNLX39HOqsiQZVpD2Spxsw+m9Y5qrLoB
        QxWUrRjM3NirPxmQlaE1ZioKOT2Yhdt6Jw1rfKgCo2UnTLYPfP8Z/RFuuvudXFtFnyX0C+
        UHJN0lQ7ZMRmKXUWIhT2vfPGXX8rClGXStum2m8IpQKGtpcKtzTMsnbaxl4j9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606159653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TzRAC5hW73yiYJuiiYIIWX/K2NAu8mPi3fpeAy0/13s=;
        b=GlcMAjj3axUF6EiWKEBvm1FLqPceaYkWlJcdxg0JzCO+wykp3jClUsOR7LKLoHMig1dNEL
        rht1GQwk0LnvlTDQ==
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
In-Reply-To: <20201123134437.GA95787@lothringen>
References: <20201113140207.499353218@linutronix.de> <20201113141734.324061522@linutronix.de> <20201123134437.GA95787@lothringen>
Date:   Mon, 23 Nov 2020 20:27:33 +0100
Message-ID: <87r1ojnaai.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Nov 23 2020 at 14:44, Frederic Weisbecker wrote:
> On Fri, Nov 13, 2020 at 03:02:21PM +0100, Thomas Gleixner wrote:
>> +	/*
>> +	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
>> +	 * in_serving_softirq() become true.
>> +	 */
>> +	cnt = SOFTIRQ_OFFSET;
>> +	__local_bh_enable(cnt, false);
>
> But then you enter __do_softirq() with softirq_count() == SOFTIRQ_OFFSET.
> __do_softirq() calls softirq_handle_begin() which then sets it back to
> SOFTIRQ_DISABLE_OFFSET...

The RT variant of it added in this very same patch
> +static inline void softirq_handle_begin(void) { }
> +static inline void softirq_handle_end(void) { }

Thanks,

        tglx
