Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD97C4332F
	for <linux-sh@archiver.kernel.org>; Thu,  7 Oct 2021 08:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2716113E
	for <linux-sh@archiver.kernel.org>; Thu,  7 Oct 2021 08:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbhJGIKF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 7 Oct 2021 04:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240615AbhJGIKB (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Thu, 7 Oct 2021 04:10:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A63A161354;
        Thu,  7 Oct 2021 08:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633594088;
        bh=dm9/vpPW4I/oLlWZ3sN+YDm0nseIyiNdiq2BmTSzlNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8wrvs97fHfdiL5l1GNqfBsj5WSvMC2CgUNRkAD9lWilsADRiRDh393GWk3HUn3Ts
         vM8d9uccvuv8G5TMLMWf1winBoFuEDY3PrhNdg3gcjr+GBL7pd3oBmM1mAkTUFkoSI
         w8Z+IjERciMgdML4PF+krqxXeBNo08oiouFvkZn2vMvUYgTzZTKdT5c69xX8qW1K+h
         b2l74TEajI8beXDoYksoK4Cx+j/QDC47jIPwSUGr87wY62bC9610e0qQsUW+K3OPGm
         u1cEgxGh9gh5goTfjXOtts91pNmMR0FxKVGHPwbVS74rMsnljpa216ovjPWLt40afS
         ETw3OdvPPVNwg==
Date:   Thu, 7 Oct 2021 09:07:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, Jonas Bonn <jonas@southpole.se>,
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
Message-ID: <20211007080758.GA31467@willie-the-truck>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-5-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006164332.1981454-5-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/kernel/smp.c | 31 ++-----------------------------
>  1 file changed, 2 insertions(+), 29 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

It's a shame INVALID_HWID can't be removed too, but looks like it's still
used in a couple of places.

Will
