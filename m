From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 16 Feb 2008 19:48:24 +0000
Subject: Re: Current git very broken on the Dreamcast
Message-Id: <1203191304.6737.5.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1203187080.6737.3.camel@localhost.localdomain>
In-Reply-To: <1203187080.6737.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Paul Mundt <lethal@users.sourceforge.net>, Magnus Damm <magnus.damm@gmail.com>, matsi@igel.co.jp
Cc: LKML <linux-kernel@vger.kernel.org>


On Sat, 2008-02-16 at 18:38 +0000, Adrian McMenamin wrote:
> Will seek to bisect this, but I have just updated my sources to the
> latest git and it is not booting at all on the Dreamcast.
> 
> With early printk on, I get nothing more than this before an instant
> reboot:
> 
> [    0.000000] Linux version 2.6.25-rc2-10953-g52065cd
> (adrian@bossclass) (gcc version 3.4.6) #511 PREEMPT Sat Feb 16 18:31:43
> GMT 2008
> [    0.000000] console [sercon0] enabled
> [    0.000000] Booting machvec: Sega Dreamcast


adrian@bossclass:~/gdrom-dev$ git bisect good
e036eaa681a17f71b64f6d9040fe605555623919 is first bad commit
commit e036eaa681a17f71b64f6d9040fe605555623919
Author: Magnus Damm <magnus.damm@gmail.com>
Date:   Thu Feb 14 13:52:43 2008 +0900

    sh: use ctrl_in/out for on chip pci access
    
    This patch makes sure ctrl_inN/outN are used instead of inN/outN for
on chip
    pci registers. Without this patch addresses may be adjusted using
the value
    in generic_io_base. This patch makes it possible to set
generic_io_base and
    have pci without reading and writing all over the place.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Acked-by: Katsuya MATSUBARA <matsu@igel.co.jp>
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

:040000 040000 17a9f8181301e3a082d8a1a2fdef9b13ff1185e4
87e4a2e912be56b0d12e8a92db9489d6615c31f7 M      arch


I'll now try reverting this and seeing what happens....


Adrian

