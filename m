From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 30 Sep 2018 07:32:41 +0000
Subject: Re: [PATCH qemu v2] hw/char/sh_serial: Add timeout handling to unbreak serial input
Message-Id: <0b6ca250-056a-baab-bc1d-3dfc603487ff@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180905131125.12635-1-geert+renesas@glider.be>
 <76422049-ffe3-d4a9-6dcb-8edf05a8e200@redhat.com>
 <CAMuHMdU+tV0K1iFTKVZmFbV6aY2jqX96XUJqJGEEup-R5SUqeQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU+tV0K1iFTKVZmFbV6aY2jqX96XUJqJGEEup-R5SUqeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>, uli@fpond.eu, Rob Landley <rob@landley.net>, Rich Felker <dalias@libc.org>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 28/09/2018 14:36, Geert Uytterhoeven wrote:
> Hi Paolo,
> 
> On Tue, Sep 11, 2018 at 3:11 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 05/09/2018 15:11, Geert Uytterhoeven wrote:
>>> As of commit 18e8cf159177100e ("serial: sh-sci: increase RX FIFO trigger
>>> defaults for (H)SCIF") in Linux v4.11-rc1, the serial console on the
>>> QEMU SH4 target is broken: it delays serial input until enough data has
>>> been received.
>>>
>>> Since aforementioned commit, the Linux SCIF driver programs the Receive
>>> FIFO Data Count Trigger bits in the FIFO Control Register, to postpone
>>> generating a receive interrupt until:
>>>   1. At least the receive trigger count of bytes of data are available
>>>      in the receive FIFO, OR
>>>   2. No further data has been received for at least 15 etu after the
>>>      last received data.
>>>
>>> While QEMU implements the former, it does not implement the latter.
>>> Hence the receive interrupt is not generated until the former condition
>>> is met.
>>>
>>> Fix this by adding basic timeout handling.  As the QEMU SCIF emulation
>>> ignores any serial speed programming, the timeout value used conforms to
>>> a default speed of 9600 bps, which is fine for any interactive console.
>>>
>>> Reported-by: Rob Landley <rob@landley.net>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Tested-by: Ulrich Hecht <uli@fpond.eu>
>>> Tested-by: Rob Landley <rob@landley.net>
>>> Tested-by: Rich Felker <dalias@libc.org>
> 
>> Queued, thanks.
> 
> Does that mean it should show up in qemu.git anytime soon?

Yes, I'm testing the pull request now.  (I went to Kernel Recipes and
forgot at home my ssh private key, otherwise I'd have sent it last week!)

Paolo
