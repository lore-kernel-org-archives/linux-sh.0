From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 04 Sep 2012 03:57:32 +0000
Subject: Re: pci dma addresses missing offset on sh7750
Message-Id: <CAJaTeTrOYkabN3bt6RFobi7c2yQ2RaawyxfZy6h2gYJ8UvqYCA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201208042201.58615.vapier@gentoo.org>
In-Reply-To: <201208042201.58615.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Aug 4, 2012 at 10:35 PM, Mike Frysinger wrote:
> On Saturday 04 August 2012 22:01:58 Mike Frysinger wrote:
>> i got back to looking at the landisk not working since 2.6.31.  linux-3.5
>> boots up with better information, so we can get further in figuring out
>> what went wrong.  for a recap, 99f95f117848088f2708b45c70be73152e78bb8a
>> was the last rev i could boot.
>>
>> with 2.6.30.9, i see these address ranges:
>> Autoconfig PCI channel 0x8c3543e0
>> Scanning bus 00, I/O 0xfe240000:0xfe280000, Mem 0xfd000000:0xfe000000
>> 00:00.0 Class 0200: 10ec:8139 (rev 20)
>>         I/O at 0xfe240000 [size=0x100]
>>         Mem at 0xfd000000 [size=0x100]
>> 00:01.0 Class 0180: 1191:0009 (rev 07)
>>         I/O at 0xfe240100 [size=0x8]
>>         I/O at 0xfe240108 [size=0x4]
>>         I/O at 0xfe240110 [size=0x8]
>>         I/O at 0xfe240118 [size=0x4]
>>         I/O at 0xfe240120 [size=0x10]
>> 00:02.0 Class 0c03: 1033:0035 (rev 43)
>>         Mem at 0xfd001000 [size=0x1000]
>> 00:02.1 Class 0c03: 1033:0035 (rev 43)
>>         Mem at 0xfd002000 [size=0x1000]
>> 00:02.2 Class 0c03: 1033:00e0 (rev 04)
>>         Mem at 0xfd003000 [size=0x100]
>>
>> but with 3.5, i see:
>> PCI host bridge to bus 0000:00
>> pci_bus 0000:00: root bus resource [io  0x1000-0x3fffff]
>> pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfdffffff]
>> pci 0000:00:01.0: BAR 6: assigned [mem 0xfd000000-0xfd00ffff pref]
>> pci 0000:00:02.0: BAR 0: assigned [mem 0xfd010000-0xfd010fff]
>> pci 0000:00:02.1: BAR 0: assigned [mem 0xfd011000-0xfd011fff]
>> pci 0000:00:00.0: BAR 0: assigned [io  0x1000-0x10ff]
>> pci 0000:00:00.0: BAR 1: assigned [mem 0xfd012000-0xfd0120ff]
>> pci 0000:00:02.2: BAR 0: assigned [mem 0xfd012100-0xfd0121ff]
>> pci 0000:00:01.0: BAR 4: assigned [io  0x1400-0x140f]
>> pci 0000:00:01.0: BAR 0: assigned [io  0x1410-0x1417]
>> pci 0000:00:01.0: BAR 2: assigned [io  0x1418-0x141f]
>> pci 0000:00:01.0: BAR 1: assigned [io  0x1420-0x1423]
>> pci 0000:00:01.0: BAR 3: assigned [io  0x1424-0x1427]
>>
>> notice how the dma ranges are completely in the wrong region.  any quick
>> ideas where to fix this ? :)
>
> hrm, reverting this got me further:
>
> commit e3a4317e1d9970c56ba19d29393e4289809a1aa5
> Author: Magnus Damm <damm@opensource.se>
> Date:   Thu Apr 22 06:21:10 2010 +0000
>
>     sh: sh7751 pci controller io port fix
>
> maybe the sh7751 pci/dma logic is missing some offset adjustment that the
> sh7780 core has ?
>
> btw, the display above isn't just informational ... i get an oops because the
> code tries to access memory in the 0x1400 range.

here's the ping you asked me to send you Magnus :)
-mike
