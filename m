From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 11 Aug 2012 22:16:09 +0000
Subject: [PATCH 0/2] PM / shmobile: Streamline the cpuidle initialization and handling on sh7372 boards
Message-Id: <201208120016.10195.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

The cpuidle handling on the sh7372 boards seems to be quite convoluted,
which doesn't appear to be necessary.

The following two patches are meant to make that code more straightforward.
Please see the changelogs for details,

Thanks,
Rafael

