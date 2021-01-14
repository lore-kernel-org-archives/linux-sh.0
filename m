Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07984C433E0
	for <linux-sh@archiver.kernel.org>; Thu, 14 Jan 2021 22:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF50C23A5E
	for <linux-sh@archiver.kernel.org>; Thu, 14 Jan 2021 22:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbhANWzX (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 14 Jan 2021 17:55:23 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:60780 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbhANWzX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 14 Jan 2021 17:55:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id A2390227AE;
        Thu, 14 Jan 2021 17:54:39 -0500 (EST)
Date:   Fri, 15 Jan 2021 09:54:37 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Gerhard Pircher <gerhard_pircher@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Undesirable code, was Re: Old platforms etc.
In-Reply-To: <CAK8P3a1+SdAW8VKnvMdXNVcpR-ykNdPoqLqb59uxzB+jNFJRtg@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2101150924260.7@nippy.intranet>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de> <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de> <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
 <1be37673-db0e-f09d-68c8-f929be4019ab@physik.fu-berlin.de> <CAK8P3a1+SdAW8VKnvMdXNVcpR-ykNdPoqLqb59uxzB+jNFJRtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, 14 Jan 2021, Arnd Bergmann wrote:

> I think it's mainly a misunderstanding of what I am trying to do
> in finding the platforms that have been completely abandoned.

Have you tried to identify those drivers and Kconfig symbols in mainline 
that are used only by devices that don't function with mainline kernels?
