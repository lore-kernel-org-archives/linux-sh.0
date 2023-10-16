Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAA7CDB474
	for <linux-sh@archiver.kernel.org>; Mon, 16 Oct 2023 21:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjJPVzv (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 16 Oct 2023 17:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjJPVzu (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 16 Oct 2023 17:55:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F97A2
        for <linux-sh@vger.kernel.org>; Mon, 16 Oct 2023 14:55:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697493346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8i9gPcV8p3A2sKVvP7yokWUH9lwvfeDfZt3BLwWryk=;
        b=mOsV65LsYJFPRGxYgIF5g3NfkBZ11BiX2BjzzqVnhzp6s8RcUtQH+n25demKjTntUZTieI
        iJvP7E5RykL1UmKHblj/6Caf8863jSiLZw8zQCBEVjbim+B3Mf/XbIqBnc7z/tFLAXHCSl
        bgyWGL6/hgWnQZ61fIR46jCedvSILKLadXgeUMw7wCemS9/+2zOTmYKl09YuFVP960Uz6C
        mHxRidrJ1Gd7i4hKD7yl2QTtO/ilc8s2sVtQ30gFuAqwqslf5ySK1wltdSprXFAf8Al4Qh
        Iv3irK0JiMbEI21hz0cPyGKQ1J1fV4ZeAZR19HCuFZG8UWpxG5iAkB7eyXJbWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697493346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8i9gPcV8p3A2sKVvP7yokWUH9lwvfeDfZt3BLwWryk=;
        b=ZMNQyUoF5s1j+lBdzLJ51n9agtzj1Eaz0uyDL4yVR0oNZawnTKxG1073XuhlviGPLRQRrL
        3GZJhVAihkZ/cVBA==
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     maz@kernel.org
Subject: Re: [RFC PATCH v3 16/35] drivers/irqchip: SH7751 IRL external
 encoder with enable gate.
In-Reply-To: <66f918fd93b7a98a548bd95de615353a43d1cbd1.camel@physik.fu-berlin.de>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <5dfc2f45fd9a701a92ba86800e4f6eba35d96ede.1697199949.git.ysato@users.sourceforge.jp>
 <87edhu76d3.ffs@tglx>
 <66f918fd93b7a98a548bd95de615353a43d1cbd1.camel@physik.fu-berlin.de>
Date:   Mon, 16 Oct 2023 23:55:46 +0200
Message-ID: <875y366xlp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Oct 16 2023 at 20:50, John Paul Adrian Glaubitz wrote:
> On Mon, 2023-10-16 at 20:46 +0200, Thomas Gleixner wrote:
>> > --- a/drivers/irqchip/Kconfig
>> > +++ b/drivers/irqchip/Kconfig
>> > @@ -688,4 +688,11 @@ config RENESAS_SH7751_INTC
>> >  	  Support for the Renesas SH7751 On-chip interrupt controller.
>> >  	  And external interrupt encoder for some targets.
>> 
>> ... I have no idea against which tree this is supposed to apply. None of
>> the trees I usually use has the above. So I assume it's a patch in the
>> same series, but what do I know.
>
> This shall eventually go through my sh-linux tree [1].

That's an actual tree management problem, which is completely
independent of the review process.

Reviewing patches which depend on "unknown" other changes is per
definition impossible and in this case it's even worse because the
dependency affects the same subsystem, no?

Thanks,

        tglx


