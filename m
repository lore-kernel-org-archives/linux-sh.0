From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 09 Jan 2014 12:30:57 +0000
Subject: Re: lager - non-booting latest horms' devel branch
Message-Id: <52CE9681.3060700@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <52CE8BC0.7060306@codethink.co.uk>
In-Reply-To: <52CE8BC0.7060306@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/01/14 12:21, Geert Uytterhoeven wrote:
> Hi Ben,
>
> On Thu, Jan 9, 2014 at 12:45 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> I am using the devel branch from Simon Horms' git tree, SHA1
>> 3da593ea7d797d9f59bd6ed1ee629fab681d7a23 and not seeing a
>> boot when using the multi arch defconfig and device-tree.
>>
>> The board does not produce any console output so I am not
>> sure what is going on. Has anyone else had issues with using
>> the fdt-only boot?
>
> I'm using Koelsch (not Lager), but usually the non-reference version as I
> need Ethernet for NFS root.
> The DT-version does boot for me until mounting root.
>
> Are you using an initramfs? I noticed the kernel crashes early when using
> a non-trivial initramfs:

No, we're just tftping and then nfs-root.

>      Error: unrecognized/unsupported machine ID (r1 = 0x41915083).
>
>      Available machine support:
>
>      ID (hex)        NAME
>      ffffffff        Generic R8A7791 (Flattened Device Tree)
>      ffffffff        koelsch
>
>      Please check your kernel config and/or bootloader.
>
> Apparently the device tree gets overwritten in memory. I tried loading the
> DTB at a different address, but that didn't help. I didn't have more time
> to investigate, though.

I've managed to get it to boot with another boot method, however that 
has other limitations...

>
> FYI, I'm using the following patch to capture early kernel messages in RAM.
> After a reset, look up the addres of big_buffer[] in System.map, and
> inspect it from U-Boot to retrieve the messages (translate from 0xc0000000
> to 0x40000000).

Ta, that's a useful thing to have

i am considering it may be a dtc compiler bug or some other issue with
the device-tree.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
