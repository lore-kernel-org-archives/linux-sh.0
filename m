From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Mon, 23 Jun 2014 20:40:36 +0000
Subject: Re: [PATCH v4 1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
Message-Id: <20140623204036.GA12793@obsidianresearch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201406210034.57784.sergei.shtylyov@cogentembedded.com>
 <4637423.jWRbL1GbCK@wuerfel> <53A4A0E5.50904@cogentembedded.com>
 <4490558.0d3xbrzEgW@wuerfel> <53A4A6C6.9000703@cogentembedded.com>
In-Reply-To: <53A4A6C6.9000703@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


> >>     Hm, are you sure about that? I thought only PCI devices should have it...
> 
> >Yes, pretty sure it's needed in both the host controller and the
> >devices.
> 
>     I don't understand the case of the PCI devices, honestly.
> Shouldn't the "device_type" prop reflect the device's functionality
> rather than the bus where it's located?

It is confusingly named, but it is required on the host bridge OF node.

The spec says ' .. corresponding to a device that implements a PCI bus',
which includes the host bridge.

The key element is that it must be present on the node that introduces
the PCI 3 dword address encoding scheme, and then on all nodes below
it that use the 3 dword scheme.

Otherwise Linux common OF PCI code does not work properly.

Jason
