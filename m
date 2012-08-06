From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 06 Aug 2012 23:05:22 +0000
Subject: [PATCH 0/12] PM: Make ARM/shmobile PM domains initialization more straightforward
Message-Id: <201208070105.23262.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

Hi all,

The majority of patches in this series were sent previously in this RFC:

http://marc.info/?l=linux-pm&m4247432010192&w=4

but they do not have anything to do with DTs and clean up the code quite
a bit, so I thought they are worth resending in a different context.

Patch [8/12] is new and replaces a patch that removed some code I thought
could never be used, which was wrong.

[1/12] - Make it possible to use domain names for adding devices to PM domains.
[2/12] - Make ARM/shmobile use domain names for adding devices to PM domains.
[3/12] - Drop the r8a7779's "add device to domain" function.
[4/12] - Make it possible to use domain names for adding subdomains to PM domains.
[5/12] - Make ARM/shmobile use domain names for adding subdomains to PM domains.
[6/12] - Add ARM/shmobile function for "batch" initialization of PM domains.
[7/12] - Make it possible to power on a PM domain using its name.
[8/12] - Avoid accessing A4S internals directly in the SH7372 system suspend code.
[9/12] - Put SH7372 PM domain objects into a table and initialize them in a loop.
[10/12] - Put R8A7740 PM domain objects into a table and initialize them in a loop.
[11/12] - Put R8A7779 PM domain objects into a table and initialize them in a loop.
[12/12] - Unexport rmobile_init_pm_domain() which may be a static function now.

The present series is on top of this patch set sent yesterday:

http://marc.info/?l=linux-pm&m4421084022735&w=4

Thanks,
Rafael

