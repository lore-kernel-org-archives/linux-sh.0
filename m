From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 17 Mar 2014 11:15:11 +0000
Subject: Updates to shmobile runtime pm usage
Message-Id: <1395054917-27390-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I've done some work on moving the drivers/sh/pm_runtime.c to working
under multi-platform kernel. The first few updates change drivers/sh
and then move to allowing the arch files to call this directly and then
a look at moving the drivers/sh code into drivers/base.

It has yet to be extensively tested, this is a RFC series to see what
people think about it.

