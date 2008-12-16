From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Dec 2008 07:31:12 +0000
Subject: [ANNOUNCE] QEMU/SH staging tree
Message-Id: <20081216073111.GA27634@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Due to issues with patches either getting lost, overlooked, or
re-implemented multiple times by different people, I've opted to start
tracking SH-specific development patches against QEMU in a staging tree.
Rather than using a fork of the tree, I've opted for a quilt series
instead, as this tends to fit the model for the staging tree much better.

Anyone doing QEMU development should be doing this against the QEMU SVN
HEAD directly, though of course it is possible to build up a dependency
chain based on patches within the staging tree.

Additionally, this also serves as a reference point for users that want
to make sure they have the latest and greatest of SH development work
against QEMU as it is today. Also note that this tree will be following
the QEMU SVN, rather than fixed releases. Patches in this tree are
intended to be short lived, and will be dropped as soon as they have
found their way upstream.

The quilt series can be found at:

	git://git.kernel.org/pub/scm/virt/qemu/lethal/qemu-sh.git

More documentation and notes can be found in the tree itself, and there
is also some background in the qemu-devel archives for those enterprising
individuals that care about such things.

Status updates will be reflected on the wiki.
