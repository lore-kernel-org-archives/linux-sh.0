From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 07 Aug 2012 22:26:01 +0000
Subject: [PATCH 0/4] PM / shmobile: Specify PM domain and device latency information directly
Message-Id: <201208080026.01738.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207212349.18294.rjw@sisk.pl>
In-Reply-To: <201207212349.18294.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

Hi all,

On Saturday, July 21, 2012, Rafael J. Wysocki wrote:
> Hi all,
> 
> The following patchset is on top of the previous one at:
> 
> https://lkml.org/lkml/2012/7/16/399
> 
> Generally speaking, it adds code for the direct specification of various
> PM domain and device latencies used by PM QoS to the SH7372 SoC and
> Mackerel board and suggests a mechanism for reading that information from
> device trees.

Since I haven't received any comments, I suppose everyone is OK with these
patches, except for the DT one that depended on another DT patch that was
rejected.  Thus, a regular (non-RFC) submission follows.

The patches are on top of this patch series posted yesterday:

http://marc.info/?l=linux-pm&m4429494917435&w=4

Thanks,
Rafael

