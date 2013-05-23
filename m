From: Simon Horman <horms@verge.net.au>
Date: Thu, 23 May 2013 01:40:03 +0000
Subject: [Announce] Renesas branches rebased on v3.10-rc2
Message-Id: <20130523014003.GN22608@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I have rebased all branches of the renesas tree that are targeted
at v3.11 on top of v3.10-rc2. I have also merged these into
a new next branch which I have pushed and tagged as renesas-next-20130523.
This should appear in linux-next in the not to distant future.

There are a few -fixes branches which resolve problems in v3.10-rc1. I will
get pull requests to arm-soc for those branches in the not to distant
future. The target for -fixes branches is v3.10.

As this took a while I am a little behind with picking up patches that
have been posted, but I hope to catch up over the next few days.

Moving forwards, assuming that nothing dramatic happens I will start
sending pull requests to arm-soc for the non-fixes branches so they
can be included in v3.11. At this stage I plan to start doing that
next week.

Known problems: Booting marzen-reference seems flakey and I'm entirely
unsure why.

