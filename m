Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE6FC388F9
	for <linux-sh@archiver.kernel.org>; Thu, 19 Nov 2020 22:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C950722227
	for <linux-sh@archiver.kernel.org>; Thu, 19 Nov 2020 22:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRZQqwvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKSWwb (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:52:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgKSWwa (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Thu, 19 Nov 2020 17:52:30 -0500
Received: from localhost (unknown [176.167.53.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7CC22227;
        Thu, 19 Nov 2020 22:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605826349;
        bh=YLqkp5mZrk9CzpMu4+a95ZqlYmTlizCb/DRTtNW383U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRZQqwvxbeFf/W1N7gd/3zhLy6+ReIC1tIAYoB02wMTpS5S57L0KqoVejeKj8Rj7p
         E9g7O+Q+m7koeWwx0OuXxbiJ6etNatPA6fDWE9KS4bpj1kCKbN0eZg37dSdjeWnUCG
         XMceozTbM8+W147S5bCl7/IP6SDwziwSVHGxRQFk=
Date:   Thu, 19 Nov 2020 23:52:27 +0100
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
Subject: Re: [patch 12/19] softirq: Add RT specific softirq accounting
Message-ID: <20201119225227.GA29717@lothringen>
References: <20201113140207.499353218@linutronix.de>
 <20201113141734.096224353@linutronix.de>
 <20201119121801.GA20115@lothringen>
 <87ima1p55m.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ima1p55m.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Nov 19, 2020 at 07:34:13PM +0100, Thomas Gleixner wrote:
> On Thu, Nov 19 2020 at 13:18, Frederic Weisbecker wrote:
> > On Fri, Nov 13, 2020 at 03:02:19PM +0100, Thomas Gleixner wrote:
> >> RT requires the softirq to be preemptible and uses a per CPU local lock to
> >> protect BH disabled sections and softirq processing. Therefore RT cannot
> >> use the preempt counter to keep track of BH disabled/serving.
> >> 
> >> Add a RT only counter to task struct and adjust the relevant macros in
> >> preempt.h.
> >
> > You may want to describe a bit the reason for this per task counter.
> > It's not intuitive at this stage.
> 
> Something like this:
> 
>  RT requires the softirq processing and local bottomhalf disabled regions
>  to be preemptible. Using the normal preempt count based serialization is
>  therefore not possible because this implicitely disables preemption.
> 
>  RT kernels use a per CPU local lock to serialize bottomhalfs. As
>  local_bh_disable() can nest the lock can only be acquired on the
>  outermost invocation of local_bh_disable() and released when the nest
>  count becomes zero. Tasks which hold the local lock can be preempted so
>  its required to keep track of the nest count per task.
> 
>  Add a RT only counter to task struct and adjust the relevant macros in
>  preempt.h.
> 
> Thanks,

Very good, thanks!
