From: Simon Horman <horms@verge.net.au>
Date: Fri, 07 Mar 2014 01:48:48 +0000
Subject: Re: [PATCH 01/02] ARM: shmobile: Add shared shmobile_init_delay()
Message-Id: <20140307014844.GE11702@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140306032814.10814.2949.sendpatchset@w520>
 <20140306032824.10814.21953.sendpatchset@w520>
 <20140307000003.GB24411@verge.net.au>
In-Reply-To: <20140307000003.GB24411@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Mar 07, 2014 at 09:00:06AM +0900, Simon Horman wrote:
> On Thu, Mar 06, 2014 at 12:28:24PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Introduce shmobile_init_delay() that gets CPU specific
> > parameters from DT and sets up the early delay from
> > there. This allows us to both remove frequency information
> > from the C code and consolidate existing code.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Hi Magnus,
> 
> I am holding off on this one until the rest of the series is finalised.

After some discussion off-list I have queued this up.
