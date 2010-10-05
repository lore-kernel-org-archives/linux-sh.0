From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 05 Oct 2010 09:26:47 +0000
Subject: Re: [PATCH] sh: Fix address calculation of Initrd
Message-Id: <20101005092647.GG7984@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1286266568-23206-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1286266568-23206-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 05, 2010 at 05:34:29PM +0900, Nobuhiro Iwamatsu wrote:
> Hi,
> 
> 2010/10/5 Paul Mundt <lethal@linux-sh.org>:
> > On Tue, Oct 05, 2010 at 05:16:08PM +0900, Nobuhiro Iwamatsu wrote:
> >> From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> >>
> >> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> >
> > Can you describe what exactly the issue is?
> 
> Because there is it on physics memory, start value fails in the check
> by PAGE_OFFSET.
> And __pa() is not necessary for the same reason.
> 
> > Is this broken on 29 bit or
> > 32 bit? Did you test both?
> 
> Yes, I tested on both.
> 
Ok, applied, thanks.
