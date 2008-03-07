From: "Adrian McMenamin" <adrian@newgolddream.dyndns.info>
Date: Fri, 07 Mar 2008 14:44:05 +0000
Subject: Re: Fixing up unaligned userspace access
Message-Id: <14961.85.118.17.158.1204901045.squirrel@newgolddream.dyndns.info>
List-Id: <linux-sh.vger.kernel.org>
References: <1204900215.12315.174.camel@atlas.mpc-data.co.uk>
In-Reply-To: <1204900215.12315.174.camel@atlas.mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, March 7, 2008 2:30 pm, Kieran Bingham wrote:
> Hi guys,
>
> I'm getting confused about how the unaligned accesses are being handled
> in SH2/SH2a.
>
> Our busybox build and userland seems to be causing these exceptions far
> too often.
>
> For example, pressing "Tab" to tab complete a filename, causes these two
> exceptions to fire, and then soon after the whole board stalls.
>
>
>
> Fixing up unaligned userspace access in "sh" pidH pc=0x0ccda168
> ins=0x60f0
>
> Fixing up unaligned userspace access in "sh" pidH pc=0x0ccd9eac
> ins=0x9015
>
>
>
> Mainly I'm confused though, as looking at the assembly the instructions
> aren't unaligned ? and don't seem to be trying to do anything
> un-aligned ? - Is there something else that could be going on here?
>

My experience - admittedly with SH4 - is that these errors are almost
always caused by a memory leak, or access to unitialised memory, elsewhere
in the kernel.



