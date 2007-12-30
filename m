From: David Miller <davem@davemloft.net>
Date: Sun, 30 Dec 2007 02:55:01 +0000
Subject: Re: NFS root failing
Message-Id: <20071229.185501.146899859.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1198940473.6278.20.camel@localhost.localdomain>
In-Reply-To: <1198940473.6278.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 29 Dec 2007 15:01:13 +0000

> I've been getting nowhere with it for a few days now: I had this (NFS
> root) working very well until earlier this week when I upgraded the
> Busybox config on target system. Now it fails - any experts able to
> help?

This patch should fix it, I'll be pushing it to Linus shortly.

[IPV4] Fix ip=dhcp regression

David Brownell pointed out a regression in my recent "Fix ip command
line processing" patch. It turns out to be a fairly blatant oversight on
my part whereby ic_enable is never set, and thus autoconfiguration is
never enabled. Clearly my testing was broken :-(

The solution that I have is to set ic_enable to 1 if we hit
ip_auto_config_setup(), which basically means that autoconfiguration is
activated unless told otherwise. I then flip ic_enable to 0 if ip=off,
ip=none, ip=::::::off or ip=::::::none using ic_proto_name();

The incremental patch is below, let me know if a non-incremental version
is prepared, as I did as for the original patch to be reverted pending a
fix.

Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/ipv4/ipconfig.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 420f56a..56a6757 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1440,6 +1440,7 @@ static int __init ip_auto_config_setup(char *addrs)
 	int num = 0;
 
 	ic_set_manually = 1;
+	ic_enable = 1;
 
 	if (ic_proto_name(addrs))
 		return 1;
-- 
1.5.4.rc2

