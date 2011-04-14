From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 14 Apr 2011 23:16:01 +0000
Subject: [RFC][PATCH 0/2] Remove __weak definitions of platform PM callbacks
Message-Id: <201104150116.01634.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201104130205.26988.rjw@sisk.pl>
In-Reply-To: <201104130205.26988.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Kevin Hilman <khilman@ti.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Len Brown <lenb@kernel.org>, linux-sh@vger.kernel.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>

Hi,

The following two patches are based on top of
https://patchwork.kernel.org/patch/702401/ .

[1/2] converts shmobile (both the ARM and SH flavors) to using a power domain
for overriding the platform bus type's PM callbacks, which makes it possible
to remove the __weak definitions of the runtime PM callbacks from platform.c,
which is done in [2/2].

Comments welcome.

Thanks,
Rafael

