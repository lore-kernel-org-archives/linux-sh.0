From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 21 Jul 2012 21:49:17 +0000
Subject: [RFC][PATCH 0/5] PM / shmobile: Specify PM domain and device latency information directly
Message-Id: <201207212349.18294.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-sh list <linux-sh@vger.kernel.org>, Olof Johansson <olof@lixom.net>

Hi all,

The following patchset is on top of the previous one at:

https://lkml.org/lkml/2012/7/16/399

Generally speaking, it adds code for the direct specification of various
PM domain and device latencies used by PM QoS to the SH7372 SoC and
Mackerel board and suggests a mechanism for reading that information from
device trees.

Thanks,
Rafael
