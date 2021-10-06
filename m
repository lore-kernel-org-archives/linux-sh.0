Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B8CC433EF
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 21:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2374E611CC
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 21:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJFVrt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:47:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:45236 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhJFVrs (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Wed, 6 Oct 2021 17:47:48 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 196LRU0O007032;
        Wed, 6 Oct 2021 16:27:30 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 196LRS4V007029;
        Wed, 6 Oct 2021 16:27:28 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 6 Oct 2021 16:27:28 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Rich Felker <dalias@libc.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yoshinori Sato <ysato@users.osdn.me>, linux-sh@vger.kernel.org,
        x86@kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Ray Jui <rjui@broadcom.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Scott Branden <sbranden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        James Morse <james.morse@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/12] openrisc: Use of_get_cpu_hwid()
Message-ID: <20211006212728.GM10333@gate.crashing.org>
References: <20211006164332.1981454-1-robh@kernel.org> <20211006164332.1981454-7-robh@kernel.org> <YV4KkAC2p9D4yCnH@antec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV4KkAC2p9D4yCnH@antec>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Oct 07, 2021 at 05:44:00AM +0900, Stafford Horne wrote:
> You have defined of_get_cpu_hwid to return u64, will this create compiler
> warnings when since we are storing a u64 into a u32?
> 
> It seems only if we make with W=3.

Yes.  This is done by -Wconversion, "Warn for implicit conversions that
may alter a value."

> I thought we usually warned on this.

This warning is not in -Wall or -Wextra either, it suffers too much from
false positives.  It is very natural to just ignore the high bits of
modulo types (which is what "unsigned" types *are*).  Or the bits that
"fall off" on a conversion.  The C standard makes this required
behaviour, it is useful, and it is the only convenient way of getting
this!


Segher
