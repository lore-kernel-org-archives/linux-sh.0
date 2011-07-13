From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 13 Jul 2011 21:52:59 +0000
Subject: [PATCH 0/3] PM / Domains / shmobile fixes
Message-Id: <201107132352.59801.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi,

The following three patches fix a couple of issues in the code currently
in my pm-domains branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-domains

[1/3] - Use genpd_queue_power_off_work() for queuing up the powering off
        of A4LC (this avoids attempting to queue up a work item while it is
        pending).

[2/3] - Make the generic PM domains code react to -EBUSY returned from a
        PM domain's .power_down() callback (needed for [3/3]).

[3/3] - Return -EBUSY from the A4LC's .power_down() callback to indicate that
        the domain hasn't been powered down on purpose and remove the confusing
        (and now redundant) pm_genpd_poweron(A4LC) from pd_power_down_a3rv().

Thanks,
Rafael
