From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 08 Aug 2011 22:28:12 +0000
Subject: [PATCH 0/4] PM: Make power.subsys_data be more useful
Message-Id: <201108090028.12698.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Greg KH <gregkh@suse.de>

Hi,

The following patchset reworks the power.subsys_data field of
struct device so that it can be used not only for clock PM
management.

[1/4] - Introduce struct pm_subsys_data to be point to by power.subsys_data.
[2/4] - Add reference counting for power.subsys_data.
[3/4] - Optimize generic PM domains code by making it use power.subsys_data.
[4/4] - Move PM clock management headers and definitions to a separate file.

The patchset is on top of the pm-domains branch of the linux-pm tree at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-domains

It has been tested on an ARM shmobile Mackerel board.

Thanks,
Rafael
