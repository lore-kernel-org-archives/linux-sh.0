From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 13 Aug 2012 12:32:43 +0000
Subject: [PATCH 0/2] PM / shmobile: Rework adding devices to PM domains on SH7372 boards
Message-Id: <201208131432.43768.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On SH7372 boards devices are added to PM domains through a series of
rmobile_add_device_to_domain_td() or rmobile_add_device_to_domain() calls
which is quite inefficient.  The following two patches change that the
domain-device pairs information is stored in tables and fed to a separate
initialization function.

Thanks,
Rafael
