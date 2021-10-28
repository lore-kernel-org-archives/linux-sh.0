Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A0DC433FE
	for <linux-sh@archiver.kernel.org>; Thu, 28 Oct 2021 13:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9EB60551
	for <linux-sh@archiver.kernel.org>; Thu, 28 Oct 2021 13:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhJ1NdV (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 28 Oct 2021 09:33:21 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:40960 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhJ1NdU (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 28 Oct 2021 09:33:20 -0400
Date:   Thu, 28 Oct 2021 09:30:53 -0400
From:   Rich Felker <dalias@libc.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH 2/5 v3] sh: add git tree to MAINTAINERS
Message-ID: <20211028133049.GY7074@brightrain.aerifal.cx>
References: <20211005001914.28574-1-rdunlap@infradead.org>
 <20211005001914.28574-3-rdunlap@infradead.org>
 <20211027205431.GX7074@brightrain.aerifal.cx>
 <CAMuHMdWUQkhYxXfrG4MG-Ghi62P_XVxkCMb_6qijP-MMgn-JWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWUQkhYxXfrG4MG-Ghi62P_XVxkCMb_6qijP-MMgn-JWg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Oct 28, 2021 at 10:33:54AM +0200, Geert Uytterhoeven wrote:
> Hi Rich,
> 
> On Wed, Oct 27, 2021 at 10:54 PM Rich Felker <dalias@libc.org> wrote:
> > On Mon, Oct 04, 2021 at 05:19:11PM -0700, Randy Dunlap wrote:
> > > Add the git tree location for linux-sh.
> > >
> > > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> > > --- linux-next-20211001.orig/MAINTAINERS
> > > +++ linux-next-20211001/MAINTAINERS
> > > @@ -18047,6 +18047,7 @@ M:    Yoshinori Sato <ysato@users.sourcefor
> > >  M:   Rich Felker <dalias@libc.org>
> > >  L:   linux-sh@vger.kernel.org
> > >  S:   Maintained
> > > +T:   git git://git.libc.org/linux-sh
> > >  Q:   http://patchwork.kernel.org/project/linux-sh/list/
> > >  F:   Documentation/sh/
> > >  F:   arch/sh/
> >
> > I'm omitting this for now since (as noted on the cgit description)
> > this server is not provisioned adequately for cloning from scratch,
> > and should only be used for fetch into an already-populated mainline
> > repo clone. If that's a problem I can see about getting it moved
> > somewhere more appropriate.
> 
> Perhaps you can move it to kernel.org?

I would love to. This was my hope years ago, but I got bogged down in
the GPG key signing requirements and folks not following through with
signing my key. Has any of that been streamlined since?

> > The rest of this series should appear in next shortly.
> 
> Thanks a lot!

Looks like it's been pulled by next now with no reports of anything
going wrong. I know it's late in the release cycle but should I
probably go ahead and send a PR?

Rich
