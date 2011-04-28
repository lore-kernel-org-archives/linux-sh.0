From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 28 Apr 2011 23:54:12 +0000
Subject: [RFC][PATCH 0/2] PM: Support for generic I/O power domains
Message-Id: <201104290154.12966.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi,

The first of the following two patches adds common definitions and code
for supporting generic I/O power domains and the second patch shows how
it can be used by the example of ARM shmobile platform.

The patches are on top of the branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git power-domains

Comments welcome.

Thanks,
Rafael

