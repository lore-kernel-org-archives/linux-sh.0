From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 10 Jul 2011 20:46:04 +0000
Subject: [PATCH 0/2] PM / Domains: Add code for powering off all unused PM domains
Message-Id: <201107102246.05107.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>

Hi,

The following two patches are on top of the branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-domains

and the patchset I sent earlier today:

https://lkml.org/lkml/2011/7/10/27

and this patch: https://patchwork.kernel.org/patch/961202/

They introduce a mechanism allowing platforms to power off all of the PM
domains that don't contain devices in use in one shot.  The first patch
adds core support for that and the second one makes shmobile use it
instead of its own code.

Thanks,
Rafael

