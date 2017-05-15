From: Rob Landley <rob@landley.net>
Date: Mon, 15 May 2017 02:46:07 +0000
Subject: QEMU serial still broken in -rc1.
Message-Id: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I refer to the previous thread, which is still the case:

http://www.spinics.net/lists/linux-sh/msg51190.html

I poked at QEMU's internals to see if there was an easy way to fiddle
with stuff, but A) ttySC1 appears to be the only serial type the board
emulates, B) the ttySC0 instance is broken, dunno why.

More context from years in the QEMU mines:

http://lists.gnu.org/archive/html/qemu-devel/2009-02/msg00825.html

http://lists.gnu.org/archive/html/qemu-devel/2010-03/msg00976.html

http://lists.gnu.org/archive/html/qemu-devel/2014-09/msg00207.html

As you can see from the fact the 2014 bug is still there in qemu, asking
QEMU to fix anything is basically shouting into a hole. (Although if
other people want to add their voices maybe it'll work better.)

Rob
