From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 19 Nov 2014 22:06:43 +0000
Subject: Re: [GIT PULL] Renesas ARM Based SoC Koelsch Board Removal Updates for v3.19
Message-Id: <201411192306.43386.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415059146.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415059146.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 04 November 2014, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC koelsch board removal updates for v3.19.
> 
> This pull request is based on a merge of:
> 
> * "Renesas ARM Based SoC DT DU Updates for v3.19",
>   tagged as renesas-dt-du-for-v3.19.
> 
> * "Renesas ARM Based SoC DT Cleanups Updates for v3.19",
>   tagged as renesas-dt-cleanups-for-v3.19.
> 
> Both of which I have also sent a pull-request for.
> 
> 
> The following changes since commit 11886d1158e0dc123283891b662381f629ab47a0:
> 
>   Merge tag 'renesas-dt-cleanups-for-v3.19' into koelsch-board-removal-for-v3.19.base (2014-10-30 10:14:38 +0900)
> 
> are available in the git repository at:
> 	
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-koelsch-board-removal-for-v3.19
> 
> for you to fetch changes up to 79e69d179cb3391040a3693fca8bc12ec03c05fc:
> 
>   ARM: shmobile: koelsch dts: Drop console= bootargs parameter (2014-10-30 10:18:31 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Koelsch Board Removal Updates for v3.19
> 
> * Remove lecacy C koelsh board support

I've tried merging this one in two ways, but I'm not too happy about either one:

- we could put it into next/boards, but I don't think there will be anything
  else in that branch and I was considering not to have one at all.

- it would also fit into next/cleanup, but then we already have
  renesas-dt-cleanups-for-v3.19 categorized as "next/dt" rather than
  "next/cleanup". Moving that one into cleanups solves the problem
  nicely, but it's rather large and my feeling is that Olof's decision
  to put it into next/dt was better.

I think you are trying too hard to avoid merge conflicts, as I can't see any
true dependency on renesas-dt-cleanups-for-v3.19, and I'd be happier if
you could rebase it onto renesas-dt-du-for-v3.19 by itself. There is
a trivial merge conflict that I have to resolve, but it seems more
sensible that way.

Any other thoughts?

Clearly the changes in this branch are great and I definitely want to have
them in 3.19.

	Arnd
