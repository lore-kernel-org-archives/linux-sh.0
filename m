From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Mar 2010 12:32:29 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <aec7e5c31003160532x329513e6v447650da3bb91d12@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Fabio,

On Tue, Mar 16, 2010 at 8:59 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Thanks a lot, but 2 questions.
> 1)I'm using linux2.6.16-ucinux-7203; with the oscilloscope i can se that after
> chip reset by the driver the irq line is driven low and stays always low. I
> think the is not proper because this means that never the chip irq state flag
> is erased

Why are you using such an old kernel? It's more than 3 years old!!!

> 2) I have a 32 bus connected sh2a D0 do smc9118 D0 and sh2a D31 do smc9118
> D31; do I need a software swap? ( I followed the schematics of rsk+ 7203 eva
> board before to learn that for big endioan processors the designer needs to
> physically swap the bytes).

I've added code to enable swap on upstream for the rsk7203. It was
needed by big endian platforms.

Please use a newer kernel if possible.

Cheers,

/ magnus
