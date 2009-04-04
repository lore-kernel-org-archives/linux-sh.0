From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 04 Apr 2009 15:50:21 +0000
Subject: Re: [PATCH] sh7785lcr: Map whole address space to PCI
Message-Id: <20090404155020.GA17834@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090402180330.00319c4f.yoshii.takashi@renesas.com>
In-Reply-To: <20090402180330.00319c4f.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 02, 2009 at 06:03:30PM +0900, yoshii.takashi@renesas.com wrote:
> PCI still doesn't work on sh7785lcr 29bit 256M map mode.
> 
> On SH7785, PCI -> SHwy address translation is not base+offset but somewhat like
>  base|offset (See HW Manual (rej09b0261) Fig. 13.11).
> So, you can't export CS2,3,4,5 by 256M at CS2 (results CS0,1,2,3 exported, I guess).
> There are two candidates.
> a) 128M@CS2 + 128M@CS4
> b) 512M@CS0
> 
> Attached patch is B. It maps 512M Byte at 0 independently of memory size.
> It results CS0 to CS6 and perhaps some more being accessible from PCI.
> 
Looks ok for now, some changes might still be necessary for 32-bit mode,
but we can special-case those if any problems show up with it. Most of
this code is being reworked for 2.6.31, anyways.
