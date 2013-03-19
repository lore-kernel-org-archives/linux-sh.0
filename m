From: Simon Horman <horms@verge.net.au>
Date: Tue, 19 Mar 2013 03:11:03 +0000
Subject: Re: [PATCH 00/04] ARM: shmobile: TWD update
Message-Id: <20130319031100.GA16504@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130306002214.5430.43766.sendpatchset@w520>
 <20130306015121.GE20819@verge.net.au>
In-Reply-To: <20130306015121.GE20819@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Mar 06, 2013 at 10:51:22AM +0900, Simon Horman wrote:
> On Wed, Mar 06, 2013 at 09:22:14AM +0900, Magnus Damm wrote:
> > ARM: shmobile: TWD update 
> > [PATCH 01/04] ARM: shmobile: Register DT TWD from timer.c 
> > [PATCH 02/04] ARM: shmobile: Add EMEV2 specific timer_init
> > [PATCH 03/04] ARM: shmobile: Add EMEV2 TWD support
> > [PATCH 04/04] ARM: shmobile: Remove r8a7779_register_twd() from common.
> > 
> > These patches are the first attempt to update the state of
> > mach-shmobile TWD support. Patch 01/04 adds shared mach-shmobile
> > code to allow TWD support via DT, patch 02/04 and 03/04 add TWD
> > support to EMEV2 and the KZM9D board. Finally patch 04/04 removes
> > unnecessary forward declaration.
> 
> Hi Magnus,
> 
> these seem fine to me. Let me know when they have stabilised.

Ping.
