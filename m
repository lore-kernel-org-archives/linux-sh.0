From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 20 Jan 2014 12:53:44 +0000
Subject: Re: usb0 failure
Message-Id: <52DD1C58.3040706@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <52DD1B80.8090607@codethink.co.uk>
In-Reply-To: <52DD1B80.8090607@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 20/01/14 12:50, Ben Dooks wrote:
> I'm working with Simon's tree from 9th Jan with Valentin's patches
> as well as my own for FDT support and seeing the following failure
> for OHCI on channel0 failing to start. The other two channels are
> working fine.

I failed to mention that I was interested if anyone had seen the
following error before. I /think/ it may be a bridge initialisation
error as I've seen it on another architecture with badly configured
security.

> The OHCI for channel 0 initialising:
>
>> ohci-pci 0000:00:01.0: enabling bus mastering
>> ohci-pci 0000:00:01.0: OHCI PCI host controller
>> ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 4
>> ohci-pci 0000:00:01.0: irq 143, io mem 0xee080000
>> ohci-pci 0000:00:01.0: init err (00002edf 0000)
>> ohci-pci 0000:00:01.0: can't start
>> ohci-pci 0000:00:01.0: startup error -75
>> ohci-pci 0000:00:01.0: USB bus 4 deregistered
>> ohci-pci 0000:00:01.0: init 0000:00:01.0 fail, -75
>> ohci-pci: probe of 0000:00:01.0 failed with error -75
>
> For ref, the EHCI block for 0
>> ehci-pci 0000:01:02.0: EHCI Host Controller
>> ehci-pci 0000:01:02.0: new USB bus registered, assigned bus number 2
>> ehci-pci 0000:01:02.0: enabling Mem-Wr-Inval
>> ehci-pci 0000:01:02.0: irq 144, io mem 0xee0a1000
>> ehci-pci 0000:01:02.0: USB 2.0 started, EHCI 1.00
>
>
>


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
