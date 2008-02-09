From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 09 Feb 2008 04:26:53 +0000
Subject: Re: multiple hit on TLB
Message-Id: <20080209042653.GA24622@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080208.141034.46637747.saito@densan.co.jp>
In-Reply-To: <20080208.141034.46637747.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 08, 2008 at 02:10:34PM +0900, Hideo Saito wrote:
> On linux-2.6.24 for SH7780, I see a multiple hit in UTLB entries, for
> example, if |p->x| causes TLB miss exception in the following code.
> 
> a = p->x;  |do_page_fault| is called and UTLB is updated to read from |p->x|
> p->x = b;  |__do_page_fault| is called and UTLB is updated to write to |p->x|
> 
> I think following code should not be removed for TLB miss optimizations.
> 
Well, I'm glad someone hit this at least. Yes, if you are having multiple
hits then this needs to be left in place. Initially we removed it for the
SMP case, so it looks like it will have to be conditionalized at this
point. I'll look in to it a bit more and queue up a pach for -rc1 and
-stable, thanks.
