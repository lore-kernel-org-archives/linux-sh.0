From: Daniel Palmer <me@danielpalmer.co.uk>
Date: Wed, 30 Mar 2011 07:37:41 +0000
Subject: Re: [PATCH 2/2] sh: Add sh_io_port_base check in __ioport_map function
Message-Id: <4D92DDC5.8030104@danielpalmer.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1301200307-5321-2-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1301200307-5321-2-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Small update..


>> All PCI seems to be broken in 2.6.38.
>> Loading 8139cp for the ethernet controller makes the board hang.
>>
>>      

I said that all PCI seems to be broken. I don't think that this was the 
issue..
I was using the SLOB allocator in my kernel and it was causing issues. 
Like plugging in a USB device would lock the machine.
This problem seems to be only for PCI devices that use IO ports.. on the 
Landisk that is just pata-artop.

I'm not an expert on PCI but I gather there are IO port devices and 
memory mapped ones?
On the USL-5P everything is memory mapped (The USB controller etc) so 
it's not an issue.

pata-artop is reading bytes from around 0x1400 in the PCI address space 
I guess, and to the CPU that address space starts
at 0xfe240000. So ioremap should map any PCI IO port accesses to address 
+ 0xfe240000.



