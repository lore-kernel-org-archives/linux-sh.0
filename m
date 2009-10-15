From: Valentin R Sitsikov <valentin.sitdikov@siemens.com>
Date: Thu, 15 Oct 2009 11:26:10 +0000
Subject: Re: [PATCH] sh: sh7785lcr: add possibility of using 128MB pci window
Message-Id: <4AD706D2.8060901@siemens.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4ACDB6B8.9090808@siemens.com>
In-Reply-To: <4ACDB6B8.9090808@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Paul.

Don`t you mind if we return to the discussions about 128MB window for Pci.

I have a feeling what i missed something or may be misunderstood.
My ideas right now are:
1. It is really necessary to have 128MB pci window in my case. (we have 
a pci card plugged in with 64MB).
2. Pci window of such size (512MB) can start only form 0xc0000000 
(physical address)
3. There are two possiblity to map such phys. address to the kernel 
virtual address:
	3.1. Using PMB to P1/P2 areas only .
	3.2. By using general TLB mmaping to  P3 area. (4K or 8K page`s    are 
inefficient from my point of view).
4. vmalloc are starts somewhere in P3. We need to bump it somehow if use 
3.2.
5. In any case it can be done only in 32-bit mode.
6. The current solution I have implemented uses PMB approach.
	0xb8000000 (P2), 128 MB <- 0xc0000000 (phys), 128MB.
7. I need no more than 128MB right now.

So what is you suggestion which approach i can use right now 3.1. or 3.2.?
Please correct me if i am wrong somewhere.

Best regards,
Valentin.
Paul Mundt wrote:
> On Thu, Oct 08, 2009 at 01:54:00PM +0400, Valentin R Sitsikov wrote:
>   
>> Only pci may start now from 0xC0000000-phys:0xb8000000-virtual.
>> All other mapping is the same as without using PMB. 	
>>
>> Signed-off-by: Valentin Sitdikov <valentin.sitdikov@siemens.com>
>>     
>
> No, we are not going to add any ifdefs to vary the size of the PCI memory
> window. A lot of hard work went in to throwing away all of this ifdef
> configuration crap in the first place, and the last thing we want to do
> is reinstate more of it. We do not have enough address space with or
> without the PMB to make varying configurations realistic.
>
> Having said that, I think 128MB is a fine default, given that presently
> we are completely starved for vmalloc space due to the mindless
> assignment of PCI memory to that region. As such, perhaps the easiest
> thing to do is simply to scale the window size back to 128MB as a maximum
> and bump vmalloc space after that (or even 64MB for PCI memory would
> probably be fine).
>
> If anyone wants to map more PCI memory than that, they are not going to
> be able to use the legacy P1/P2 mappings. We would be better off throwing
> out P2 completely and giving it over to sparsemem vmemmap to actually do
> something useful with anyways.
>   


