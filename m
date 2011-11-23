From: Federico Fuga <fuga@studiofuga.com>
Date: Wed, 23 Nov 2011 11:01:28 +0000
Subject: Re: SH2a Write-back cache issue
Message-Id: <B0F988EE-E01B-4ADC-AA82-09D1C789B3B1@studiofuga.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201111221415.22367.andrea.baldini@spesonline.com>
In-Reply-To: <201111221415.22367.andrea.baldini@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Andrea,

I've been working with Fabio on a similar issue.

Il giorno 23/nov/2011, alle ore 11.52, Andrea Baldini ha scritto:
> I have just successfully booted the lastest git kernel (thanks to Phil for the 
> ioread/iowrite big endian fix) but it seems that the write back cache problem 
> occurs in the 3.2.0-rc2 too.

In our setup, the problem seems related to an LCD flickering, when the cache is setup in read-back mode we had an heavy flickering on the LCD, when in write-through it seems much less present, even though not completely absent. 
We tried many different setup for cache and DRAM, but found no solutions for it.
Of course the problem is present in 2.6.17, 2.6.37-38, 3.0 and 3.1 kernels.
We found just one situation where the flickering is nearly invisible, while reserving 2Mb of frame buffer - so placing the fb and the other kernel/code memory far each other.
What is your problem and setup?

Federico




