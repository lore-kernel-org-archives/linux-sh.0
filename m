Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C43C77B73
	for <linux-sh@archiver.kernel.org>; Sat,  6 May 2023 17:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjEFROF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 6 May 2023 13:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFROE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 6 May 2023 13:14:04 -0400
X-Greylist: delayed 1037 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 May 2023 10:14:03 PDT
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C029191C0
        for <linux-sh@vger.kernel.org>; Sat,  6 May 2023 10:14:02 -0700 (PDT)
Date:   Sat, 6 May 2023 12:56:43 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] SH7709 DMA fixes
Message-ID: <20230506165642.GO3298@brightrain.aerifal.cx>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
 <3e9c027dd90ca9d4a02ba06714960ddcdae5fd2c.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e9c027dd90ca9d4a02ba06714960ddcdae5fd2c.camel@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sat, May 06, 2023 at 05:25:01PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Artur!
> 
> Thanks a lot for your patches!
> 
> On Sat, 2023-05-06 at 16:17 +0200, Artur Rojek wrote:
> > this series provides fixes to the SH7709 DMA controller, allowing the HP
> > Jornada 680 palmtop to boot Linux again. To my knowledge, this is the
> > first time in ~14 years someone tests upstream Linux on this device. And
> > with the included patches applied, I'm happy to announce that it still
> > works like a charm.
> 
> Wow, that sounds great! I will be happy to review your patches.
> 
> > PS. What might be of interest to the sh-linux community, there's further
> > work towards this platform in my pipeline. E.g. I've added support for
> > the HD6446x PCMCIA controller, allowing Jornada 680 to use Ethernet and
> > Wi-Fi cards. However, what prevents proper upstream of such a driver is
> > the crude and antiquated code of the underlying platform base. For
> > example, the HD6446x bridge (`cchips/hd6446x/hd64461.c`) lacks the
> > concept of clocks, preventing the PCMCIA driver from hardware agnostic
> > clock gating. So what I'm looking into next is the cleanup of existing
> > platform code base, bringing it up-to-date with modern kernel APIs.
> > Hopefully it's not trying to bite more than I can chew, but eventually
> > ending up with Device Tree support would be really nice :)
> 
> Yes, there is still a lot of modernization work to be done for SuperH!
> 
> Device tree has actually been worked on in the past and there is a patch
> set by Yoshinori Sato to add support for device tree that got never merged,
> see [1].
> 
> Geert and I are planning to have another look at these patches and see whether
> we can get them into a shape where they can be merged. Maybe you can help us
> with that effort.

At one point I tried to rebase these to run on what was (at the time)
current, and had partial success -- I got it to start booting with DT
under qemu, but my work rebasing the PCI stuff had problems and IIRC
prevented getting virtio working -- it was crashing at that stage. If
there's interest I can see if I can dig up that rebased branch in case
it would be useful to look at. It probably has mistakes but might be a
start for looking at what changed out from under the patches that
needs to change.

Rich
