From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 07 Mar 2014 17:57:17 +0000
Subject: Re: NFS root on Koelsch reference
Message-Id: <531A1694.9060405@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
In-Reply-To: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 03/06/2014 10:24 PM, Ben Dooks wrote:

>> Now we have DT support for Ethernet on r8a7791, I struggled a bit to get NFS
>> root working on Koelsch reference.

>> While I still need "[PATCH] ARM: shmobile: compile drivers/sh for
>> CONFIG_ARCH_SHMOBILE_MULTI" to make the thermal sensor warning
>> go away, this same patch causes a kernel panic when starting userspace from
>> NFS root on Koelsch reference:

>> VFS: Mounted root (nfs filesystem) readonly on device 0:12.
>> devtmpfs: mounted
>> Freeing unused kernel memory: 204K (c042b000 - c045e000)
>> Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007

    Geert, do you have CONFIG_PM_RUNTIME in your .config?

> I am also trying to get a patch in to stop these being fatal to the
> system.

> We also need a fix for the Micrel PHY to set the LED mode on the
> Lager board. I've sent that but it seems to have stalled.

    While we're not having it, try changing "renesas,ether-link-active-low" 
prop to "renesas,no-ether-link" in the Koelsch device tree file.

WBR, Sergei

