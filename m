Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481F3C4332F
	for <linux-sh@archiver.kernel.org>; Mon, 18 Oct 2021 13:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351766138F
	for <linux-sh@archiver.kernel.org>; Mon, 18 Oct 2021 13:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhJRNbg (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Oct 2021 09:31:36 -0400
Received: from foss.arm.com ([217.140.110.172]:37474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232481AbhJRNaO (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 18 Oct 2021 09:30:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 912E8106F;
        Mon, 18 Oct 2021 06:28:03 -0700 (PDT)
Received: from bogus (unknown [10.57.25.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FC7A3F73D;
        Mon, 18 Oct 2021 06:27:55 -0700 (PDT)
Date:   Mon, 18 Oct 2021 14:27:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 04/12] arm64: Use of_get_cpu_hwid()
Message-ID: <20211018132753.4md4xlerul3odxji@bogus>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-5-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006164332.1981454-5-robh@kernel.org>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Oct 06, 2021 at 11:43:24AM -0500, Rob Herring wrote:
> Replace the open coded parsing of CPU nodes' 'reg' property with
> of_get_cpu_hwid().
> 
> This change drops an error message for missing 'reg' property, but that
> should not be necessary as the DT tools will ensure 'reg' is present.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
