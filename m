From: Martin Townsend <mtownsend1973@gmail.com>
Date: Sat, 17 Sep 2016 19:01:51 +0000
Subject: SH7760 OHCI
Message-Id: <CABatt_xKQzK341eW9D4jwPu6qv7yv5bsa+w4xbusfqTyJcBt4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

A while back I was having problems with get the USB Host driver
working for the SH7760.  I have fixed this problem, it was down to the
roothub.a register.  So now the OHCI HCD tries to communicate with the
host controller on the SH7760 but now there are memory issues.

The SH7760 has 8KB of shared memory that the CPU and Host controller
must use.  The HCCA must occupy the first 256 bytes so we don't even
have 2 full page worth.  Then to make matters worse there's an errata
in the SH7760 hardware manual meaning the last 4 bytes of each page
cannot be used.

Anyway I tried declaring this region as DMA coherent memory for the
OHCI device driver but as you can guess it failed when trying to alloc
a new page for a TD after successfully allocating the only page
available for the first ED.

Although I can see a way of hacking a memory manager over the shared
memory region and then putting some ugly hacks in the OHCI code to use
it I would really like to get this in mainline so I wondered if anyone
has any ideas how I can make this shared memory work with the current
OHCI implementation before I do so.

Many Thanks,
Martin.
