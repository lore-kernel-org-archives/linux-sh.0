From: Josh Boyer <jwboyer@gmail.com>
Date: Wed, 27 May 2009 20:48:34 +0000
Subject: Re: [RFC] [PATCH] Device Tree on ARM platform
Message-Id: <20090527204834.GA3095@hansolo.jdub.homelinux.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527175609.GB31861@flint.arm.linux.org.uk>
	<4A1D8FBA.6040802@freescale.com>
	<20090527192909.GA32398@flint.arm.linux.org.uk>
	<20090527.132328.78091350.davem@davemloft.net>
	<20090527202701.GA16219@game.jcrosoft.org>
In-Reply-To: <20090527202701.GA16219-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: rmk+lkml-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, yuan-bo.ye-3WKxDLwmzFNWk0Htik3J/w@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Wed, May 27, 2009 at 10:27:01PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
>On 13:23 Wed 27 May     , David Miller wrote:
>> From: Russell King <rmk+lkml@arm.linux.org.uk>
>> Date: Wed, 27 May 2009 20:29:10 +0100
>> 
>> > To program them into the hardware registers, which is not what we in
>> > the ARM community say, but it's what the _network_ guys tell people
>> > they should be doing.
>> > 
>> > I've suggested in the past having a standard kernel parameter such
>> > that you can specify a mac address on a per-device basis in a totally
>> > platform independent way, but the network folk don't like that idea.
>> 
>> As a "network guy" I can tell you that when the system firmware
>> provides a system-wide or device specific MAC address in it's device
>> tree, that is what you should use.
>> 
>> And that's what I've been doing on sparc FOR 15 YEARS.
>> 
>> Device trees are the only systematic generic mechanism for
>> describing device layouts on the myriad of embedded boards
>> out there which you will ever find.
>> 
>> Two platforms, and now a third, have been using this scheme
>> over a very proven period of time.  It's not a hack, there is
>> infrastructure to get the boot loaders to do the right thing,
>> and only ARM seems to resist it. :-)
>The SH, avr32, mips, x86 does not support it too IIRC

x86 has a variant.  The OLPC uses OF.

josh
