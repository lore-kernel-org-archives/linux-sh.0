From: Tejun Heo <tj@kernel.org>
Date: Tue, 28 May 2013 11:58:11 +0000
Subject: Re: [PATCH 0/3] Optimize R-Car SATA driver
Message-Id: <20130528115811.GA31529@mtj.dyndns.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201305280238.17867.sergei.shtylyov@cogentembedded.com>
 <20130528002047.GA18531@mtj.dyndns.org>
 <51A49AA9.2070002@cogentembedded.com>
In-Reply-To: <51A49AA9.2070002@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, May 28, 2013 at 03:53:13PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 28-05-2013 4:20, Tejun Heo wrote:
> 
> >>    Here's the set of 3 patches against the Tejun Heo's 'libata.git' repo's
> >>'for-3.11' branch.
> >>    They deal with some shortcomings in the R-Car SATA driver and generally
> >>optimize it. I've come up with them while trying to add NCQ support to this
> >>driver.
> 
> >>[1/3] sata_rcar: kill superfluous code in sata_rcar_bmdma_fill_sg()
> >>[2/3] sata_rcar: correct 'sata_rcar_sht'
> >>[3/3] sata_rcar: add 'base' local variable to some functions
> 
> >Applied to libata/for-3.11.
> 
>    Again, I don't see these commits on git.kernel.org thru cgit...

Still traveling.  Just pushed out.  :)

-- 
tejun
