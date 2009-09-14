From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 14 Sep 2009 13:14:12 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <20090914131411.GA4895@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 14, 2009 at 08:02:16AM -0500, Dale Larson wrote:
> Matt,
> 
> I've built and run the latest code in the 'sh/cachetlb' branch od
> 'git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git' and
> I get many more fixup messages starting with 'swapper':
> 
> [    0.296000] NET: Registered protocol family 17
> [    0.300000] RPC: Registered udp transport module.
> [    0.304000] RPC: Registered tcp transport module.
> [    0.820000] net eth0: attached phy 1 to driver Generic PHY
> [    1.828000] Sending DHCP requests ..
> [    6.136000] Unaligned kernel access on behalf of "swapper" pid=0
> pc=0x881d409a ins=0x8810
> [    6.136000] Fixing up unaligned kernel access in "swapper" pid=0
> pc=0x881d409a ins=0x6732
> [    6.144000] Unaligned kernel access on behalf of "swapper" pid=0
> pc=0x881d40e2 ins=0x881a
> [    6.144000] Fixing up unaligned kernel access in "swapper" pid=0
> pc=0x881d40e2 ins=0x6126
> [    6.152000] Unaligned kernel access on behalf of "swapper" pid=0
> pc=0x881d40e4 ins=0x881a
> [    6.152000] Fixing up unaligned kernel access in "swapper" pid=0
> pc=0x881d40e4 ins=0x6726
> [    6.160000] Unaligned kernel access on behalf of "swapper" pid=0
> pc=0x881d40ee ins=0x881a
> [    6.160000] Fixing up unaligned kernel access in "swapper" pid=0
> pc=0x881d40ee ins=0x6726
> [    6.164000] Unaligned kernel access on behalf of "swapper" pid=0
> pc=0x881d40ee ins=0x881a
> [    6.164000] Fixing up unaligned kernel access in "swapper" pid=0
> pc=0x881d40ee ins=0x6726
> [    6.168000] Unaligned kernel access on behalf of "swapper" pid=0
> pc=0x881d40ee ins=0x881a
> 

Hmm... confusing. Can you send your .config too, please? Is your copy of
the sh/cachetlb branch up to date? There was an issue a few weeks ago
where we were unneccessarily reporting unaligned fix ups. It was fixed
by this commit,


commit 4aa5ac4ef44dd8c986241c54298abd7910b78b3f
Author: Matt Fleming <matt@console-pimps.org>
Date:   Fri Aug 28 21:37:20 2009 +0000

    sh: Only shout about fixing up unexpected unaligned accesses

    Some unaligned accesses are completely expected. For example, the
    trapped_io code uses the unaligned access fixup code path so there's no
    need to warn about having to fixup the unaligned access.

    Signed-off-by: Matt Fleming <matt@console-pimps.org>
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>


Is this commit in your tree?
