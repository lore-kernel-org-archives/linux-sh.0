From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 24 Jul 2016 00:28:52 +0000
Subject: Re: Adding linux-sh (arch/sh) to linux-next
Message-Id: <20160724102852.34b897a6@canb.auug.org.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20160722183006.GA28189@brightrain.aerifal.cx>
In-Reply-To: <20160722183006.GA28189@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Rich,

On Fri, 22 Jul 2016 14:30:06 -0400 Rich Felker <dalias@libc.org> wrote:
>
> Can you please add the linux-sh tree's for-next branch to be pulled
> for linux-next?
> 
> 	git://git.libc.org/linux-sh for-next
> 
> Let me know if anything's wrong with how it's set up. I'm new to
> linux-next (and still fairly new to arch maintainership) so apologies
> if I missed anything. I do plan to move the tree to kernel.org,
> hopefully soon, but I'm still waiting on people who promised to sign
> my keys so for the time being it's still on libc.org.

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr@canb.auug.org.au
