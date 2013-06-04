From: Simon Horman <horms@verge.net.au>
Date: Tue, 04 Jun 2013 13:18:30 +0000
Subject: Re: drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly truncated to unsigned type
Message-Id: <20130604131830.GD3068@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <51a59c1b.AMyrU/XAl1VcZ02t%fengguang.wu@intel.com>
 <20130529072447.GC12650@localhost>
 <20130604014521.GN23054@verge.net.au>
 <51ADBBE0.2020408@cogentembedded.com>
In-Reply-To: <51ADBBE0.2020408@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, kbuild-all@01.org, Tejun Heo <tj@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, linux-ide@vger.kernel.org, Vladimir Barinov <vladimir.barinov@cogentembedded.com>

On Tue, Jun 04, 2013 at 02:05:20PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 04-06-2013 5:45, Simon Horman wrote:
> 
> >could you look into a fix for this?
> 
> >I believe that it is a result of my patch "libata: do not limit R-Car SATA
> >driver to shmobile", which now allows the R-Car SATA driver to be compiled
> >for a (much) wider range of hardware.
> 
>   It is a result of compiling with gcc 4.8. As Tejun wrote, the
> warning has been already fixed and the fix queued in his tree.

Thanks and sorry for the noise.
