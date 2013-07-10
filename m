From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 01:13:28 +0000
Subject: Re: [PATCH 02/04] ARM: shmobile: Use pm-rmobile on sh7372 and r8a7740 only
Message-Id: <20130710011327.GM32603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130709103944.1891.67462.sendpatchset@w520>
 <20130709104001.1891.16375.sendpatchset@w520>
In-Reply-To: <20130709104001.1891.16375.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 09, 2013 at 07:40:01PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The functions in pm-rmobile.c are only used on sh7372 and
> r8a7740, so adjust the Makefile to only link in that file
> in case those SoCs are selected.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.12 in the cleanup branch.
It should appear in renesas-next-20130710
