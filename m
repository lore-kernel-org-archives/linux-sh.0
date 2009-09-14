From: Dale Larson <dlarson42@gmail.com>
Date: Mon, 14 Sep 2009 13:02:16 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <6e6aa1a80909140602qa31b80fh1e35f2b79b40b24a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Matt,

I've built and run the latest code in the 'sh/cachetlb' branch od
'git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git' and
I get many more fixup messages starting with 'swapper':

[    0.296000] NET: Registered protocol family 17
[    0.300000] RPC: Registered udp transport module.
[    0.304000] RPC: Registered tcp transport module.
[    0.820000] net eth0: attached phy 1 to driver Generic PHY
[    1.828000] Sending DHCP requests ..
[    6.136000] Unaligned kernel access on behalf of "swapper" pid=0
pc=0x881d409a ins=0x8810
[    6.136000] Fixing up unaligned kernel access in "swapper" pid=0
pc=0x881d409a ins=0x6732
[    6.144000] Unaligned kernel access on behalf of "swapper" pid=0
pc=0x881d40e2 ins=0x881a
[    6.144000] Fixing up unaligned kernel access in "swapper" pid=0
pc=0x881d40e2 ins=0x6126
[    6.152000] Unaligned kernel access on behalf of "swapper" pid=0
pc=0x881d40e4 ins=0x881a
[    6.152000] Fixing up unaligned kernel access in "swapper" pid=0
pc=0x881d40e4 ins=0x6726
[    6.160000] Unaligned kernel access on behalf of "swapper" pid=0
pc=0x881d40ee ins=0x881a
[    6.160000] Fixing up unaligned kernel access in "swapper" pid=0
pc=0x881d40ee ins=0x6726
[    6.164000] Unaligned kernel access on behalf of "swapper" pid=0
pc=0x881d40ee ins=0x881a
[    6.164000] Fixing up unaligned kernel access in "swapper" pid=0
pc=0x881d40ee ins=0x6726
[    6.168000] Unaligned kernel access on behalf of "swapper" pid=0
pc=0x881d40ee ins=0x881a

Dale Larson
Johnson Controls, Inc
