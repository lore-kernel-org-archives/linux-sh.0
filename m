From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Apr 2013 07:07:00 +0000
Subject: [ANNOUNCE] Fine grained branches
Message-Id: <20130404070700.GA10022@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

in an effort to streamline management of the renesas tree
I am trying the use of more fine-grained branches.

For the past few release there have been the following branches:

* defconfig
* boards
* soc
* pinmux

Some sundry branches for drivers. And merge branches that
bring things together. Currently next is the only merge
branch I am maintaining.

Going forwards I plan to make per-board defconfig and boards branches
and per-soc pinmux and soc branches.

So instead of applying an sh73a0 patch to soc, I will apply
it to soc-sh73a0.

I will, as before, merge all relevant branches into next.

I have also recently starting taging next branches, to provide a
reference point for developers. Unlike next, which changes every time
I do a merge of new changes, tags don't change (unless I make a mistake!).
The current tag is renesas-next-20130303. I plan to make
renesas-next-20130304 shortly. Please consider basing your work
on the latest renesas-next tag. And please consider quoting the
tag name your work is based on when posting it.

Thanks
