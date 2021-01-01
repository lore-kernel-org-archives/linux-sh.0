Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B45BC433E0
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 14:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7EB221FE
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 14:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbhAAO2z (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Jan 2021 09:28:55 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:34285 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726747AbhAAO2z (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Jan 2021 09:28:55 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kvLPL-001lj7-Nx; Fri, 01 Jan 2021 15:27:59 +0100
Received: from p5b13a2ad.dip0.t-ipconnect.de ([91.19.162.173] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kvLPK-003G3u-Un; Fri, 01 Jan 2021 15:27:59 +0100
Subject: Re: [patch 02/19] sh: Get rid of nmi_count()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20201113140207.499353218@linutronix.de>
 <20201113141732.844232404@linutronix.de>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <b9275f62-45c2-2472-2c1d-00706c757a30@physik.fu-berlin.de>
Date:   Fri, 1 Jan 2021 15:27:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201113141732.844232404@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.173
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hello Thomas!

On 11/13/20 3:02 PM, Thomas Gleixner wrote:
> nmi_count() is a historical leftover and SH is the only user. Replace it
> with regular per cpu accessors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/sh/kernel/irq.c   |    2 +-
>  arch/sh/kernel/traps.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/sh/kernel/irq.c
> +++ b/arch/sh/kernel/irq.c
> @@ -44,7 +44,7 @@ int arch_show_interrupts(struct seq_file
>  
>  	seq_printf(p, "%*s: ", prec, "NMI");
>  	for_each_online_cpu(j)
> -		seq_printf(p, "%10u ", nmi_count(j));
> +		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j);
>  	seq_printf(p, "  Non-maskable interrupts\n");
>  
>  	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
> --- a/arch/sh/kernel/traps.c
> +++ b/arch/sh/kernel/traps.c
> @@ -186,7 +186,7 @@ BUILD_TRAP_HANDLER(nmi)
>  	arch_ftrace_nmi_enter();
>  
>  	nmi_enter();
> -	nmi_count(cpu)++;
> +	this_cpu_inc(irq_stat.__nmi_count);
>  
>  	switch (notify_die(DIE_NMI, "NMI", regs, 0, vec & 0xff, SIGINT)) {
>  	case NOTIFY_OK:
> 

Just booted my SH7785LCR board with a kernel based on Linus' latest tree
and can confirm that this change does not cause any regressions.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

