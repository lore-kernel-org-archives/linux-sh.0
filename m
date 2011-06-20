From: Simon Horman <horms@verge.net.au>
Date: Mon, 20 Jun 2011 06:22:31 +0000
Subject: 2.6.35 Backports
Message-Id: <20110620062231.GA16381@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I have recently been involved in a project to backport various
drivers and platform code for the AP4EVB and Mackerel to 2.6.35.
I am happy to be able to make these backports available at:

git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-backport.git

The available backports are:

	Driver/Platform			Branch
	-----------------------------------------------
	SDHI Driver:			2.6.35/sdhi-6
	MMCIF Driver:			2.6.35/mmcif-3
	CMT Driver:			2.6.35/cmt-3
	Key Scan Driver:		2.6.35/keysc-2
	i2c-sh_mobile Driver:		2.6.35/i2c-2
	SH DMA Engine Driver:		2.6.35/keysc-2
	FSI Driver + AK642 Codec:	2.6.35/fsi-9
	SCIFAB Driver:			2.6.35/scifab-6
	sh7372 + Mackerel + AP4EVB:	2.6.35/ap4-7

* In general each backport includes all changes since 2.6.35 and
  was most recently updated for 3.0-rc3. There is an intention
  to maintain these backports in the medium term.
* The number at the end of each branch name is the revision of the backport.
  If changes are to be made a new revision will be made, that is, the
  branches above will not change.
  As the numbers imply, there are older revisions of each backport,
  however as these are generally broken in some way I have not
  pushed them into the tree. I can do so if there is a need.
* Some backports are dependent on each other, in particular
  the 2.6.35/ap4-7 requires some drivers. It is envisaged
  that working trees will be constructed by
  a) Merging the relevant drivers and as needed platform code
  b) Updating platform data as necessary.
* Branches of the form 2.6.35/partial/XXX-N are partial backports
  of infrastructure which more than one of the backports above depend on.
  They are not particularly useful in their own right.

* These backports are provided in the hope that they are useful to others.


