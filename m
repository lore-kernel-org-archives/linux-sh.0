From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 05 Sep 2011 05:46:10 +0000
Subject: Re: [PATCH 00/03] ARM: mach-shmobile: sh7372 power domain update
Message-Id: <20110905054610.GH22142@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110630094653.10442.68817.sendpatchset@t400s>
In-Reply-To: <20110630094653.10442.68817.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 26, 2011 at 03:43:16PM +0900, Magnus Damm wrote:
> ARM: mach-shmobile: sh7372 power domain update
> 
> [PATCH 01/03] ARM: mach-shmobile: sh7372 A3SM support
> [PATCH 02/03] ARM: mach-shmobile: sh7372 A3SP support
> [PATCH 03/03] ARM: mach-shmobile: sh7372 A4R support
> 
> These patches add support for the A3SM, A3SP and A4R
> power domains included in the sh7372 SoC. More work
> in needed with QoS for I/O devices and CPUIdle with
> A3SM together with future A4S power domain support.
> 
> Testing needed, especiall WRT to Suspend-to-RAM!
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

As these don't apply against anything I have I'll assume that Rafael will
be taking them through the pm tree with the rest of the power domains
code.
