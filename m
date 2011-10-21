From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 21 Oct 2011 23:09:52 +0000
Subject: [RFC][PATCH 0/2] PM: Generic PM domains and device PM QoS (v2)
Message-Id: <201110220109.52991.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Magnus Damm <magnus.damm@gmail.com>

Hi,

This patchset is a refresh of patches introducing simple PM QoS governor
functions for PM domains.  The patches still haven't been tested properly,
although they should build.  The purpose of them is mainly to illustrate
how PM QoS may be used with PM domains to control device runtime PM.

Thanks,
Rafael

