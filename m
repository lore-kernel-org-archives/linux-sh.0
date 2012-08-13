From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 13 Aug 2012 22:40:55 +0000
Subject: [Demo/RFC][PATCH 0/2] ARM: shmobile: PM domain with cpuidle on Mackerel
Message-Id: <201208140040.55978.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I normally don't post demo patches, but in this particular case it would be
quite difficult to implement the desired functionality on the actual hardware,
due to some complicated dependencies present in there.

The first of the following two patches adds a software-only "device" to the
Mackerel configuration and a driver for it allowing it to be turned "off"
and "on" on demand from user space, via sysfs (the device is initially "on").
This is just a variant of the very simple code I used during my LinuxCon Japan
presentation earlier this way.

The second patch adds a PM domain object and makes the "fake" device added
by the previous patch belong to it.  At the same time, it uses the mechanism
introduced by commit cbc9ef0 (PM / Domains: Add preliminary support for
cpuidle, v2) to connect cpuidle state 3 to that PM domain.  This way, cpuidle
state 3 is not used initially until the "fake" device is turned "off" via
sysfs (which makes the A3SM domain to be turned "off" and enable cpuidle state
3).  Then, if the "fake" device is turned "on" via sysfs (which makes the A3SM
domain turn "on") cpuidle state 3 is disabled and state 2 becomes the deepest
one available.

The patches in this series are on top of the current linux-next branch of the
linux-pm.git tree with the following patches applied:

https://patchwork.kernel.org/patch/1303111/
https://patchwork.kernel.org/patch/1309171/
https://patchwork.kernel.org/patch/1309151/
https://patchwork.kernel.org/patch/1312431/
https://patchwork.kernel.org/patch/1312421/
https://patchwork.kernel.org/patch/1317311/
https://patchwork.kernel.org/patch/1317271/
https://patchwork.kernel.org/patch/1317251/

Thanks,
Rafael

