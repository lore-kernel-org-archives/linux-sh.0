From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 29 Jul 2012 14:12:42 +0000
Subject: [RFC][PATCH 0/6] PM: Suspend/resume for clock sources/clock event devices in PM domains
Message-Id: <201207291612.43138.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>

Hi all,

There is a problem with clock sources and clock event devices belonging to PM
domains that they have to be marked as "always on", to prevent those domains
from being turned off unexpectedly, which also prevents the domains from
being turned off during system suspend, although that might be done and would
be desirable.

The following patch series introduces a mechanism by which the generic PM
domains framework can be notified that a given domain may be turned off
after timekeeping has been suspended, which allows the domains that contain
clock sources and clock event devices to be turned off before the system
enters the target sleep state (so that less power is used in that state).

[1/6] Introduce simplified power on routine for PM domains (to be used during
      system resume from suspend/hibernation and during "syscore" resume).
[2/6] Introduce function for notifying the generic PM domains framework that
      the given device may be treated as suspended (so its domain may be
      turned off if this has been the last active device in it).
[3/6] Introduce suspend/resume callbacks for clock event devices.
[4/6] Make the SH TMU driver use suspend/resume callbacks for clock sources
      and clock event devices to notify the generic PM domains framework that
      those devices may be regarded as suspended (during system suspend) or
      that they have to be turned on immediately (during system resume).
[5/6] Like [4/6] but for the SH CMT driver.
[6/6] Analogous to [4/6], but for the SH MTU2 driver.

The patchset has been tested on the SH7372 Mackerel board.

Thanks,
Rafael
