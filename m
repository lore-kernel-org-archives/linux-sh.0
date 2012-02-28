From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 28 Feb 2012 06:09:09 +0000
Subject: Re: [PATCH] mackerel: Do not enable TMU timer in default config
Message-Id: <20120228060908.GJ9994@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1329111377-15676-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1329111377-15676-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 28, 2012 at 02:23:45AM +0100, Rafael J. Wysocki wrote:
> However, having looked at both sh_tmu and sh_cmt I don't see why the former
> should break things (during boot), while the latter doesn't, so I've done
> some more testing and, surprisingly enough, it turns out that disabling runtime
> PM in sh-sci makes the boot hang with sh_tmu enabled go away.  So perhaps sh_tmu
> is just a messenger here and the real problem is with sh-sci.
> 
> I think that more investigation is needed.
> 
Do you see any different behaviour with early printk enabled vs disabled?
We did have the ordering issues before with the pm calls hanging or
oopsing in the early path, but all of those should have been fixed
already. There have been quite a few sh-sci changes though, so if it
worked previously it should be bisectable at least.
