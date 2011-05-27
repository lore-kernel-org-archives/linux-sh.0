From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 27 May 2011 23:15:14 +0000
Subject: [PATCH 0/5] PM: Support for generic I/O power domains (v4)
Message-Id: <201105280115.14556.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201104290154.12966.rjw@sisk.pl> <201105082320.57185.rjw@sisk.pl> <201105160117.46927.rjw@sisk.pl>
In-Reply-To: <201105160117.46927.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Alan Stern <stern@rowland.harvard.edu>

Hi,

This is the third update of the patchset adding support for generic I/O power
domains. All patches were posted previously, but I needed to rebase shmobile
patches on top of the current mainline kernel.

From my perspective, the patches are ready for merging and I'm going put
patches [1-4/5] into my power-domains branch for 2.6.41 (or whatever it turns
out to be) after 2.6.40-rc1 (or whatever it is going to be called) is out.
Patch [5/5] is optional.

The entire patchset has been tested with an ARM shmobile Mackerel board.

[1/5] - Support for generic I/O power domains (runtime PM part).
[2/5] - Support for generic I/O power domains (system sleep part).
[3/5] - Implementation of generic I/O power domains support for SH7372.
[4/5] - [RFC] Support of multiple power domain states.
[5/5] - Introduction of SH7372's A4MP power domain.

Thanks,
Rafael

