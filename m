From: Simon Horman <horms@verge.net.au>
Date: Thu, 11 Jul 2013 01:27:30 +0000
Subject: [ANNOUNCE] Change of use of next branch in renesas tree
Message-Id: <20130711012730.GA11120@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Summary:

If you have been using renesas-next-YYYYMMDD as the basis
for development please now use renesas-devel-YYYYMMDD

Detail:

Over the past months I have been regularly updating the next branch of the
renesas tree as a merge of branches that contain code that I have
queued-up. Currently this includes code that is queued-up for v3.12.

As well as being consumed by developers of shmobile code
the next branch is included in the linux-next tree.

I have been made aware that the code that I include in my
next branch isn't always appropriate for inclusion in linux-next.
In particular:

1. Including code queued-up for v3.N before v3.(N-1)-rc1 is released.
2. Frequent rebasing

In order to address these problems I have done the following:

* Updated the next branch to match the for-next branch of the arm-soc tree.
* Created a new devel branch, for this will function the way the next
  branch used to function. I have also taged renesas-devel-20130711
  in line with the taging scheme that has been in use over
  the past few months for the next branch.

Moving forwards I will endeavour to reduce the number of rebases present
in branches that are merged into next. And hopefully devel too.
