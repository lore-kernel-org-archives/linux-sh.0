Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0104FCDB484
	for <linux-sh@archiver.kernel.org>; Tue, 17 Oct 2023 16:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJQQdf (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 17 Oct 2023 12:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjJQQde (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 17 Oct 2023 12:33:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C679E
        for <linux-sh@vger.kernel.org>; Tue, 17 Oct 2023 09:33:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697560411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9rT7VlKgGKcojlP9q2KSBwIJedM2dFGSJADGGOaI+Iw=;
        b=Dh8V+N7WZWg/Q74SAp01rrIS5zvIYKVqRzxUydoj73IrEQxYlIDYXvtB+yycHLl4xqG/W8
        xP8fXw0TfkS8TXWbqCSmdypkS/fBHoMh9Ra+89qCaJse0DqbWf/EFZYa+Go0ZputGqeLdi
        k9MOW7Xxi2OpKkgeQ11S5WcxYP7vCrPo1zfYdDL2Tt3g7pZfHBkWEy3OAIdN17qNu7IihG
        Cpi7p0sKVzS6x3XkZUQsIBmL286TzZ18skGTBaLXBSpmUzXRI9o6P8SvRBqDMAu/LuvqYW
        CrDdySkHrz045zC+IybjFJLNDvLOel9p3JElOUOWswSwRuMi9JfH+wQ3eTqNyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697560411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9rT7VlKgGKcojlP9q2KSBwIJedM2dFGSJADGGOaI+Iw=;
        b=a5vYI7Up8VRbye8f/6TAar/3HlwfplowfXlxMxHMS/pmHBjs4F6jjlhQy84+G69wNNt5Uw
        NtgZoGh7PrZBE0AA==
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     maz@kernel.org
Subject: Re: [RFC PATCH v3 16/35] drivers/irqchip: SH7751 IRL external
 encoder with enable gate.
In-Reply-To: <875y366xlp.ffs@tglx>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <5dfc2f45fd9a701a92ba86800e4f6eba35d96ede.1697199949.git.ysato@users.sourceforge.jp>
 <87edhu76d3.ffs@tglx>
 <66f918fd93b7a98a548bd95de615353a43d1cbd1.camel@physik.fu-berlin.de>
 <875y366xlp.ffs@tglx>
Date:   Tue, 17 Oct 2023 18:33:31 +0200
Message-ID: <87il755hus.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Oct 16 2023 at 23:55, Thomas Gleixner wrote:

> On Mon, Oct 16 2023 at 20:50, John Paul Adrian Glaubitz wrote:
>> On Mon, 2023-10-16 at 20:46 +0200, Thomas Gleixner wrote:
>>> > --- a/drivers/irqchip/Kconfig
>>> > +++ b/drivers/irqchip/Kconfig
>>> > @@ -688,4 +688,11 @@ config RENESAS_SH7751_INTC
>>> >  	  Support for the Renesas SH7751 On-chip interrupt controller.
>>> >  	  And external interrupt encoder for some targets.
>>> 
>>> ... I have no idea against which tree this is supposed to apply. None of
>>> the trees I usually use has the above. So I assume it's a patch in the
>>> same series, but what do I know.
>>
>> This shall eventually go through my sh-linux tree [1].
>
> That's an actual tree management problem, which is completely
> independent of the review process.
>
> Reviewing patches which depend on "unknown" other changes is per
> definition impossible and in this case it's even worse because the
> dependency affects the same subsystem, no?

Never mind. I found the other patch. For some reason that ended up with
broken threading, but I definitely do not have the cover letter.
