From: Simon Horman <horms@verge.net.au>
Date: Mon, 15 Oct 2012 01:49:56 +0000
Subject: [README] mach-shmobile changes for 3.8
Message-Id: <20121015014956.GD20403@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I would like to provide everyone with an update of the status
of my renesas tree and thus patches for mach-shmobile.

git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git


Status:

* I have rebased the branches of my tree on top of v3.7-rc1.

* I have applied all patches that I am aware of.

  If you have patches outstanding then please check the next branch.
  If your patch is not there then please either repost it or ping me.

* I plan to start sending pull-requests to soc-arm (upstream)
  later this week. And to send subsequent pull-requests as necessary.


Guidance for Developers:

* Fixes for 3.7

  + Please post fixes for 3.7 if/when you have them so that
    I can apply them to the fixes branch and endeavour to have
    them included in 3.7.

  + Please clearly mark if a patch is a fix and intended for 3.7

* Non-fixes (for 3.8)

  + All non-fixes should be targeted for 3.8 and should have been
    posted, reviewed and merged by me by the time 3.7-rc5 is released.

  + Please post early and often, this will give me the best chance
    of getting your changes included. A flood of patches just
    before 3.7-rc5 is not the path of least resistance.

* Please include the following on the To/Cc list of patches that
  you wish to be reviewed and considered for merging.

  + linux-sh@vger.kernel.org
  + linux-arm-kernel@lists.infradead.org
  + Simon Horman <horms@verge.net.au>
