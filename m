From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 06 Mar 2014 11:24:57 +0000
Subject: Re: [PATCH v3 1/3] DMA: shdma: Fix warnings due to improper casts and printk formats
Message-Id: <2961845.2oE3ehzAEj@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1386765786-1926-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386765786-1926-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

On Thursday 06 March 2014 11:38:05 Vinod Koul wrote:
> On Tue, Mar 04, 2014 at 06:07:55PM +0100, Laurent Pinchart wrote:
> > On Tuesday 04 March 2014 16:50:29 Koul, Vinod wrote:
> > > On 4 Mar 2014 17:11, Laurent Pinchart wrote:
> > > > On Tuesday 21 January 2014 13:10:30 Laurent Pinchart wrote:
> > > > > On Tuesday 07 January 2014 16:08:37 Laurent Pinchart wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > Ping ? Could this patch series (with patches v3.1 1/3, v3 2/3 and
> > > > > > v3 3/3) be applied for v3.14 ? Same question for "DMA: shdma:
> > > > > > Enable driver compilation with COMPILE_TEST".
> > > > > 
> > > > > PING ?
> > > > 
> > > > HELLO ? ANYONE THERE ? This is v3.14 material.
> > > 
> > > Sorry looks like I missed out earlier... Am just back from vacation,
> > > give me few days to go thru this and do the needful...
> > 
> > No worries, and thanks for handling this. I'm glad to know you're still
> > alive :-)
> 
> Well i shouldnt have missed this earlier!
> 
> Anyway I have applied these. Since these are fixing warning I am going to
> push them to 3.15. Sending warnings fixes to Linus after rc4 isn't a good
> idea. Sorry bad timing :(

No worries. Given that the COMPILE_TEST patch didn't go in v3.14 the warning 
fixes can be delayed until 3.15.

-- 
Regards,

Laurent Pinchart

