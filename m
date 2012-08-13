From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 13 Aug 2012 22:19:18 +0000
Subject: [PATCH 0/3] PM / Domains: Fixes related to cpuidle
Message-Id: <201208140019.19288.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

Hi all,

The following three patches fix some relatively minor issues and add
a bit of new functionality related to the PM domains' support for cpuidle.

[1/3] - Fix names of cpuidle-related PM domain's functions and add kerneldoc
        comments describing them.
[2/3] - Make the cpuidle ladder governor use the "disabled" state flag.
[3/3] - Make it possible to use domain names for connecting cpuidle to and
        disconnecting it from a PM domain.

The patches are on top of the current linux-next branch of the linux-pm.git tree.

Thanks,
Rafael

